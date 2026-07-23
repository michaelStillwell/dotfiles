#!/usr/bin/env fish

function handle
	argparse 'f/force' -- $argv
	or return 1

	set -l force
	set -ql _flag_f
	and set force $_flag_f

	set monitors (hyprctl monitors all -j)
	if not test -z "$force"
		set length (echo $monitors | jq 'length')

		if test $length -gt 1
			hyprctl keyword monitor eDP-1,disabled
		end

		return 0
	end

	set disabled (echo $monitors | jq '.[0] | .disabled')
	or return 1

	if test "$disabled" = "true"
		hyprctl keyword monitor eDP-1,preferred,auto,auto
	else
		hyprctl keyword monitor eDP-1,disabled
	end
end

handle $argv


# vim: ft=fish
