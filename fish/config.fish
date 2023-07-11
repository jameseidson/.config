if status is-interactive
    # Commands to run in interactive sessions can go here
end

abbr -a ssh "TERM=xterm-256color ssh -Y" 
abbr -a new "detach alacritty"

function detach 
  $argv &> /dev/null &; disown
end

alias nvim="SHELL=/bin/bash /bin/nvim"
