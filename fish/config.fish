if status is-interactive
    # Commands to run in interactive sessions can go here
end

abbr -a -U ssh ssh TERM=xterm-256color ssh
abbr -a -U new "alacritty &> /dev/null & disown"
