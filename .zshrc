# oh-my-zsh needs to be installed, here is my default path
export ZSH=/home/thilo/.oh-my-zsh

# basic zsh settings
ZSH_THEME="fishy"
CASE_SENSITIVE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

# plugins
plugins=(
  git,
  archlinux,
  aterminal,
  bower,
  composer,
  common-aliases,
  gradle,
  npm,
  sudo
)

source $ZSH/oh-my-zsh.sh
export LANG=en_US.UTF-8

# set editor
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='code-oss'
fi

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# Aliasses
alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"
alias code="code-oss"
alias upgrade-arch="pacman -Syu"

# functions
# extract package
ex() {
    if [[ -f $1 ]]; then
        case $1 in
          *.tar.bz2) tar xvjf $1;;
          *.tar.gz) tar xvzf $1;;
          *.tar.xz) tar xvJf $1;;
          *.tar.lzma) tar --lzma xvf $1;;
          *.bz2) bunzip $1;;
          *.rar) unrar $1;;
          *.gz) gunzip $1;;
          *.tar) tar xvf $1;;
          *.tbz2) tar xvjf $1;;
          *.tgz) tar xvzf $1;;
          *.zip) unzip $1;;
          *.Z) uncompress $1;;
          *.7z) 7z x $1;;
          *.dmg) hdiutul mount $1;; # mount OS X disk images
          *) echo "'$1' cannot be extracted via >ex<";;
    esac
    else
        echo "'$1' is not a valid file"
    fi
}