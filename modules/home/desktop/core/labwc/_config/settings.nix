{...}: {
  wayland.windowManager.labwc = {
    environment = [
      "XDG_CURRENT_DESKTOP=labwc:wlroots"
      "XCURSOR_SIZE=24"
      "GTK_IM_MODULE=simple"
    ];

    rc = {
      core = {
        decoration = "server";
        gap = 4;
        adaptiveSync = "fullscreen";
        allowTearing = "fullscreen";
        primarySelection = "no";
      };

      theme = {
        name = "Clearlooks-3.4";
        cornerRadius = 8;
        font = {
          "@name" = "FiraCode";
          "@size" = "11";
        };
      };

      placement.policy = "center";

      resistance = {
        screenEdgeStrength = 20;
        windowEdgeStrength = 20;
        unSnapThreshold = 20;
      };

      focus = {
        followMouse = "no";
        raiseOnFocus = "no";
      };

      windowSwitcher = {
        "@preview" = "yes";
        "@outlines" = "yes";
        osd = {
          "@show" = "yes";
          "@style" = "thumbnail";
          "@output" = "all";
          "@thumbnailLabelFormat" = "%n — %T";
        };
      };

      desktops = {
        "@number" = "9";
        "@popupTime" = "500";
      };

      keyboard = {
        numlock = "on";
        repeatRate = 25;
        repeatDelay = 600;
      };

      mouse.doubleClickTime = 500;

      libinput.device = [
        {
          "@category" = "touchpad";
          tap = "yes";
          naturalScroll = "yes";
          disableWhileTyping = "yes";
        }
        {
          "@category" = "non-touch";
          accelProfile = "flat";
        }
      ];

      regions.region = [
        {
          "@name" = "left-third";
          "@x" = "0%";
          "@y" = "0%";
          "@width" = "33.333%";
          "@height" = "100%";
        }
        {
          "@name" = "center-third";
          "@x" = "33.333%";
          "@y" = "0%";
          "@width" = "33.334%";
          "@height" = "100%";
        }
        {
          "@name" = "right-third";
          "@x" = "66.667%";
          "@y" = "0%";
          "@width" = "33.333%";
          "@height" = "100%";
        }
        {
          "@name" = "center-half";
          "@x" = "25%";
          "@y" = "0%";
          "@width" = "50%";
          "@height" = "100%";
        }
      ];

      menu = {
        showIcons = "yes";
        ignoreButtonReleasePeriod = 250;
      };
    };
  };

  xdg.configFile."labwc/themerc-override".text = ''
    border.width: 3
    window.active.border.color: #81a1c1
    window.inactive.border.color: #3b4252
    window.active.title.bg.color: #3b4252
    window.inactive.title.bg.color: #2e3440
    window.active.label.text.color: #eceff4
    window.inactive.label.text.color: #d8dee9
    window.button.hover.bg.color: #88c0d060
    window.active.shadow.size: 40
    window.inactive.shadow.size: 24
    window.active.shadow.color: #00000060
    window.inactive.shadow.color: #00000040
    menu.border.color: #5e81ac
    menu.items.bg.color: #2e3440
    menu.items.text.color: #d8dee9
    menu.items.active.bg.color: #5e81ac
    menu.items.active.text.color: #eceff4
    menu.separator.color: #4c566a
    osd.bg.color: #2e3440
    osd.border.color: #81a1c1
    osd.label.text.color: #eceff4
    osd.window-switcher.style-thumbnail.item.active.border.color: #88c0d0
    snapping.overlay.region.bg.color: #5e81ac80
    snapping.overlay.edge.bg.color: #5e81ac80
  '';
}
