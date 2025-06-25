set LAYOUTS_PATH ~/dotfiles/zellij/layouts

function zcp
    set layouts ()

    set selected
    set current $LAYOUTS_PATH/$ZELLIJ_SESSION_NAME
    if test -e current
        set selected (find $LAYOUTS_PATH $current . -maxdepth 3 -type f -name '*.kdl' | fzf)
    else
        set selected (find $LAYOUTS_PATH . -maxdepth 3 -type f -name '*.kdl' | fzf)
    end

    if not test -e $selected
        echo 'Nothing selected'
        return 0
    end

    if not test -n "$selected"
        echo 'Selected not existing broda'
        return 1
    end

	echo $selected
end

function zll
    set key '// @overwrite-me'
    set layouts ()

    set selected
    set current ~/dotfiles/zellij/layouts/$ZELLIJ_SESSION_NAME
    if test -e current
        set selected (find ~/layouts/general $current . -maxdepth 2 -type f -name '*.kdl' | fzf)
    else
        set selected (find ~/layouts/general . -maxdepth 2 -type f -name '*.kdl' | fzf)
    end

    if not test -e $selected
        echo 'Nothing selected'
        return 0
    end

    if not test -n "$selected"
        echo 'Selected not existing broda'
        return 1
    end

    set overwrite (cat $selected | rg $key | wc -l)
    set overwriteName OVERWRITE-ME

    if test $overwrite -gt 0
        command zellij action rename-tab $overwriteName
        command zellij action new-tab -l $selected
        command zellij action go-to-tab-name $overwriteName
        command zellij action close-tab
    else
        command zellij action new-tab -l $selected
    end
end
