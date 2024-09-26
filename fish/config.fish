function fish_greeting
	echo ''
end

if status is-interactive
	# Commands to run in interactive sessions can go here
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# Turso
set -x TURSOPATH $HOME/.turso

# Golang
set -x GOPATH $HOME/.local/go

# Rust
set -x RUSTPATH $HOME/.cargo/bin

# scripts
set -x MYSCRIPTS $HOME/.local/scripts

# gleam
set -x GLEAMPATH /usr/local/gleam/bin

# PATH
set -x PATH $PATH $GOPATH/bin $MYSCRIPTS $RUSTPATH $TURSOPATH $GLEAMPATH

# Godot
alias gd3='~/Documents/Apps/Godot3/Godot'
alias gd4='~/Documents/Apps/Godot4/Godot'
alias gvim='nvim --listen ./godothost' # need to be at root of a project

# aliaseseses
alias so='source ~/.config/fish/config.fish'

# wezterm wallpaper
alias wzwal='nvim ~/dotfiles/wezterm/wezterm.lua +31'

# default overrides
alias ls='exa -1 -s name -s type'
alias ll='exa -l -s name -s type'
alias la='exa -al -s name -s type'
alias lt='exa -T -s name -s type'

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

function zll 
	set key '// @overwrite-me'
	set layouts ()

	set selected
	set current ~/layouts/$ZELLIJ_SESSION_NAME 
	if test -e current
		set selected (find ~/layouts/general $current . -maxdepth 1 -type f -name '*.kdl' | fzf)
	else
		set selected (find ~/layouts/general . -maxdepth 1 -type f -name '*.kdl' | fzf)
	end

	if not test -e $selected 
		echo 'Nothing selected'
		return 0
	end

	if  not test -n "$selected"
		echo 'Selected not existing broda'
		return 1
	end

	set overwrite (cat $selected | rg $key | wc -l)
	set overwriteName 'OVERWRITE-ME'

	if test $overwrite -gt 0
		command zellij action rename-tab $overwriteName
		command zellij action new-tab -l $selected
		command zellij action go-to-tab-name $overwriteName
		command zellij action close-tab
	else
		command zellij action new-tab -l $selected
	end
end

# zellij plugin development
function z-plug-build
	cargo build --target wasm32-wasi
	set filename (basename $PWD)
	zellij action start-or-reload-plugin file:"target/wasm32-wasi/debug/$filename.wasm"
end
function z-plug-build-release
	cargo build --target wasm32-wasi --release
	set filename (basename $PWD)
	zellij action start-or-reload-plugin file:"target/wasm32-wasi/release/$filename.wasm"
end

# zoxide
zoxide init fish | source

# cargo
source "$HOME/.cargo/env.fish"
