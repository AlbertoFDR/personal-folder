# personal-folder
Personal configurations and so on...

Sound.sh -> is a script to change the output of the sound from the computer to the monitor.

## NVIM
Steps to install my config:
1. Install Neo Vim (ubuntu/debian): *sudo apt install neovim*
2. Download my config: *git clone https://github.com/AlbertoFDR/personal-folder.git* 
3. Move nvim config, inside the ~/.config/ folder
4. Edit init.vim in ~/.config/nvim/init.vim and install plugins: *:PlugInstall*

Any problem with YouCompleteMe (YCM) you should go to ~/.config/nvim/plugged/youcompleteme and put:
 `python3 install.py --all`

## MY TWO WINDOWS MANAGER (LOOK&FEEL)
### I3 WM
![I3 photo](/images/i3.png)
### BSPWM
[Original video tutorial - by s4vitar ](https://www.youtube.com/watch?v=MF4qRSedmEs "Original video")

This configuration includes:
* bspwm - Tiling Window Manager
* sxhkd - Shortcut configuration
* compton - For blurring windows
* rofi - Used to launch application
* polybar - The status bar because bspwm doesn't have one

![BSPWM photo](/images/bspwm.png)


