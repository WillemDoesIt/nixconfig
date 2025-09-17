# My Nixos Config
I am daily driving this configuration as of the latest commit.

![> [!WARNING]
> I may have made some mistakes in my config, I have used Nix for well over a year, but still know little about the language or good practices. Specifically the setup hasn't been battle tested yet, don't just blindly run my bash! ]

### Features:
- Custom commands !!!
- Flake for version control
- *No* home manager, visit [here](https://github.com/WillemDoesIt/dotfiles) for my dotfiles.
- Hyprland
- Nvidia ready
- packages in dedicated file

### Setup tutorial:
initially start by downloading my repo and running the defulat rebuild command
```bash
git clone git@github.com:WillemDoesIt/dotfiles.git /etc/nixos/
sudo nixos-rebuild switch --flake /etc/nixos#nixos
```

From now on you will never need to run the default rebuild command again. Instead run `re`, which will:
1. automatically sync with any changes in this remote repo 
2. will open neovim to the `packages.nix` file 
3. will auto run the rebuild command on exit 
4. then commit all new changes, uploading them too
5. then checking for how much space nix store is taking up to decide if anything old should be cleared out.

### Goals
- [ ] Have rebuild script auto sync dotfiles to repo
- [ ] Have a built in way to change repos to one you own after a user downloads this one.
- [ ] Setup other desktop env options.
