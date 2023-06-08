if status is-interactive
    # Commands to run in interactive sessions can go here
end

abbr -a ssh "TERM=xterm-256color ssh -Y" 
abbr -a new "alacritty &> /dev/null & disown"
abbr -a rmswap "rm -rf ~/.local/state/nvim/swap"
# abbr -a hx "helix"
