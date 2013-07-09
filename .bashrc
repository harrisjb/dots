PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'
alias be="bundle exec"
alias ber="bundle exec rspec"
alias bpry='require "pry";binding.pry'
alias ga='git add'
alias gaa='git add --all'
alias gamend='git commit --amend'
alias gbr='git branch --color -v -v'
alias gba='git branch -a'
alias gbl='git blame'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gchurn='git churn'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcot='git checkout -t'
alias gchanges='git diff --name-status -r'
alias gcp='git cherry-pick'
alias gd='git diff'
alias gdc='git diff --cached'
alias gdiffstat='git diff --stat -r'
alias gg='git grep --color --line-number --extended-regexp --ignore-case --break'
alias gl='!git_pretty_log'
alias glog='git log --date=relative --pretty=format:""'
alias glogbig='git log --graph --abbrev-commit --date=relative --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset"'
alias glogp='git log --pretty=format:"%h %s" --graph'
alias glog1='git log --graph --abbrev-commit --decorate --date=relative --format=format:"%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)" --all'
alias glog2='git log --graph --abbrev-commit --decorate --format=format:"%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n%C(white)%s%C(reset) %C(dim white)- %an%C(reset)" --all'
alias gm='git merge'
alias gp='git pull --rebase'
alias gpu='git push -u origin'
alias gr='git rebase -i'
alias gs='git status -s'
alias gw='git whatchanged'
alias ip='sh ip-addr'
alias rc="rails console"
alias rs="rails server"
alias raw="git raw"
