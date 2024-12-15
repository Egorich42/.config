My configs for ZSH, Tmuz and Neovim (Ubuntu)

### 1) install neovim, zsh + oh-my-zsh and tmux
Linux:
bash```
brew install tmux 
apt install neovim 
apt install zsh 
```

Mac:
1.Install Homebrew

Run this script 
bash```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
Usialy, on M1 and higher, standart directory for Homebrew is:
```
/opt/homebrew
```
And if is your case, use for PATH:
bash```
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```
Check if Homebrew installed correctly by command:
bash```
brew doctor
```
1.Install `tmux` and `neovim`:
bash```
brew install neovim tmux
```


instruction how install oh-my-zsh [here](https://ohmyz.sh/) [], on below page


### 2) Configure

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

If BACKSPACE not work in TMUX - https://github.com/tmux/tmux/issues/321
changed from:
```
set -g default-terminal "tmux-256color"
to:
set -g default-terminal "xterm-256color"
```

#### To configure NEOVIM - move init.vim to .config/nvim

```
mv init.vim ~/.config/nvim/
```
exec

```
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
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

Oh-my-zsh git cheatsheet - https://kapeli.com/cheat_sheets/Oh-My-Zsh_Git.docset/Contents/Resources/Documents/index
Path:
.tmux.conf - ~/.tmux.conf

init.vim -> ~/.config/nvim/init.vim


[Reload tmux conf](https://blog.sanctum.geek.nz/reloading-tmux-config/)

### How instal plugins for vim

For using vim-pligins [install vim-plug](https://github.com/junegunn/vim-plug#installation)

add plugin in init.vim (for example Plugin 'scrooloose/nerdtree')
nvim
:PlugInstall
:UpdateRemotePlugins
