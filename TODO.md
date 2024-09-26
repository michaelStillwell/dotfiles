* install script
	* install
        > Terminal configuration
        * i3
		* font
		* alacritty
		* fish
		* zellij
		* neovim

        > Tools
        * gitui
        * exa
        * zoxide
        * ripgrep

	* links
        * i3
		* zellij
		* alacritty
		* neovim
		* fish

    * windows
        * glazewm

    * ubuntu
        * ulauncher

---


## Install Cargo

## Install Fish
### Install Fisher
#### Install nvm

## Install Cargo


---

## GlazeWM Configuration

```powershell
New-Item
    -Path '~\.glaze-wm\config.yaml'
    -ItemType SymbolicLink
    -Value '\\wsl$\Ubuntu\home\$USER\dotfiles\glazewm\config.yaml'
```


## Alacritty Configuration

```powershell
New-Item
    -Path 'C:\Users\$USER\AppData\Roaming\alacritty\alacritty.windows.toml'
    -ItemType SymbolicLink
    -Value '\\wsl$\Ubuntu\home\$USER\dotfiles\alacritty\alacritty.toml'
```
