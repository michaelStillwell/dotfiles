function znc
	function cp_if_good -a path force
		if test -z "$force"; and test -e ./shell.nix
			echo 'WARN: you have a shell.nix already' 
			return 1
		end

		if not test -e $path
			echo "WARN: $path not found"
			return 1
		end

		echo "copying $path..."
		cp $path ./shell.nix
		and echo "done" 

		return 0
	end

	argparse 'h/help' 'n/name=' 'f/force' -- $argv
	or return

	if set -ql _flag_h
		echo "Usage: znc [-h | --help] [-n | --name=NAME] [-f | --force]" >&2
		return 1
	end

	set -l force
	set -ql _flag_f
	and set force $_flag_f

	set -l name
	set -ql _flag_name[1]
	and set name $_flag_name[-1]

	if test -n "$name"
		set found (
			find ~/dotfiles/nixos/shells . \
				-maxdepth 2 \
				-type f \
				-name "$name.nix" \
				! -path '**/configuration.nix' \
		)

		if test (count $found) -eq 0; or not test -e $found
			echo 'not found'
			return 1
		end

		cp_if_good $found $force 
	else
		set selected ( \
				find ~/dotfiles/nixos/shells . \
					-maxdepth 2 \
					-type f \
					-name '*.nix' \
					! -path '**/configuration.nix' | \
				fzf --tac \
			)

		if test (count $selected) -eq 0; or not test -e $selected
			echo 'no shell was selected'
			return 1
		end

		cp_if_good $selected $force 
	end
end

function zns
	set selected ( \
		find ~/dotfiles/nixos/shells . \
			-maxdepth 2 \
			-type f \
			-name '*.nix' \
			! -path '**/configuration.nix' | \
		fzf --tac \
	)

	if not test -e $argv
		command zellij run -- nix-shell $selected --run $argv
	else
		command zellij run -- nix-shell $selected
	end
end

function znsr
	set selected ( \
		find ~/dotfiles/nixos/shells . \
			-maxdepth 2 \
			-type f \
			-name '*.nix' \
			! -path '**/configuration.nix' | \
		fzf --tac \
	)

	read -P "Enter command to run: " cmd

	if test -e $cmd
		return 0
	end

	command zellij run -- nix-shell $selected --run $cmd
end
