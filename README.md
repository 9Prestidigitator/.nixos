<h1 align="center">
  <img src="https://brand.nixos.org/logos/nixos-logo-default-gradient-white-regular-horizontal-minimal.svg" alt="NixOS">
</h1>

Nix flake configuration for five x86-64 NixOS systems with five desktop configurations.

# Systems

- **ink**: Desktop
- **papyr**: Laptop
- **surface**: Microsoft Surface Pro 6
- **book**: Chromebook
- **cardboard**: Laptop

# Desktop Options

1. Niri
   - Noctalia Shell
   - XDG gnome desktop portal
2. KDE
3. GNOME
4. Hyprland
   - Caelestia Shell
   - XDG hyprland desktop portal
5. i3

# Package Derivations

- Overwitch: Jack bridge for Overbridge 2 device.

# Dev shells

- Base universal devshell with all packages that [Neovim](https://github.com/9Prestidigitator/nvim) relies on. 


You can run a dev via `nix develop` or the builtin aliases.

```bash
alias ds='nix develop ~/.nixos#default'
alias ds-md='nix develop ~/.nixos#md'
alias ds-nix='nix develop ~/.nixos#nix'
```

# Plans

Will expand to ARM and darwin systems once I get my hands on one of those systems.
