# Nu exports PATH as a platform-delimited string to external programs.
let brew = if $nu.os-info.arch == 'aarch64' { '/opt/homebrew' } else { '/usr/local' }
$env.PATH = ([
    ($nu.home-dir | path join '.local/bin')
    ($nu.home-dir | path join 'bin')
    ($brew | path join bin)
    ($brew | path join sbin)
] | where { path exists } | append $env.PATH
  | append ['/usr/bin' '/bin' '/usr/sbin' '/sbin'] | uniq)
