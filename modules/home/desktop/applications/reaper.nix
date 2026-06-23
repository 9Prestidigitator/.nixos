{inputs, ...}: {
  flake.homeModules.reaper = {
    config,
    reaperActions,
    reaperMouse,
    reaperWindows,
    reaperAppearance,
    ...
  }: let
    reaper-config = "reaper-flake";
  in {
    imports = [inputs.reaper-flake.homeModules.reaper];
    programs.reaper = {
      enable = true;
      configPath = "${config.xdg.configHome}/${reaper-config}";

      extensions = {
        reapack.enable = true;
        sws.enable = true;
      };

      actions = {
        keyBindings = with reaperActions;
          bindings [
            (shortcut {
              shortcut = "J";
              command = 40285;
              actionName = "Track: Go to next track";
            })

            (shortcut {
              shortcut = "K";
              command = 40286;
              actionName = "Track: Go to previous track";
            })

            {
              modifierFlags = 255;
              keyCode = 2040;
              command = 989;
              section = sections.main;
              comment = "Main : Mousewheel : OVERRIDE DEFAULT : View: Scroll vertically (MIDI CC relative/mousewheel)";
            }
          ];
      };

      preferences = {
        windows = {
          transportDockPosition = reaperWindows.transport.topOfMainWindow;
          mixer.show = false;
        };

        appearance.zoomScrollOffset = {
          verticalZoomCenter = reaperAppearance.zoomScrollOffset.zoomCenter.vertical.lastSelectedTrack;
          maximumVerticalZoom = 0.80;
          envelopeLaneVerticalZoom = 0.4;
          horizontalZoomCenter = reaperAppearance.zoomScrollOffset.zoomCenter.horizontal.mouseCursor;
          limitHorizontalZoomScrollToProjectStart = false;
          disableMousewheelVerticalZoomForTracksThatArePinnedInArrangeView = true;
          verticalScrollStep = {
            unit = reaperAppearance.zoomScrollOffset.verticalScrollStep.units.trackHeight;
            trackHeight = 0.6;
            arrangeViewHeight = 0.2;
          };

          overlappingMediaItems = {
            offset = 90;
            drawAsOpaque = true;
            arrangeInCreationOrder = true;
          };
        };

        mouse = {
          importedContexts = with reaperMouse; [
            contexts.arrange.middleDrag
            contexts.midiPianoRoll.leftClick
          ];

          contexts = with reaperMouse;
            merge [
              (set contexts.arrange.middleDrag modifiers.none (mouse 9))
              (set contexts.midiPianoRoll.leftClick modifiers.none (mouse 4))
            ];
        };

        plugIns.reascript.python.enable = true;
      };
    };

    persist.directories = [".config/${reaper-config}"];
  };
}
