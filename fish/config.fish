if status is-interactive
    # Commands to run in interactive sessions can go here
end

abbr -a ssh "TERM=xterm-256color ssh -Y"
abbr -a new "detach alacritty"

alias nvim="SHELL=/bin/bash /bin/nvim"

function detach
    $argv &>/dev/null & disown
end

function bash-source
    exec bash -c "source $argv; exec fish"
end
