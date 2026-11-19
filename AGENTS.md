# Maintaining this checkout

Keep tracked sources portable across both Macs. Use the shared nushell skill when available. Check the local Nu version and command help before changing startup syntax. Read README.md for installation targets, machine overrides and recovery.

Run `python3 test_install.py` against a disposable home and `python3 install.py --dry-run` before applying. Exercise both interactive startup and an external command that fails. Keep backup directories outside Git. Stage explicit source paths. Never populate the repository from the contents of a live Codex home or a project environment.

The guidance in codex/AGENTS.md is a personal installation source. This file applies only to development of the dotfiles repository.
