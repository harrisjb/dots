PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
alias ap="cp ../Gemfile ../Gemfile.lock ."
alias be="bundle exec"
alias ber="bundle exec rake"
alias bpry='require "pry";binding.pry'
alias elastic='elasticsearch -f -D es.config=/usr/local/opt/elasticsearch/config/elasticsearch.yml'
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
#alias gp='git pull --rebase'
alias gpu='git push -u origin'
alias gr='git rebase -i'
alias grep='/usr/local/Cellar/grep/2.16/bin/ggrep --color'
alias gs='git status -s'
alias gw='git whatchanged'
alias ip='sh ip-addr'
alias ls='ls -l -GFh'
alias ll='ls -al -GFh'
alias mkdir='mkdir -p'
alias rc="rails console"
alias rs="rails server"
alias rsp="bundle exec rspec"
alias raw="git raw"
alias sic="foreman run rails c -f Procfile.dev"
alias sigems='vim ~/.rvm/gems/ruby-2.0.0-p195@shipit/gems'
alias sireset="rake db:migrate:reset db:seed"
alias sis="foreman start -f Procfile.dev"
alias spu="bundle exec spin push"
alias tlf="tail -f"
#alias -g G='| grep'
#alias -g M='| less'
#alias -g L='| wc -l'
#alias -g ONE="| awk '{ print \$1}'"
# Rubygems
alias gi="gem install"
alias giv="gem install -v"
alias guv="gem uninstall"

alias julia="exec '/Applications/Julia-0.2.1.app/Contents/Resources/julia/bin/julia'"

 #Heroku staging
alias staging-console='heroku run console --remote staging --app ship-it-staging'
alias staging-process='watch heroku ps --remote staging --app ship-it-staging'
alias staging-releases='heroku releases --remote staging --app ship-it-staging'
alias staging-tail='heroku logs --tail --remote staging --app ship-it-staging'

 #Heroku production
alias production-console='heroku run console --remote production --app ship-it'
alias production-process='watch heroku ps --remote production --app ship-it'
alias production-releases='heroku releases --remote production --app ship-it'
alias production-tail='heroku logs --tail --remote production --app ship-it'

 #Heroku databases
#alias db-backup-production='heroku pgbackups:capture --remote production'
#alias db-copy-production-to-staging='heroku pgbackups:restore DATABASE `heroku pgbackups:url --remote production` --remote staging  --confirm `basename $PWD`-staging'

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
