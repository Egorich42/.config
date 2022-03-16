My configs for ZSH, Tmuz and Neovim (Ubuntu)

### 1) install neovim, zsh + oh-my-zsh and tmux

```
apt install tmux 
apt install neovim 
apt install zsh 
```
instruction how install oh-my-zsh [here](https://ohmyz.sh/) [], on below page


### 2) Configure

Clone this repo into ~
```
cd ~
git clone https://github.com/Egorich42/configs
cd configs
```

To configure TMUX - move .tmux.conf to ~
```
mv .tmux.conf ~
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
