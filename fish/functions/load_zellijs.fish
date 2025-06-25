function load_zellijs
	set files (find ~/.config/fish/functions/zellijs -name '*.fish')

	for file in $files
		source $file
	end
end

