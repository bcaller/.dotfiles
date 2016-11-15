# .dotfiles

Some configuration

## Installation

```
git clone --bare https://github.com/bcaller/.dotfiles.git $HOME/.dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
echo "alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.bashrc
dotfiles config status.showUntrackedFiles no
dotfiles diff
```
