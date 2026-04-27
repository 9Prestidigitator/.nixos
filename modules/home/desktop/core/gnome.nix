{
  flake.homeModules.gnome = {
    dconf.settings."org/gnome/shell".enabled-extensions = [
      "blur-my-shell@aunetx"
      "arcmenu@arcmenu.com"
      "just-perfection-desktop@just-perfection"
    ];
  };
}
