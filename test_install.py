"""Exercise real Nu startup and the installer in a disposable home."""
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile
import unittest

ROOT = Path(__file__).resolve().parent
NU = shutil.which("nu")


class Installation(unittest.TestCase):
    def test_roundtrip(self):
        with tempfile.TemporaryDirectory() as tmp:
            home = Path(tmp).resolve()
            env = {"HOME": str(home), "PATH": f"{Path(NU).parent}:/usr/bin:/bin",
                   "TERM": "xterm"}

            def call(*args, code=0, minimal=False):
                proc = subprocess.run(args, env={**env, **({"PATH": "/usr/bin:/bin"} if minimal else {})},
                                      cwd=home, capture_output=True, text=True)
                self.assertEqual(proc.returncode, code, proc.stderr)
                if code == 0:
                    self.assertEqual(proc.stderr, "")
                return proc.stdout

            def install(*args, code=0):
                return call(sys.executable, ROOT / "install.py", *args, code=code)

            ef, cf = map(Path, json.loads(call(NU, "-n", "-c", "[$nu.env-path $nu.config-path] | to json")))
            ef.parent.mkdir(parents=True, exist_ok=True)
            ef.write_text("# Existing path setup\n")
            codex = home / ".codex"
            codex.mkdir()
            guide = codex / "AGENTS.md"
            guide.write_text("Existing instructions\n")
            toml = codex / "config.toml"
            toml.write_text('# machine-local fixture\n')
            install("--dry-run")
            install("--apply", code=1)
            self.assertFalse(cf.exists())
            install("--apply", "--replace-nu")
            backups = home / ".local/state/personal-dotfiles/backups"
            backup, = backups.iterdir()
            self.assertEqual((backup / "previous" / ef.relative_to(home)).read_text(), "# Existing path setup\n")
            self.assertTrue(guide.read_text().startswith("Existing instructions\n"))
            self.assertEqual(toml.read_text(), '# machine-local fixture\n')
            install("--apply")
            self.assertEqual(list(backups.iterdir()), [backup])
            # Explicit config paths load both files for a one-shot Nu process.
            flags = [NU, "--no-history", "--env-config", ef, "--config", cf]
            result = call(*flags, "-c", """^printf '[{"n":7}]' | from json | get 0.n""", minimal=True)
            self.assertEqual(result, "7\n")
            self.assertEqual(call(*flags, "-c", "which brew git sh | length", minimal=True), "3\n")
            call(*flags, "-c", "^sh -c 'exit 17'", minimal=True, code=17)
            self.assertEqual(call(NU, "--no-history", "-e",
                                  "print ([$nu.is-interactive $env.config.show_banner (do $env.PROMPT_COMMAND)] | to json -r); exit",
                                  minimal=True).strip(), json.dumps([True, False, str(home)], separators=(",", ":")))
            self.assertEqual(call(NU, "-c", "'quiet'", minimal=True), "quiet\n")
            toml.unlink()
            install("--apply")
            self.assertEqual(toml.read_bytes(), (ROOT / "codex/config.example.toml").read_bytes())
            cf.unlink()
            cf.symlink_to(ef)
            install("--apply", "--replace-nu", code=1)
            self.assertTrue(cf.is_symlink())


if __name__ == "__main__":
    unittest.main()
