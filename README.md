This is my dotfiles. YMMV.

If you are not me, and want to actually use this, I recommend forking it to your own github account, and edting ~/dotfiles/.git/config:

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

I also included tardec/tarenc for saving secrets somewhere else, encrtpyed:

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
