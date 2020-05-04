set -x fish_user_paths $HOME/.rbenv/bin $fish_user_paths
set -x fish_user_paths $HOME/n/bin $fish_user_paths

status --is-interactive; and source (rbenv init -|psub)

set JAVA_HOME /usr/lib/jvm/default-java

alias g=git

alias ag="ag --path-to-ignore ~/.ignore"

# Remove obsoleted local branch (removed on remote)
# alias git-clean-branches="git remote prune origin; git branch -vv | grep 'origin/.*: gone]' | awk '{print \$1}' | grep -v ci | xargs git b -D"
# alias git-remove-branches="git branch -D (git branch | ag $argv)"

function git-clean-branches
  git remote prune origin;
  git branch -vv | grep 'origin/.*: gone]' | awk '{print $1}' | grep -v ci | xargs git b -D $argv;
end

function git-remove-branches
  git branch | grep $argv | xargs git branch -D
end

alias done='export msg=(echo Fix:\n(git st --porcelain -s | grep -v "^??" | cut -c4- | paste -sd\n)); g c -am "$msg"'

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

if status is-interactive
  cd "$HOME/dev/equalizer"
end

# These settings are related to equalizer
set PRIVATE_GEM_SOURCE_URI https://private-gems-etbu6gsddybg.wovn.io

# Run Rubocop auto-correct over modified files
function rubo
  git status --porcelain | cut -c4- | grep '\.rb\|\.rake$' | grep -v "\->" | grep -v 'db/schema.rb' | xargs bundle exec rubocop --auto-correct
end

alias rbf="bundle exec rubocop --auto-correct"

# Connecting to mysql using TCP protocol since we're using mysql docker container
alias mysql="mysql --protocol=tcp -u root"

