source /Users/jsh/.bashrc
homebrew=/usr/local/bin:/usr/local/sbin
export PATH=$homebrew:$PATH
export EDITOR=vi
PATH=/usr/local/mysql/bin:/usr/local/bin:$PATH

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
source /Users/jsh/.rvm/scripts/rvm

# Color Constants

RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
EEN="\[\033[0;32m\]"
BLUE="\[\033[0;34m\]"
LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
WHITE="\[\033[1;37m\]"
LIGHT_GRAY="\[\033[0;37m\]"
COLOR_NONE="\[\e[0m\]"

# Functions to build prompt with git branch info
function parse_git_branch {

git rev-parse --git-dir &> /dev/null
git_status="$(git status 2> /dev/null)"
branch_pattern="^# On branch ([^${IFS}]*)"
remote_pattern="# Your branch is (.*) of"
diverge_pattern="# Your branch and (.*) have diverged"
if [[ ! ${git_status} =~ "working directory clean" ]]; then
	state="${RED}⚡"
fi
# add an else if or two here if you want to get more specific
if [[ ${git_status} =~ ${remote_pattern} ]]; then
	if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
		remote="${YELLOW}↑"
	else
		remote="${YELLOW}↓"
	fi
fi
if [[ ${git_status} =~ ${diverge_pattern} ]]; then
	remote="${YELLOW}↕"
fi
if [[ ${git_status} =~ ${branch_pattern} ]]; then
	branch=${BASH_REMATCH[1]}
	echo " (${branch})${remote}${state}"
fi
}

function prompt_func() {
previous_return_value=$?;
# prompt="${TITLEBAR}$BLUE[$RED\w$GREEN$(__git_ps1)$YELLOW$(git_dirty_flag)$BLUE]$COLOR_NONE "
prompt="\w${GREEN}$(parse_git_branch)${COLOR_NONE}"
PS1="${prompt} $ "
}

PROMPT_COMMAND=prompt_func
