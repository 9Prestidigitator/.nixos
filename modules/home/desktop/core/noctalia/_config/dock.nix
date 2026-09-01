{
  pkgs,
  lib,
  config,
  options,
  osConfig,
  ...
}: {
  programs.noctalia.settings.dock = let
    niriEnabled = osConfig ? programs.niri.enable && osConfig.programs.niri.enable;
    umbrielEnabled = options ? programs.umbriel.enable && config.programs.umbriel.enable;
    mangoEnabled = osConfig ? programs.mango.enable && osConfig.programs.mango.enable;
    labwcEnabled = options ? wayland.windowManager.labwc.enable && config.wayland.windowManager.labwc.enable;
    swayEnabled = options ? wayland.windowManager.sway.enable && config.wayland.windowManager.sway.enable;
    i3Enabled = osConfig ? programs.i3.enable && osConfig.programs.i3.enable;
    mangoImage = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/mangowm/mango/main/assets/mango-transparency-256.png";
      hash = "sha256-7/WgDEk2qQHIVSWtH/4E52Pl4D7tZ8WfZnzGquewI2o=";
    };
    labwcImage = pkgs.fetchurl {
      url = "https://avatars.githubusercontent.com/u/93831657?s=60&v=4";
      hash = "sha256-mp4Ya0YxGuWCD7pHxskay4H/XBMUhfIav4Z+XffiArQ=";
    };
    swayImage = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/swaywm/sway/master/assets/Sway_Tree.png";
      hash = "sha256-/gc0s9Zv8h7d0Sj/7fRC78rNtJpJl6kSZTaE8NNd/vE=";
    };
    i3Image = pkgs.fetchurl {
      url = "https://avatars.githubusercontent.com/u/7904352?s=60&v=4";
      hash = "sha256-xL0uZxOWf6/GzSsK4H5xyXSUSYp384nwI92FjGqS1zE=";
    };
  in {
    enabled = true;
    smart_auto_hide = true;

    icon_size = 35;
    item_spacing = 0;
    show_dots = true;
    background_opacity = lib.mkForce 0.01;

    magnification_scale = 1.3;
    radius = 30;
    padding = 4;
    margin_edge = 7;
    reserve_space = false;

    # niri: "niri"
    # umbriel: "ghost-2"
    # mango-wm: "https://github.com/mangowm/mango/blob/main/assets/mango-transparency-256.png"
    # labwc: "https://avatars.githubusercontent.com/u/93831657?s=60&v=4"
    # sway: "https://github.com/swaywm/sway/blob/master/assets/Sway_Tree.png"
    # i3: "https://avatars.githubusercontent.com/u/7904352?s=60&v=4"
    # otherwise: grid-dots

    launcher_icon =
      if niriEnabled then "niri"
      else if umbrielEnabled then "ghost-2"
      else "grid-dots";
    launcher_position = "start";
    launcher_custom_image =
      if mangoEnabled then mangoImage
      else if labwcEnabled then labwcImage
      else if swayEnabled then swayImage
      else if i3Enabled then i3Image
      else "";

    pinned =
      lib.optional (options ? desktop.terminal.name && config.desktop.terminal.name != null)
      config.desktop.terminal.desktop
      ++ lib.optional (options ? desktop.explorer.name && config.desktop.explorer.name != null)
      config.desktop.explorer.desktop
      ++ lib.optional (options ? desktop.browser.name && config.desktop.browser.name != null)
      config.desktop.browser.desktop
      ++ lib.optional (options ? programs.reaper.enable && config.programs.reaper.enable) "cockos-reaper"
      ++ lib.optional (lib.elem pkgs.obsidian osConfig.environment.systemPackages) "obsidian"
      ++ lib.optional osConfig.programs.steam.enable "steam"
      ++ lib.optional (options ? programs.nixcord.enable && config.programs.nixcord.enable) "discord"
      ++ lib.optional (lib.elem pkgs.signal-desktop osConfig.environment.systemPackages) "signal"
      ++ lib.optional (options ? programs.spicetify && config.programs.spicetify.enable) "spotify";
  };
}
