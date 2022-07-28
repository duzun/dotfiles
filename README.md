# ⊙ dotfiles

My dotfiles (Linux, OSX &amp; Windows) for bash &amp; zsh on PC &amp; server

## ⚙ Install

with `curl`:

```sh
curl -o- https://raw.githubusercontent.com/duzun/dotfiles/master/install.sh | sh
```

or with `wget`:

```sh
wget -qO- https://raw.githubusercontent.com/duzun/dotfiles/master/install.sh | sh
```

or with `git`:

```sh
git clone --recurse-submodules https://github.com/duzun/dotfiles.git ~/.dotfiles && ~/.dotfiles/~/source init
```

or without `git`, direct download & unzip:

```sh
curl -sLo ~/dotfiles.zip "https://github.com/duzun/dotfiles/archive/master.zip" && unzip ~/dotfiles.zip -d ~ && mv ~/dotfiles-master ~/.dotfiles && ~/.dotfiles/~/source init
```

If you don't have `git`, but latter install it and want to setup git:

```sh
init_git -f
# or
~/.dotfiles/~/source init_git -f
```

## ↻ Update

There is a special alias for updating `dotfiles`:

```sh
.update
```

## 🔗 Links

- My [manjaro-setup](https://github.com/duzun/manjaro-setup) scripts


## By me a ☕

- [BuyMeACoffee.com/duzun](https://www.buymeacoffee.com/duzun)
- [PayPal.me/duzuns](https://www.paypal.me/duzuns)
