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
# set -x RUSTPATH $HOME/.cargo/bin

# scripts
set -x MYSCRIPTS $HOME/.local/scripts

# gleam
set -x GLEAMPATH /usr/local/gleam/bin

# deno
set -x DENOPATH $HOME/.deno/bin

# vlang
set -x VLANGPATH $HOME/.vlang

# dotnet
set -x DOTNETPATH $HOME/.dotnet
set DOTNET_ROOT $HOME/.dotnet

# opencode
set -x OPENCODEPATH $HOME/.opencode/bin

# PATH
set -x PATH $PATH $GOPATH/bin $MYSCRIPTS $TURSOPATH $GLEAMPATH $DENOPATH $VLANGPATH $DOTNETPATH $OPENCODEPATH

# Godot
alias gd3='~/Documents/Apps/Godot3/Godot'
alias gd4='~/Documents/Apps/Godot4/Godot'
alias gvim='nvim --listen ./godothost' # need to be at root of a project

# aliaseseses
alias so='source ~/.config/fish/config.fish'
alias nv='nvim'

# because js is dumb
alias i-js='sudo npm install -g svelte-server typescript-language-server typescript tree-sitter-svelte'

# default overrides
alias ls='exa -1 -s name -s type'
alias ll='exa -l -s name -s type'
alias la='exa -al -s name -s type'
alias lt='exa -T -s name -s type'

function proj
    set selected_file ( \
		find /mnt/NewSSD/2023 -type d \( -name 'node_modules' -o -name 'target' -o -name '.*' \) -prune -o -print | \
		fzf --prompt='Select a project file: ' --preview 'bat --style=numbers --color=always {}' --preview-window=right:60% \
	)

    if test -n "$selected_file"
        cd (dirname "$selected_file")
        zl (basename "$selected_file")
    else
        echo "No file selected. Aborting."
    end
end


# zoxide
zoxide init fish | source

# Generated for envman. Do not edit.
test -s ~/.config/envman/load.fish; and source ~/.config/envman/load.fish

# source zellij helper functions
load_zellijs
