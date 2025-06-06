# Shell aliases
alias vi='vim'
alias la='ls -lah'
alias ll='ls -lh'
alias lt='ls -lht'
alias rm='rm -iv'
alias dirs='dirs -v'
alias mv='mv -v'
alias df='df -h'
alias du='du -h'
alias top='top -s3 -n30'

# App aliases
alias py='/opt/homebrew/bin/python3'
alias sql='sqlite3'
alias bcli='bitcoin-cli'
alias signet='bitcoin-cli -signet'
alias regtest='bitcoin-cli -regtest'
alias cdbtc='cd ~/Library/Application\ Support/Bitcoin'
alias pgup='brew services run postgresql@14'
alias pgdn='brew services stop postgresql@14'
alias dl='deepl'

# Default prompt - name@host, 1dir~
# PS1='%n@%m %1~ %# '

# Custom prompts
# username + last two directory names
# PS1='%F{cyan}%n %2~ %f%# '

# No name prompt
PS1='%F{cyan}%2~ %f%# '
