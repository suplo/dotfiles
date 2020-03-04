set -x fish_user_paths $HOME/.rbenv/bin $fish_user_paths
set -x fish_user_paths $HOME/n/bin $fish_user_paths

status --is-interactive; and source (rbenv init -|psub)

set JAVA_HOME /usr/lib/jvm/default-java

alias g=git

alias ag="ag --hidden --ignore-dir=fe/test/coverage --ignore-dir=node_modules --ignore-dir=front/__test__/unit/coverage/ --ignore-dir=app/assets/javascripts/webpack --ignore-dir=tmp"

# Remove obsoleted local branch (removed on remote)
alias git-clean-branches="git remote prune origin; git branch -vv | grep 'origin/.*: gone]' | awk '{print \$1}' | grep -v ci | xargs git b -D"

alias done='export msg=(echo Fix (git st --porcelain -s | grep -v "^??" | cut -c4-)); g c -am $msg'

# Fastly debug function
function fdebug
  curl -svo /dev/null -H "Fastly-Debug:1" $argv
end

# Fastly soft purge
function fsoft
  curl -X PURGE -H "Fastly-Soft-Purge: 1" $argv
end

# Fastly hard purge
function fhard
  curl -X PURGE $argv
end

set GOROOT /usr/local/go
set GOPATH ~/go
set PATH $GOROOT/bin $GOPATH/bin $PATH

# Key-binding for fzf
set -U FZF_LEGACY_KEYBINDINGS 0
source ~/anaconda3/etc/fish/conf.d/conda.fish

# Using exa instead of ls
alias ls=exa
alias rc="bundle exec rails console"

# autojump, smart directory navigation
if test -f /home/dat/.autojump/share/autojump/autojump.fish; . /home/dat/.autojump/share/autojump/autojump.fish; end
