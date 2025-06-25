function hyprpaper_slideshow
	set timeout "5s"

	set new_background (find ~/dotfiles/backgrounds/. -type f | shuf -n1)
	hyprctl hyprpaper preload $new_background

	sleep $timeout
	echo "Hello world"
end
