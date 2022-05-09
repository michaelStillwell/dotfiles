function read_confirm
  while true
    read -p 'echo "Confirm? (y/N):"' -l confirm

    switch $confirm
      case Y y
        return 0
      case N n
        return 1
    end
  end
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end

if type -q starship
  starship init fish | source
else
  if read_confirm
    curl -sS https://starship.rs/install.sh | sh
  end
end

# Vscode-neovim
alias ncode="code --extensions-dir \"/home/turtles/dotfiles/vscode/extensions\" --user-data-dir \"/home/turtles/dotfiles/vscode/data\""

# Nvim AppImage
alias nvim="/usr/local/bin/nvim"
alias vim="nvim"
alias vi="nvim"

# Rust
if test -d $HOME/.cargo/bin
  set -gx PATH "$HOME/.cargo/bin" $PATH
end

