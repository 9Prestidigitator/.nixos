{
  config,
  inputs,
  ...
}: {
  programs.niri.settings = {
    prefer-no-csd = true;
    window-rules = [
      {
        geometry-corner-radius = let
          radius = 5.0;
        in {
          bottom-left = radius;
          bottom-right = radius;
          top-left = radius;
          top-right = radius;
        };
        draw-border-with-background = false;
        clip-to-geometry = true;
      }
      {
        matches = [{is-floating = true;}];
        shadow.enable = true;
      }
      {
        matches = [
          {app-id = "brave-browser";}
        ];
        open-maximized = true;
      }
      {
        matches = [
          {title = "Confirm";}
          {title = "Authentication Required";}
          {title = "xdg-desktop-portal-gtk";}
        ];
        open-floating = true;
      }
      {
        matches = [{app-id = "Picture in picture";}];
        open-floating = true;
        default-floating-position = {
          x = 32;
          y = 32;
          relative-to = "bottom-right";
        };
        default-column-width = {fixed = 480;};
        default-window-height = {fixed = 270;};
      }
    ];
  };
  # programs.niri.config = let
  #   inherit
  #     (inputs.niri.lib.kdl)
  #     node
  #     plain
  #     leaf
  #     flag
  #     ;
  # in [
  #   # ============= Window Rules =============
  #   # Get all the window's information via:
  #   #   niri msg windows
  #
  #   # --------------- 1Terminal ---------------
  #   # (plain "window-rule" [
  #   #   (leaf "match" { app-id = "foot"; })
  #   #   (leaf "open-on-workspace" "1terminal")
  #   #   (leaf "open-maximized" true)
  #   # ])
  #
  #   # (plain "window-rule" [
  #   #   (leaf "match" {app-id = "kitty";})
  #   # (leaf "open-on-workspace" "1terminal")
  #   #   (leaf "open-maximized" true)
  #   # ])
  #
  #   # (plain "window-rule" [
  #   #   (leaf "match" { app-id = "com.mitchellh.ghostty"; })
  #   #   (leaf "open-on-workspace" "1terminal")
  #   #   (leaf "open-maximized" true)
  #   # ])
  #
  #   # --------------- 2Browser ---------------
  #
  #   (plain "window-rule" [
  #     (leaf "match" {app-id = "brave-browser";})
  #     # (leaf "open-on-workspace" "2browser")
  #     (leaf "open-maximized" true)
  #   ])
  #   (plain "window-rule" [
  #     (leaf "match" {app-id = "google-chrome";})
  #     # (leaf "open-on-workspace" "2browser")
  #     (leaf "open-maximized" true)
  #   ])
  #   (plain "window-rule" [
  #     (leaf "match" {app-id = "chromium-browser";})
  #     # (leaf "open-on-workspace" "2browser")
  #     (leaf "open-maximized" true)
  #   ])
  #
  #   # --------------- 3Chatting ---------------
  #   # (plain "window-rule" [
  #   #   (leaf "match" { app-id = "org.telegram.desktop"; })
  #   #   (leaf "open-on-workspace" "3chat")
  #   # ])
  #   # (plain "window-rule" [
  #   #   (leaf "match" { app-id = "wechat"; })
  #   #   (leaf "open-on-workspace" "3chat")
  #   # ])
  #   # (plain "window-rule" [
  #   #   (leaf "match" { app-id = "QQ"; })
  #   #   (leaf "open-on-workspace" "3chat")
  #   # ])
  #
  #   # --------------- 4Gaming ---------------
  #
  #   # (plain "window-rule" [
  #   #   (leaf "match" { app-id = "steam"; })
  #   #   (leaf "open-on-workspace" "4gaming")
  #   # ])
  #   # (plain "window-rule" [
  #   #   (leaf "match" { app-id = "steam_app_default"; })
  #   #   (leaf "open-on-workspace" "4gaming")
  #   # ])
  #   # (plain "window-rule" [
  #   #   (leaf "match" { app-id = "heroic"; })
  #   #   (leaf "open-on-workspace" "4gaming")
  #   # ])
  #   # (plain "window-rule" [
  #   #   (leaf "match" { app-id = "net.lutris.Lutris"; })
  #   #   (leaf "open-on-workspace" "4gaming")
  #   # ])
  #   # (plain "window-rule" [
  #   #   (leaf "match" { app-id = "com.vysp3r.ProtonPlus"; })
  #   #   (leaf "open-on-workspace" "4gaming")
  #   # ])
  #   # (plain "window-rule" [
  #   #   # Run anime games on Linux
  #   #   (leaf "match" { app-id = "^moe.launcher"; })
  #   #   (leaf "open-on-workspace" "4gaming")
  #   # ])
  #   # (plain "window-rule" [
  #   #   # All *.exe (Windows APPs)
  #   #   (leaf "match" { app-id = "\.exe$"; })
  #   #   (leaf "open-on-workspace" "4gaming")
  #   # ])
  #
  #   # --------------- 6File ---------------
  #   # (plain "window-rule" [
  #   #   (leaf "match" { app-id = "com.github.johnfactotum.Foliate"; })
  #   #   (leaf "open-on-workspace" "6file")
  #   # ])
  #   # (plain "window-rule" [
  #   #   (leaf "match" { app-id = "thunar"; })
  #   #   (leaf "open-on-workspace" "6file")
  #   # ])
  #
  #   # --------------- 0Other ---------------
  #
  #   (plain "window-rule" [
  #     (leaf "match" {app-id = "^Picture in picture$";})
  #     (leaf "open-floating" true)
  #   ])
  #
  #   (plain "window-rule" [
  #     (leaf "match" {app-id = "^org\.keepassxc\.KeePassXC$";})
  #     (leaf "match" {app-id = "^org\.gnome\.World\.Secrets$";})
  #     (leaf "block-out-from" "screen-capture")
  #   ])
  #
  #   (plain "window-rule" [
  #     (leaf "geometry-corner-radius" 5)
  #     (leaf "clip-to-geometry" true)
  #   ])
  # ];
}
