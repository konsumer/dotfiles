This is my dotfiles. YMMV.

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