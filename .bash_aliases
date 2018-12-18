alias more=less

# ls aliases
alias ls='ls -h --color'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lr='ls -R'     # recursive ls

# grep aliases
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# cd aliases
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias Bureau="cd ~/Bureau"
alias Telechargements="cd ~/Téléchargements"
alias Documents="cd ~/Documents"
alias Musique="cd ~/Musique"
alias Video="cd ~/Vidéos"

alias wj='cd ~/dev/java'
alias wj='cd ~/dev/javascript'
alias wg='cd ~/dev/go'
alias wgs='cd ~/dev/go/src'
alias ws='cd ~/dev/shell'
alias wd='cd ~/dev/docs'

# Memory du & df
alias df='df -h'
alias du='du -c -h'
alias h='history'

# editor aliases
alias e="emacs"
alias enw="emacs -nw"

# git aliases
alias ga='git add'
alias gaa='git add .'
alias gaaa='git add --all'
alias gap='git add -p'
alias gau='git add --update'

alias gc='git commit --verbose'
alias gcf='git commit --fixup'
alias gcm='git commit --message'
alias gca='git commit -a --verbose'
alias gcam='git commit -a -m'
alias gc!='git commit --amend --verbose'
alias gca!='git commit --amend -a --verbose'
alias gcam!='git commit --amend -a -m'

alias gp='git pull'
alias gpr='git pull --rebase'
# --force-with-lease abort push if remote has commits that you don't owe in local
alias gps='git push --force-with-lease'

alias gco='git checkout'
alias gcob='git checkout -b'
alias gcom='git checkout master'

alias gd='git diff'
alias gda='git diff HEAD'
alias gds='git diff'
alias gdas='git diff --stat HEAD'

alias gi='git init'

alias gm='git merge --no-ff'
alias gma='git merge --abort'
alias gmc='git merge --continue'

alias gb='git branch'
alias gbd='git branch --delete'

alias gr='git rebase'
alias gri='git rebase -i'
alias grc='git rebase --continue'
alias grs='git rebase --skip'

alias gcp='git cherry-pick'

alias gs='git status --short'
alias gsa='git status'

alias gst='git stash'
alias gsta='git stash apply'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash save'

# reset last commit (unstage)
alias gus='git reset HEAD~1'

# Get back (work dir included) to commit --> git reset --hard $commit_hash
alias grh='git reset --hard'

# Remove file (git + work dir)
alias grm='git rm'
# Remove file (just git not work dir)
alias grmc='git rm --cached'

alias glc='git log --oneline $1 | grep -v fixup | head -n 1 | cut -d " " -f 1'
alias gl="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) -%C(bold yellow)%d%C(reset) %C(bold cyan)%ad%C(reset)%C(dim green) - %an%C(reset)%n''          %C(white)%s%C(reset)' --all"
alias gls="gl --stat"
alias glb='gl --simplify-by-decoration --no-merges'


# gradle aliases
alias gcb="gradle clean build"
alias gcbt="gradle clean build -x test"
alias gcbs="gradle clean build sonarqube"