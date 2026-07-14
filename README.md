This is my dotfiles. YMMV.

If you are not me, and want to actually use this, I recommend forking it to your own github account, and editing ~/dotfiles/.git/config:

```ini
[remote "origin"]
	url = git@github.com:YOUR_USERNAME/dotfiles.git
	fetch = +refs/heads/*:refs/remotes/origin/*
```

This will make it so you can commit/push your changes. If you need to add files to be tracked, use this:

```sh
cd ~/dotfiles
stow .
```

If you want my full setup (on mac or linux):

```sh
curl -sS https://raw.githubusercontent.com/konsumer/dotfiles/refs/heads/main/install.sh | bash
```

I also included tardec/tarenc for saving secrets somewhere else, encrypted:

```sh
# build file
mkdir -p secrets
cp -R ~/.ssh ~/.secrets secrets
tarenc secrets /mnt/BACKUP/secrets.enc.tgz && rm -rf secrets

# extract
tardec /mnt/BACKUP/secrets.enc.tgz && mv secrets/{.,}* ~/ && rm -rf secrets
```

These will be in your path, once you are using my `~/.zshrc`.

You can use this to backup any secrets that should not be checked in to github.

## niri (Linux desktop)

`.config/niri/config.kdl` is my [niri](https://github.com/YaLTeR/niri) scrollable-tiling
Wayland setup. It is Linux-only and does nothing on mac (or without niri installed) —
it just sits dormant. `install.sh` does not install niri, so this is opt-in: delete
`.config/niri` if you don't want it.
