{
  programs.umbriel.settings = {
    window_rule = [
      {
        blur = true;
        blur_optimized = false;
      }
      {
        match.app_id = "^(Alacritty|kitty|org\\.gnome\\.Nautilus)$";
        default_width = 0.33;
      }
      {
        match.app_id = "^(helium|chromium)$";
        default_width = 0.75;
      }
      {
        match.app_id = "^(steam_app_[0-9]+|gamescope)$";
        vrr = "always";
      }
      {
        match.app_id = "^steam_app_[0-9]+$";
        hdr = "fullscreen";
      }
      {
        match.app_id = "^(code|org\\.gnome\\.Nautilus)$";
        opacity = 0.97;
      }
      {
        match.app_id = "^(Emulator|zenity|xdg-desktop-portal|qalculate-gtk|org\\.pulseaudio\\.pavucontrol)$";
        default_floating = true;
      }
      {
        match.title = "^(Open File|Select|Choose a wallpaper|Open Folder|Save As|Library|Choose Where to Download|File Operation Progress|Rename|Copy Files|Move Files|Search Files)";
        default_floating = true;
      }
      {
        match.app_id = "^(steam_proton|steam_app.*|overwatch|overwatch\\.exe)$";
        default_fullscreen = true;
      }
      {
        match.title = "^notificationtoasts_.+_desktop";
        default_position = {
          x = 0;
          y = 0;
          anchor = "bottom_right";
        };
        default_focused = false;
        default_pinned = true;
      }
      {
        match.app_id = "^dev.noctalia.Noctalia$";
        default_floating = true;
        default_size = [1020 900];
        blur_popups = true;
      }
      {
        match.app_id = "^dev.noctalia.UmbrielSharePicker$";
        default_floating = true;
        default_size = [800 600];
        default_position = {
          x = 32;
          y = 32;
          anchor = "bottom_right";
        };
      }
      {
        match.app_id = "^dev.lemmy.swash$";
        default_floating = true;
        default_size = [1000 900];
      }
      {
        match.title = "^(Picture-in-Picture|Picture in picture)$";
        default_floating = true;
        default_maximize = false;
        default_position = {
          x = 20;
          y = 20;
          anchor = "bottom_right";
        };
      }
      # {
      #   match.is_focused = false;
      #   opacity = 0.85;
      # }
      # {
      #   match.is_focused = true;
      #   opacity = 1.0;
      # }
    ];

    layer_rule = [
      {
        match.namespace = "^noctalia-(bar-[^\"]+|notification|dock|panel|attached-panel|osd)$";
        blur = true;
        # blur_ignore_alpha = 0.5;
        blur_optimized = false;
        blur_popups = true;
      }
    ];
  };
}
