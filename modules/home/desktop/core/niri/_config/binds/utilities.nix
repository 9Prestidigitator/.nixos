{
  config,
  mkWlrWhichKeyMenu,
  ...
}: {
  programs.niri.settings.binds = with config.lib.niri.actions; {
    "Mod+A".action.spawn = mkWlrWhichKeyMenu "Audio" [
      {
        key = "b";
        desc = "Set Behringer Interface";
        cmd = "pactl set-default-sink alsa_output.usb-BEHRINGER_UMC1820_244D6CC5-00.multichannel-output";
      }
      {
        key = "p";
        desc = "Set Airpods";
        cmd = "pactl set-default-sink bluez_output.44_A7_F4_02_10_09.1";
      }
      {
        key = "P";
        desc = "Connect Airpods";
        cmd = "bluetoothctl connect 44:A7:F4:02:10:09";
      }
      {
        key = "s";
        desc = "Set Sony XM5";
        cmd = "pactl set-default-sink bluez_output.AC_80_0A_43_53_C5.1";
      }
      {
        key = "S";
        desc = "Connect Sony XM5";
        cmd = "bluetoothctl connect AC:80:0A:43:53:C5";
      }
    ];

    "XF86AudioPlay" = {
      hotkey-overlay.hidden = true;
      allow-when-locked = true;
      action = spawn "playerctl" "play-pause";
    };
    "XF86AudioPause" = {
      hotkey-overlay.hidden = true;
      allow-when-locked = true;
      action = spawn "playerctl" "play-pause";
    };
    "XF86AudioNext" = {
      hotkey-overlay.hidden = true;
      allow-when-locked = true;
      action = spawn "playerctl" "next";
    };
    "XF86AudioPrev" = {
      hotkey-overlay.hidden = true;
      allow-when-locked = true;
      action = spawn "playerctl" "previous";
    };
    "XF86AudioRaiseVolume" = {
      hotkey-overlay.hidden = true;
      allow-when-locked = true;
      action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.05+";
    };
    "XF86AudioLowerVolume" = {
      hotkey-overlay.hidden = true;
      allow-when-locked = true;
      action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.05-";
    };
    "XF86AudioMute" = {
      hotkey-overlay.hidden = true;
      allow-when-locked = true;
      action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
    };
    "XF86AudioMicMute" = {
      hotkey-overlay.hidden = true;
      allow-when-locked = true;
      action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";
    };
    "XF86MonBrightnessUp" = {
      hotkey-overlay.hidden = true;
      allow-when-locked = true;
      action = spawn "brightnessctl" "--class=backlight" "set" "+5%";
    };
    "XF86MonBrightnessDown" = {
      hotkey-overlay.hidden = true;
      allow-when-locked = true;
      action = spawn "brightnessctl" "--class=backlight" "set" "5%-";
    };

    "XF86Tools" = {
      hotkey-overlay.title = "Lock";
      allow-when-locked = true;
      action = spawn "noctalia-shell" "ipc" "call" "lockScreen" "lock";
    };
    "Mod+XF86Tools" = {
      hotkey-overlay.title = "Session Actions";
      allow-when-locked = false;
      action = spawn "noctalia-shell" "ipc" "call" "sessionMenu" "toggle";
    };

    "XF86Display" = {
      hotkey-overlay.title = "Power off monitors";
      action = power-off-monitors;
    };
    "Mod+Shift+P".action = power-off-monitors;

    "Mod+Shift+D".action.spawn = mkWlrWhichKeyMenu "Debug" [
      {
        key = "p";
        desc = "Restart pipewire";
        cmd = "systemctl --user restart pipewire";
      }
      {
        key = "n";
        desc = "Kill or Start Noctalia Shell";
        cmd = "pkill .quickshell-wra* || noctalia-shell";
      }
      {
        key = "X";
        desc = "Restart Xwayland Satellite";
        cmd = "systemctl --user restart xwayland-satellite";
      }
      {
        key = "g";
        desc = "Restart gnome xdg desktop portal";
        cmd = "systemctl --user restart xdg-desktop-portal-gnome.service";
      }
      {
        key = "d";
        desc = "Restart xdg desktop portal's";
        cmd = "systemctl --user restart xdg-desktop-portal.service";
      }
    ];

    # Take an area screenshot. Select the area to screenshot with mouse
    "Print".action.screenshot = {show-pointer = false;};
    # Take a screenshot of the focused monitor
    "Ctrl+Print".action.screenshot-screen = {write-to-disk = true;};
    # Take a screenshot of the focused window
    "Alt+Print".action.screenshot-window = [];

    "Mod+Alt+Delete" = {
      hotkey-overlay.title = "Session Options";
      action = spawn "noctalia-shell" "ipc" "call" "sessionMenu" "toggle";
    };
    "Ctrl+Alt+Delete" = {
      hotkey-overlay.title = "Logout";
      action.quit.skip-confirmation = false;
    };
  };
}
