$env.config.show_banner = false
if $nu.is-interactive {
    $env.config.edit_mode = 'emacs'
    $env.config.completions.algorithm = 'prefix'
    $env.config.history.sync_on_enter = true
    $env.PROMPT_COMMAND = {|| $env.PWD }
    $env.PROMPT_COMMAND_RIGHT = {|| '' }

    if (which direnv | is-not-empty) {
        $env.config.hooks.env_change.PWD = ($env.config.hooks.env_change.PWD? | default [])
        $env.config.hooks.env_change.PWD ++= [{||
            let changes = (^direnv export json | from json | default {})
            for entry in ($changes | transpose name value) {
                if $entry.value == null {
                    hide-env -i $entry.name
                } else if $entry.name == 'PATH' {
                    $env.PATH = ($entry.value | split row (char esep))
                } else {
                    load-env {($entry.name): $entry.value}
                }
            }
        }]
    }
} else {
    $env.config.use_ansi_coloring = false
}
