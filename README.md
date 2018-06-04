# Backup My GitHub Profile

_Clones all your GitHub public repositories to your machine_

<img width="400" src="https://user-images.githubusercontent.com/3625244/40909608-a830f2ae-67f2-11e8-8bf0-6aa996031bac.png">

## Using

Before starting the script, you need to generate personal access token on GitHub (**with full repo access**).
Follow this guide - [link](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line)

Afterwards, navigate to the folder, where you want to store repos:

```bash
mkdir -p /some/path/to/folder/with/backups
cd /some/path/to/folder/with/backups
```

Run the script:

```bash
bash <(curl -s https://raw.githubusercontent.com/ghaiklor/backup-my-github/master/backup.sh)
```

## License

[DWTFYWT](./LICENSE)
