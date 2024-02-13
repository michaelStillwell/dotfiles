function fish_greeting
	echo ''
end

if status is-interactive
	# Commands to run in interactive sessions can go here
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# Golang
set -x GOPATH $HOME/.local/go

# Rust
set -x RUSTPATH $HOME/.cargo/bin

# scripts
set -x MYSCRIPTS $HOME/.local/scripts

# PATH
set -x PATH $PATH $GOPATH/bin $MYSCRIPTS $RUSTPATH

# Godot
alias gd3='~/Documents/Apps/Godot3/Godot'
alias gd4='~/Documents/Apps/Godot4/Godot'
alias gvim='nvim --listen 127.0.0.1:55432'

# aliaseseses
alias so='source ~/.config/fish/config.fish'

# wezterm wallpaper
alias wzwal='nvim ~/dotfiles/wezterm/wezterm.lua +31'

# default overrides
alias ls='exa -1'
alias ll='exa -l'

# starship
starship init fish | source

function proj
	set selected_file (find /mnt/NewSSD/2023 -type d \( -name 'node_modules' -o -name 'target' -o -name '.*' \) -prune -o -print | fzf --prompt='Select a project file: ' --preview 'bat --style=numbers --color=always {}' --preview-window=right:60%)

	if test -n "$selected_file"
		cd (dirname "$selected_file")
		zl (basename "$selected_file")
	else
		echo "No file selected. Aborting."
	end
end

# zellij stuffs
function zl
	if test (count $argv) -eq 0
		zellij
	else
		zellij attach --create $argv
	end
end
function zr
	command zellij run --name "$argv" -- fish -c "$argv"
end
function zrf
	command zellij run --name "$argv" --floating -- fish -c "$argv"
end
function zri
	command zellij run --name "$argv" --in-place -- fish -c "$argv"
end
function ze
	command zellij edit $argv
end
function zef
	command zellij edit --floating $argv
end

