########################################################################
# Imports
for f in functions aliases vars; do
    source ~/.zsh-${f}
done

fpath=(~/.zsh-etc $fpath)

########################################################################
# Color Config
autoload -U colors && colors

for COLOR in RED GREEN YELLOW WHITE BLACK CYAN BLUE PURPLE; do
    eval PR_$COLOR='%{$fg[${(L)COLOR}]%}'         
    eval PR_BRIGHT_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
done                                                 
PR_RESET="%{${reset_color}%}";                       

########################################################################
# VCS Info Config
setopt prompt_subst # Allows variable substitution to take place in the prompt
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git cvs svn
zstyle ':vcs_info:*:prompt:*' check-for-changes true
zstyle ':vcs_info:*:prompt:*' unstagedstr "${PR_BRIGHT_YELLOW}*${PR_RESET}"
zstyle ':vcs_info:*:prompt:*' stagedstr "${PR_BRIGHT_YELLOW}+${PR_RESET}"
zstyle ':vcs_info:*:prompt:*' formats  " ${PR_BRIGHT_RED}(%b${PR_RESET}%c%u${PR_BRIGHT_RED})${PR_RESET}"              "%a"
zstyle ':vcs_info:*:prompt:*' actionformats  " ${PR_BRIGHT_RED}(%b|%a)${PR_RESET}"              "%a"
zstyle ':vcs_info:*:prompt:*' nvcsformats   ""                             "%~"
zstyle ':vcs_info:*:prompt:*' branchformat  "%b:%r"              ""

########################################################################
# Actual Prompt Configuration
# Produces an effect like:
#     <tbielawa>@(deepfryer)[~/rhat/puppet-mods/datasources] 12:01:19  (master+) 
#     $ 

# Need this to enable vcs_info_msg in the PROMPT
precmd(){
    vcs_info 'prompt'
}

PROMPT='<%B%F{blue}%n%f%b>@(%F{green}%m%f)[%~] %* ${vcs_info_msg_0_} 
%(!.#.$) '

########################################################################
# Setting Screen window name
setopt extended_glob
preexec () {
    if [[ "$TERM" == "screen" ]]; then
	local CMD=${1[(wr)^(*=*|sudo|-*)]}
	echo -ne "\ek$CMD\e\\"
    fi
}
########################################################################
# Whatever else
setopt nonomatch # Pass wildcard glob to commands when zsh can't do the match
                 # Really handy for scp'ing the contents of a directory
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select=2 # Show menu selection when completion > 2 options
# Remove forward slashes and periods from "word characters"
WORDCHARS="${WORDCHARS:s#/#}"
WORDCHARS="${WORDCHARS:s#.#}"
