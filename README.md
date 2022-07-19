## Support me!
monero: 45xJFnyEE3CUa8Lyab5dZFDoB6NwLkkeeZTCdXGtApmb9TKFgJahj1qf9UUU3MBMjtYaa2QrSSJSTKYBM2ZJ9Ze7TGH7Enz

# dwm-dots

Dotfiles, bash scripts and some config files I use on my old void-GNU/linux laptop. The configuration follows the [Catppuccin Frappe theme](https://github.com/catppuccin/catppuccin#-palettes). This is still WIP.

![first screenshot](https://i.imgur.com/qsUJOOX.png)

## Dependencies:
* Void Linux (obiously)
* Material Design Icons
* feh
* optional - network manager, kdeconnect
* [dwm-bar dependencies](https://github.com/isodiff/dwm-bar/blob/main/dep/void.txt)

## Contents:
### dwm with patches:
* [Alt Tags Decorations](https://dwm.suckless.org/patches/alttagsdecoration/)
* [Colorbar](https://dwm.suckless.org/patches/colorbar/)
* [Fullgaps](https://dwm.suckless.org/patches/fullgaps/)
* [Notitle](https://dwm.suckless.org/patches/notitle/)
* [Rainbowtags](https://dwm.suckless.org/patches/rainbowtags/)
* [Status2d](https://dwm.suckless.org/patches/status2d/)
* [Underline tags](https://dwm.suckless.org/patches/underlinetags/)
#### status bar
* Made with the status2d patch and Material Design Icons. Located in `Scripts/dwm-bar/` and called by `Scripts/login.sh`.

### stolendots:
* btop - wip
* cava - [stolen from  catppuccin](https://github.com/catppuccin/cava/blob/main/catppuccin.cava)
* kitty
* .zshrc
* an rxfetch script with a separate /home partition and a nice coffee ASCII art


plus some weird kernel configs

## How to install
> Note: I recommend using symlinks to keep your files up to date!
1. Clone this repo
2. ```cd dwm-dots```
3. ???
4. profit
