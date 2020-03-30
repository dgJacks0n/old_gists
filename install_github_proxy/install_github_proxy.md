## Issue
Installing R packages from **public** github (https://github.com) using devtools fails to connect through a proxy server even if other R internet commands (e.g. `install.packages`). work.  This is because `devtools` uses `httr` and does not pick up general proxy settings.

## Solution
Use `httr::set_config` to set the proxy server:
```
httr::set_config(httr::use_proxy("<proxy url>", <proxy port>))
devtools::install_github("user-/reponame") # install from reponame repo belonging to user user
```

Note: the default proxy port is 8080.

## Citation
https://github.com/hadley/devtools/issues/656