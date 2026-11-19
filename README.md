# Personal macOS dotfiles

This checkout installs copies of two Nushell startup files and a short personal Codex instruction. It supports Python 3.9+ (standard library) and targets Nushell 0.117.0. The MBP baseline was Python 3.14.7, Codex CLI 0.170.0 and optional direnv 2.37.1.

## Bootstrap and update

Install Homebrew and Git if needed, then run `brew install nushell` if `nu --version` is unavailable. Clone `git@github.com:stuartrexking/dotfiles.git`, enter the checkout, and run:

```sh
python3 test_install.py
python3 install.py --dry-run
python3 install.py --apply
```

An existing, different Nu file requires review. Compare the paths printed by the preview with their sources below. Use `python3 install.py --apply --replace-nu` to back up and replace them. For updates, check `git status --short --branch`, fast-forward a clean master with `git pull --ff-only`, then repeat the three steps. Start a fresh shell and Codex session to pick up changes.

| Source | Runtime destination | Installation behavior |
| --- | --- | --- |
| nushell/env.nu | Nu’s `$nu.env-path` | Copy PATH setup |
| nushell/config.nu | Nu’s `$nu.config-path` | Copy interactive settings |
| codex/AGENTS.md | `$CODEX_HOME/AGENTS.md` (default `~/.codex/AGENTS.md`) | Add or refresh only the marked personal block |
| codex/config.example.toml | `$CODEX_HOME/config.toml` | Seed a missing file with a commented example. Existing TOML is preserved. |

The installer discovers paths using `nu -n` and refuses symlinks or destinations outside the home. Keep machine-specific Nu commands in `90-machine.local.nu` in the directory reported by `$nu.user-autoload-dirs | first`. Nu loads this after config.nu in interactive startup. Keep private environment values in the machine’s existing secret store or authorized direnv environment. Personal plugins, providers, trust, auth and project settings stay on each machine. Repository AGENTS.md governs maintenance here. Global AGENTS.override.md, if present, takes precedence over the installed personal guidance.

## Using Nu

Open a login terminal for the personal PATH, working-directory prompt, Emacs editing, prefix completion and synchronized history. Existing plaintext history remains usable. When direnv is installed, the interactive directory-change hook consumes its JSON changes, removes unset variables and converts PATH back to a Nu list. Review and authorize each project’s .envrc locally. For a batch process requiring project variables, use `direnv exec . PROGRAM ARG...` in an already authorized directory.

Batch `nu -c` and scripts normally inherit their caller’s environment and skip personal startup. A scheduler can invoke Nu by absolute path and pass `--env-config` and `--config` with the discovered paths if it needs these settings. For example, in Nu:

```nu
^nu --env-config $nu.env-path --config $nu.config-path -c 'which git | select command path | to json --raw'
^printf '[{"id":7}]' | from json | get 0.id
```

Use `^name` to select an external program. Use `complete` to inspect stdout, stderr and exit_code as a record. Keep an external command last when its status should be the Nu process status.

## Recovery and login shell

Each changing run prints a private UTC-timestamped directory under `~/.local/state/personal-dotfiles/backups/`. Under `previous/`, files mirror their original paths relative to home. `created.json` lists destinations absent before the run. For rollback inspect the latest backup, compare current files privately and save later edits separately. Copy previous files back to the corresponding home paths with `cp -p`. Remove files listed in created.json only after confirming they still contain the installed content. If a seeded TOML now holds machine settings, retain it. For a full uninstall repeat in reverse timestamp order or remove only the marked guidance block from a subsequently edited AGENTS.md. The same records support recovery after an interrupted apply.

Before switching login shells, record the current account shell with `dscl . -read /Users/USERNAME UserShell`. Check that the absolute Nu executable appears as a full line in /etc/shells. If needed, add that single path with local administrator authentication. Run `chsh -s /absolute/path/to/nu` and verify the account record and a new login terminal. To revert, run chsh with the recorded previous shell. Existing zsh files remain available.

## References

- [Nushell startup order, configuration and autoload directories](https://www.nushell.sh/book/configuration.html)
- [Nushell stdout, stderr and exit codes](https://www.nushell.sh/book/stdout_stderr_exit_codes.html)
- [direnv’s Nushell hook](https://direnv.net/docs/hook.html#nushell)
- [OpenAI global and project instructions](https://developers.openai.com/codex/guides/agents-md/)
- [OpenAI Codex settings reference](https://developers.openai.com/codex/config-reference/)
