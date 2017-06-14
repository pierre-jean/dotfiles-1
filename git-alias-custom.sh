alias gpl='git prunelocal'
alias gpr='git pull-request'
alias gdl='git discard'
alias glrb='git pull --rebase'

gblame() { 
  git log -p -M --follow --stat -- $1
}

## Autocompleted alias
__git_complete gco _git_checkout
__git_complete gb _git_branch
__git_complete gba _git_branch
__git_complete gbd _git_branch
__git_complete gbda _git_branch
__git_complete gbl _git_branch
__git_complete gbnm _git_branch
__git_complete gbr _git_branch
__git_complete gm _git_branch
__git_complete gd _git_branch
__git_complete gc _git_commit
__git_complete gl _git_pull
__git_complete grb _git_rebase
__git_complete gp _git_push
