{reaperActions, ...}: {
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
            shortcut = "N";
            command = "_S&M_SHOWNOTESHELP";
            actionName = "Toggle Project Notes";
            scope = "global";
          })
          (globalShortcut {
            shortcut = "Shift+N";
            command = "_S&M_ACTIONHELPTGLOCK";
            actionName = "Toggle Notes Lock";
            scope = "global";
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
    };
  };
}
