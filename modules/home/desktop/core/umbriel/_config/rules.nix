{
  programs.umbriel.settings.window_rule = [
    {
      blur = true;
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
      blur_popups = false;
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
      match.is_focused = false;
      opacity = 0.85;
    }
    {
      match.is_focused = true;
      opacity = 1.0;
    }
  ];
}
