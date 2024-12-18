# My system set up

Instruction how to set up my comfortable working environment - code editors and plugins for Terminal/CMD

## For Mac:
1.Install Homebrew

Run this script 
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Usually, standard directory for Homebrew is:

```
/opt/homebrew
```

And if is your case, use for PATH:

```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

Check if Homebrew installed correctly by command:
```bash
brew doctor
```

2.Install `neovim`:
```bash
brew install neovim 
```

3. Install `oh-my-zsh`
instruction how install oh-my-zsh [here](https://ohmyz.sh/) [], on below page

4. Replace existing file `.zshrc` to `.zshrc` from this repo:
Clone repo:
```bash
cd ~
git clone git@github.com:Egorich42/.config.git
```

And replace file:

```bash
mv `~/.config.zshrc ~/.zshrc`
```

5. Install Vimplug for opportunity to install plugins fro Vim.
```bash
 curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

6. Update Vim configs:

File `~/.config/nvim/init.vim` will be used as source of actual config file for Neovim. If you cloned this repo into root at the spep 4, new configs already in use

7.  To check if neovim installed correctly and run vith all my plugins run following command:
8.  
```bash
nvim
```

Then reload you Terminal. Now, because of aliases in `.zshrc` you can run `neovim` as standart `vim`.

8. Install plugins. Open vim:
```bash
vim
```
and execute `:PlugInstall`. After all plugins will be installed correctly, you can check their status by command `:PlugStatus`


## Cheatsheets:

[NeoVim cheatsheet](https://www.shortcutfoo.com/app/dojos/neovim/cheatsheet)
[Oh-my-zsh GIT shortcats](https://kapeli.com/cheat_sheets/Oh-My-Zsh_Git.docset/Contents/Resources/Documents/index)

:PlugInstall
:PlugStatus

## How instal plugins for vim

For using vim-pligins [install vim-plug](https://github.com/junegunn/vim-plug#installation)

add plugin in init.vim (for example Plugin 'scrooloose/nerdtree')
nvim
:PlugInstall
:UpdateRemotePlugins

------------------ !! OUTDATED !! ---------------------

1. install neovim, zsh + oh-my-zsh and tmux
Linux:
bash```
brew install tmux 
apt install neovim 
apt install zsh 
```



### 2) Configure TMUX (Outdated!!!)

Clone this repo into ~
```
cd ~
git clone git@github.com:Egorich42/.config.git
cd configs
```

To configure TMUX - move .tmux.conf to ~
```
mv .tmux.conf ~
```

If BACKSPACE doesent work in TMUX - https://github.com/tmux/tmux/issues/321
changed from:
```
set -g default-terminal "tmux-256color"
to:
set -g default-terminal "xterm-256color"
```

#### To configure ZSH and OH-MY-ZSH
```
vim ~/.bashrc

and paste on the top line

exec zsh
```

move .zshrc to ~
```
mv .zshrc ~
```

Path:
.tmux.conf - ~/.tmux.conf

[Reload tmux conf](https://blog.sanctum.geek.nz/reloading-tmux-config/)


