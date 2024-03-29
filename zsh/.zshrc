#Fix the java gui problem
export _JAVA_AWT_WM_NONREPARENTING=1

# Enable Powerlevel10k instant prompt. Should stay at the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory


# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

source ~/powerlevel10k/powerlevel10k.zsh-theme

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Plugins
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-sudo/sudo.plugin.zsh
source /usr/share/zsh-nmap/nmap.plugin.zsh


#ADD $PATH
#PATH=...

#Secure delete
#Scrubs borra la tabla de indices
#Shred para hacer todo a ceros y random
function rmk(){
    scrub -p dod $1; shred -zun 10 -v $1
}

# Set 'man' colors
function man() {
    env \
    LESS_TERMCAP_mb=$'\e[01;31m' \
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    man "$@"
}


# Extract nmap information
function extractPorts(){
	ports="$(cat $1 | grep -oP '\d{1,5}/open' | awk '{print $1}' FS='/' | xargs | tr ' ' ',')"
	ip_address="$(cat $1 | grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' | sort -u | head -n 1)"
	echo -e "\n[*] Extracting information...\n" > extractPorts.tmp
	echo -e "\t[*] IP Address: $ip_address"  >> extractPorts.tmp
	echo -e "\t[*] Open ports: $ports\n"  >> extractPorts.tmp
	echo $ports | tr -d '\n' | xclip -sel clip
	echo -e "[*] Ports copied to clipboard\n"  >> extractPorts.tmp
	cat extractPorts.tmp; rm extractPorts.tmp
}

# fzf improvement
function fzf-lovely(){

	if [ "$1" = "h" ]; then
		fzf -m --reverse --preview-window down:20 --preview '[[ $(file --mime {}) =~ binary ]] &&
 	                echo {} is a binary file ||
	                 (bat --style=numbers --color=always {} ||
	                  highlight -O ansi -l {} ||
	                  coderay {} ||
	                  rougify {} ||
	                  cat {}) 2> /dev/null | head -500'

	else
	        fzf -m --preview '[[ $(file --mime {}) =~ binary ]] &&
	                         echo {} is a binary file ||
	                         (bat --style=numbers --color=always {} ||
	                          highlight -O ansi -l {} ||
	                          coderay {} ||
	                          rougify {} ||
	                          cat {}) 2> /dev/null | head -500'
	fi
}

# Cronometro
function crono(){
    date1=`date +%s`; 
    while true 
    do 
        echo -ne "$(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)\r"; 
    done
}

function check_writing(){
    # https://matt.might.net/articles/shell-scripts-for-passive-voice-weasel-words-duplicates/

    # check arguments
    if [ "$1" = "" ]; then 
        echo "Add argument: <file> ...\n"
        return
    fi

    echo "[*] Checking the writing of the file/s... \n"

    for var in "$@"; do
        echo -e "-------------[$var]-------------"
        # ---------- Check TO-DOs and fix
        # Example: "\todo or \fix"
        echo "[*] Checking for todo's or fix's..."
        todo="todo|to-do|TO-DO|fix"
        egrep -i -n --color "\\b($todo)\\b" $var

        # ---------- Check for duplicates
        # Example: "of of"
        echo "[*] Checking duplications..."
        grep -noP --color "\b(\w+)\s+\1\b" $var 

        # ---------- Check Weasel words
        # Example: "Many studies..."
        echo "[*] Checking weasel words..."
        weasels="many|various|very|fairly|several|extremely\
        |exceedingly|quite|remarkably|few|surprisingly\
        |mostly|largely|huge|tiny|((are|is) a number)\
        |excellent|interestingly|significantly\
        |substantially|clearly|vast|relatively|completely\
        |almost|basically|some|most|enough|vast|various"

        egrep -i -n --color "\\b($weasels)\\b" $var

        # ---------- Check for passives
        echo "[*] Checking passives..."
        irregulars="awoken|\
        been|born|beat|\
        become|begun|bent|\
        beset|bet|bid|\
        bidden|bound|bitten|\
        bled|blown|broken|\
        bred|brought|broadcast|\
        built|burnt|burst|\
        bought|cast|caught|\
        chosen|clung|come|\
        cost|crept|cut|\
        dealt|dug|dived|\
        done|drawn|dreamt|\
        driven|drunk|eaten|fallen|\
        fed|felt|fought|found|\
        fit|fled|flung|flown|\
        forbidden|forgotten|\
        foregone|forgiven|\
        forsaken|frozen|\
        gotten|given|gone|\
        ground|grown|hung|\
        heard|hidden|hit|\
        held|hurt|kept|knelt|\
        knit|known|laid|led|\
        leapt|learnt|left|\
        lent|let|lain|lighted|\
        lost|made|meant|met|\
        misspelt|mistaken|mown|\
        overcome|overdone|overtaken|\
        overthrown|paid|pled|proven|\
        put|quit|read|rid|ridden|\
        rung|risen|run|sawn|said|\
        seen|sought|sold|sent|\
        set|sewn|shaken|shaven|\
        shorn|shed|shone|shod|\
        shot|shown|shrunk|shut|\
        sung|sunk|sat|slept|\
        slain|slid|slung|slit|\
        smitten|sown|spoken|sped|\
        spent|spilt|spun|spit|\
        split|spread|sprung|stood|\
        stolen|stuck|stung|stunk|\
        stridden|struck|strung|\
        striven|sworn|swept|\
        swollen|swum|swung|taken|\
        taught|torn|told|thought|\
        thrived|thrown|thrust|\
        trodden|understood|upheld|\
        upset|woken|worn|woven|\
        wed|wept|wound|won|\
        withheld|withstood|wrung|\
        written"

        egrep -n -i --color \
        "\\b(am|are|were|being|is|been|was|be)\
        \\b[ ]*(\w+ed|($irregulars))\\b" $var
        

        # ---------- Check with Aspell
        echo "[*] Should we check with Aspell?(y/n)"
        read yn
        case $yn in
            [Yy]* )aspell --master=en_US --lang=en_US -c $var;;
        esac
    done
}

SAVEHIST=1000
HISTFILE=~/.zsh_history


#Manual aliases
alias ll='lsd -lh --group-dirs=first'
alias la='lsd -a --group-dirs=first'
alias l='lsd --group-dirs=first'
alias lla='lsd -lha --group-dirs=first'
alias ls='lsd --group-dirs=first'
alias batnl='bat --paging=never'


# Finalize Powerlevel10k instant prompt. Should stay at the bottom of ~/.zshrc.
(( ! ${+functions[p10k-instant-prompt-finalize]} )) || p10k-instant-prompt-finalize
