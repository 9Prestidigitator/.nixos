<h1 align="center">
  <img src="https://brand.nixos.org/logos/nixos-logo-default-gradient-white-regular-horizontal-minimal.svg" alt="NixOS">
</h1>

Dendritic Nix flake configuration for five x86-64 NixOS systems with five desktop configurations.

# Systems

- **ink**: Desktop
- **papyr**: Laptop
- **surface**: Microsoft Surface Pro 6
- **book**: Chromebook
- **cardboard**: Laptop

# Desktop Modules

1. Niri
   - Noctalia Shell
2. KDE
3. GNOME
4. Hyprland
   - Caelestia Shell
5. i3

# Dev shells

- Base universal devshell with all packages that [Neovim](https://github.com/9Prestidigitator/nvim) relies on.
- Nix devshell for editing Nix
- Python devshell with basic features and packages
- Minimal Markdown devshell

Other development tools for a specific project should be managed by that projects flake.

You can run a dev via `nix develop` or the builtin aliases.

```bash
alias ds='nix develop ~/.nixos#default'
alias ds-nix='nix develop ~/.nixos#nix'
alias ds-md='nix develop ~/.nixos#markdown'
alias ds-py='nix develop ~/.nixos#python'
alias ds-cs='nix develop ~/.nixos#csharp'
alias ds-cpp='nix develop ~/.nixos#cpp'
```

There are alternative dsv commands for each to launch neovim upon entering the environment.

# Plans

Will expand to ARM and darwin systems once I get my hands on one of those systems.

# Credits

Thank you to [Vimjoyer](https://www.youtube.com/@vimjoyer) and [tony](https://www.youtube.com/@tony-btw) for high quality tutorials.
