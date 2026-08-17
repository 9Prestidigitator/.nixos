{
  pkgs,
  reaperActions,
  ...
}: {
  programs.reaper = {
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

          (shortcut {
            shortcut = "Shift+J";
            command = 43648;
            actionName = "Track: Move down";
          })
          (shortcut {
            shortcut = "Shift+K";
            command = 43647;
            actionName = "Track: Move up";
          })

          (shortcut {
            shortcut = "F2";
            command = 40696;
            actionName = "Rename last touched track";
          })
          (shortcut {
            shortcut = "F3";
            command = 41589;
            actionName = "Show media item/take properties";
          })

          (shortcut {
            shortcut = "Shift+H";
            command = 1041;
            actionName = "Track: Cycle track folder state";
          })
          (shortcut {
            shortcut = "Shift+L";
            command = 1042;
            actionName = "Track: Cycle folder collapsed state";
          })

          (shortcut {
            shortcut = "Ctrl+Shift+I";
            command = 40214;
            actionName = "Insert Midi item";
          })
          (shortcut {
            shortcut = "Ctrl+Shift+R";
            command = "_RS_random_selected_track_color_gradient";
            actionName = "Set selected tracks to a random color gradient";
          })

          (shortcut {
            shortcut = "M";
            command = 41610;
            actionName = "Toggle master visibility";
          })
          (shortcut {
            shortcut = "Shift+E";
            command = 50124;
            actionName = "Toggle explorer";
          })
          (shortcut {
            shortcut = "Shift+P";
            command = 43185;
            actionName = "Toggle TCP";
          })
          (shortcut {
            shortcut = "Alt+V";
            command = "_RS5f688cc3f0ccdcb59dbeec10cfae4545059b5f20";
            actionName = "Global Sampler";
          })

          (shortcut {
            shortcut = "$";
            command = "_RSfc9d5d2c7b02b7984564819f689b3bbf279dae50";
            actionName = "Tap Tempo";
          })
          (shortcut {
            shortcut = "Alt+Shift+P";
            command = "_REAPACK_BROWSE";
            actionName = "Browse ReaPack packages";
          })
          (globalShortcut {
            shortcut = "Shift+M";
            command = 40716;
            actionName = "Toggle midi editor";
            scope = "global";
          })
          (globalShortcut {
            shortcut = "Shift+N";
            command = "_S&M_ACTIONHELPTGLOCK";
            actionName = "Toggle Notes Lock";
            scope = "global";
          })
          (shortcut {
            shortcut = "N";
            command = "_S&M_SHOWNOTESHELP";
            actionName = "Toggle Project Notes ";
          })

          (shortcut {
            shortcut = "Shift+R";
            command = "9";
            actionName = "Toggle Arm selected tracks.";
          })

          {
            modifierFlags = 255;
            keyCode = 2040;
            command = 989;
            section = sections.main;
            comment = "Main : Mousewheel : OVERRIDE DEFAULT : View: Scroll vertically (MIDI CC relative/mousewheel)";
          }
        ];

      customActions = [
        {
          name = "Activate drum view";
          commandId = "custom_drum_view";
          actions = [40043 40450 40454];
          section = reaperActions.sections.midiEditor;
        }
        {
          name = "Activate piano view";
          commandId = "custom_piano_view";
          actions = [40449 40042 40452];
          section = reaperActions.sections.midiEditor;
        }
      ];

      scripts = [
        {
          path = "User/random-selected-track-color-gradient.lua";
          commandId = "RS_random_selected_track_color_gradient";
          description = "Set selected tracks to a random color gradient";
          source = pkgs.writeText "random-selected-track-color-gradient.lua" ''
            local track_count = reaper.CountSelectedTracks(0)
            if track_count == 0 then
              return
            end

            math.randomseed(math.floor(reaper.time_precise() * 1000000) % 2147483647)
            math.random()
            math.random()
            math.random()

            local function random_between(minimum, maximum)
              return minimum + math.random() * (maximum - minimum)
            end

            local function hsv_to_rgb(hue, saturation, value)
              local sector = math.floor(hue * 6)
              local fraction = hue * 6 - sector
              local p = value * (1 - saturation)
              local q = value * (1 - fraction * saturation)
              local t = value * (1 - (1 - fraction) * saturation)

              sector = sector % 6
              if sector == 0 then return value, t, p end
              if sector == 1 then return q, value, p end
              if sector == 2 then return p, value, t end
              if sector == 3 then return p, q, value end
              if sector == 4 then return t, p, value end
              return value, p, q
            end

            local start_hue = math.random()
            local hue_direction = math.random(0, 1) == 0 and -1 or 1
            local hue_delta = hue_direction * random_between(0.15, 0.45)
            local start_saturation = random_between(0.55, 0.85)
            local end_saturation = random_between(0.55, 0.85)
            local start_value = random_between(0.75, 1.0)
            local end_value = random_between(0.75, 1.0)

            reaper.Undo_BeginBlock2(0)
            reaper.PreventUIRefresh(1)

            for index = 0, track_count - 1 do
              local position = track_count == 1 and 0 or index / (track_count - 1)
              local hue = (start_hue + hue_delta * position) % 1
              local saturation = start_saturation + (end_saturation - start_saturation) * position
              local value = start_value + (end_value - start_value) * position
              local red, green, blue = hsv_to_rgb(hue, saturation, value)
              local native_color = reaper.ColorToNative(
                math.floor(red * 255 + 0.5),
                math.floor(green * 255 + 0.5),
                math.floor(blue * 255 + 0.5)
              ) + 0x1000000

              local track = reaper.GetSelectedTrack(0, index)
              reaper.SetMediaTrackInfo_Value(track, "I_CUSTOMCOLOR", native_color)
            end

            reaper.PreventUIRefresh(-1)
            reaper.TrackList_AdjustWindows(false)
            reaper.UpdateArrange()
            reaper.Undo_EndBlock2(0, "Set selected tracks to a random color gradient", -1)
          '';
        }
      ];
    };
  };
}
