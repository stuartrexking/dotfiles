"""Install personal configuration copies. Preview by default."""
import argparse
import fcntl
import json
import os
from datetime import datetime, timezone
from pathlib import Path
import shutil
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parent
HOME = Path.home().resolve()


def checked(path):
    """Limit writes to ordinary files in the home, outside the checkout."""
    path = Path(path)
    if (not path.is_relative_to(HOME) or path.is_relative_to(ROOT)
            or path.resolve() != path or path == HOME):
        raise SystemExit(f"Unexpected location or symlink: {path}")
    return path


def guidance(old, block):
    begin, end = block.splitlines()[0], block.splitlines()[-1]
    if begin not in old and end not in old:
        return old + (b"\n\n" if old else b"") + block
    if old.count(begin) != 1 or old.count(end) != 1 or old.index(begin) > old.index(end):
        raise SystemExit("Ambiguous personal guidance markers. Review AGENTS.md locally.")
    first, rest = old.split(begin)
    return first + block.rstrip(b"\n") + rest.split(end)[1]


def run(args):
    config_dir, env_path, config_path = json.loads(subprocess.check_output(
        ["nu", "-n", "-c", "[$nu.default-config-dir $nu.env-path $nu.config-path] | to json"]))
    for name, actual in [("env.nu", env_path), ("config.nu", config_path)]:
        if checked(Path(config_dir) / name) != Path(actual):
            raise SystemExit(f"Unexpected resolved Nu target: {actual}")
    codex = Path(os.environ.get("CODEX_HOME") or HOME / ".codex")
    mapping = {
        "nushell/env.nu": env_path,
        "nushell/config.nu": config_path,
        "codex/AGENTS.md": codex / "AGENTS.md",
        "codex/config.example.toml": codex / "config.toml",
    }
    changes = []
    conflicts = []
    for source, dest in mapping.items():
        dest = checked(dest)
        if dest.exists() and not dest.is_file():
            raise SystemExit(f"Expected regular file: {dest}")
        if source.endswith(".toml") and dest.exists():
            print("Preserve", dest)
            continue
        old = dest.read_bytes() if dest.exists() else None
        new = (ROOT / source).read_bytes()
        if source.endswith(".md"):
            new = guidance(old or b"", new)
        if new == old:
            print("Current ", dest)
            continue
        print("Create  " if old is None else "Back up and update", dest)
        if source.startswith("nushell/") and old is not None:
            conflicts.append(dest)
        changes.append((dest, old, new))
    if not args.apply or not changes:
        return
    if conflicts and not args.replace_nu:
        raise SystemExit("Review Nu changes, then use --apply --replace-nu to back up and replace.")
    stamp = datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%S.%fZ")
    backup = checked(HOME / ".local/state/personal-dotfiles/backups" / stamp)
    backup.mkdir(parents=True, mode=0o700)
    print("Recovery directory:", backup, flush=True)
    created = []
    for dest, old, _ in changes:
        if old is None:
            created.append(str(dest))
        else:
            copy = backup / "previous" / dest.relative_to(HOME)
            copy.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(dest, copy)
    (backup / "created.json").write_text(json.dumps(created, indent=2) + "\n")
    for dest, old, new in changes:
        checked(dest)
        if (dest.read_bytes() if dest.exists() else None) != old:
            raise SystemExit(f"Changed during installation: {dest}. Inspect recovery directory.")
        dest.parent.mkdir(parents=True, exist_ok=True)
        with tempfile.NamedTemporaryFile(dir=dest.parent, delete=False) as tmp:
            temp = Path(tmp.name)
            try:
                tmp.write(new)
                tmp.flush()
                if old is None:
                    os.link(temp, dest)  # Never clobber a concurrently created file.
                else:
                    os.replace(temp, dest)
            finally:
                temp.unlink(missing_ok=True)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    mode = parser.add_mutually_exclusive_group()
    mode.add_argument("--apply", action="store_true")
    mode.add_argument("--dry-run", action="store_true")
    parser.add_argument("--replace-nu", action="store_true")
    args = parser.parse_args()
    # Serialize installers without creating a lock file during preview.
    fd = os.open(HOME, os.O_RDONLY)
    try:
        fcntl.flock(fd, fcntl.LOCK_EX)
        run(args)
    finally:
        os.close(fd)
