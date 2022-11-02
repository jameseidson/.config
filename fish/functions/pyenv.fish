function pyenv
  switch $argv
    case "new"
      python -m venv .venv
    case "activate"
      . .venv/bin/activate.fish
    case "deactivate"
      deactivate
    case "*"
      return 1
  end
end
