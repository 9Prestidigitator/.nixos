<h1 align="center">
  <img src="https://brand.nixos.org/logos/nixos-logo-default-gradient-white-regular-horizontal-minimal.svg" alt="NixOS">
</h1>

Dendritic Nix flake configuration for five x86-64 NixOS systems with five desktop configurations.

# Systems

- **ink**: AMD/NVIDIA Desktop
- **papyr**: Thinkpad Laptop
- **surface**: Microsoft Surface Pro 6
- **book**: Chromebook
- **cardboard**: TV Laptop
- **iso**: ISO installer with baked in secrets and distributed builds
- **wsl**: For when I'm forced to use Windows
- **vm**'s: For testing and future deployments.

# Desktop Modules

1. Niri
   - Noctalia v4
   - Noctalia v5
2. KDE Plasma
3. Gnome
4. i3

# Dev shells

- Base universal devshell with all packages that [Neovim](https://github.com/9Prestidigitator/nvim) relies on.
- Nix devshell for editing Nix
- Python devshell with basic features and packages
- Minimal Markdown devshell
- C++ development shell
- C# development shell

Other development tools for a specific project should be managed by that projects flake.

You can run a dev via `nix develop` or the builtin aliases.

```bash
alias ds='nix develop ~/.nixos#default' (nix)
alias ds-nix='nix develop ~/.nixos#nix'
alias ds-md='nix develop ~/.nixos#markdown'
alias ds-cpp='nix develop ~/.nixos#cpp'
alias ds-cs='nix develop ~/.nixos#csharp'
alias ds-py='nix develop ~/.nixos#python'
alias ds-max='nix develop ~/.nixos#max' (mega-environment)
```

There are alternative dsv commands for each to launch neovim upon entering the environment.

# Plans

Will expand to ARM and darwin systems once I get my hands on one of those systems.

# AI Policy

This configuration has not been modified by artificial intelligence to ensure maximum understanding of system configuration. It has, however, been used for review, research, and discovery.

# Credits

Thank you to [Vimjoyer](https://www.youtube.com/@vimjoyer) and [tony](https://www.youtube.com/@tony-btw) for high quality tutorials.
