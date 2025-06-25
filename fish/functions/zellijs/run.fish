function hidad
	echo hi daddy
end

function zrf
    command zellij run --name "$argv" --floating -- fish -c "$argv"
end

function zr
    command zellij run --name "$argv" -- fish -c "$argv"
end

function zl
    if test (count $argv) -eq 0
        zellij
    else
        zellij attach --create $argv
    end
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
