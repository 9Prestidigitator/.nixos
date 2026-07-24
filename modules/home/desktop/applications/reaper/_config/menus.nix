{
  reaperMenus,
  ...
}: {
  programs.reaper = {
    menus = {
      "${reaperMenus.toolbars.main}" = {
        entries = [
          {
            action = 40021;
            label = "Project settings...";
          }
          {
            action = 40859;
            label = "New project...";
            icon = "toolbar_new.png";
          }
          {
            action = 40029;
            label = "Undo";
          }
          {
            action = 40030;
            label = "Redo";
          }
          reaperMenus.divider
          {
            action = 40364;
            label = "Enable Metronome";
          }
          {
            action = 40145;
            label = "Show arrange view grid";
          }
          {
            action = 1157;
            label = "Enable snapping";
          }
          reaperMenus.divider
          {
            action = 40041;
            label = "Enable auto-crossfade";
          }
          {
            action = 1156;
            label = "Enable item and track media/razor edit grouping";
          }
          {
            action = 40070;
            label = "Move envelope points with media items";
          }
          {
            action = 1162;
            label = "Toggle ripple editing";
            toolbarFlags = 1;
          }
          {
            action = 42618;
            label = "Razor editing";
            toolbarFlags = 1;
          }
          {
            action = "_RSa3ce2b5fed8e25570e453559e79b447bb6c36cda";
            label = "Toggle FX bypass over 64 samples";
            icon = "toolbar_item_effects_fx_delete_remove.png";
          }
          reaperMenus.divider
          {
            action = 1135;
            label = "Enable locking";
          }
          {
            action = 42336;
            label = "Toggle track height lock";
            icon = "toolbar_zoom_selected.png";
          }
          reaperMenus.divider
          {
            action = 40036;
            label = "Follow playhead";
            icon = "toolbar_sync_follow_play.png";
          }
          {
            action = 41817;
            label = "Continuous follow playhead";
            icon = "toolbar_misc_run_forward.png";
            toolbarFlags = 1;
          }
          reaperMenus.divider
          {
            action = 40015;
            label = "Render";
            icon = "toolbar_audio_waveform_render_disk_stereo.png";
          }
        ];
      };

      "${reaperMenus.toolbars.midiPianoRoll}" = {
        entries = [
          {
            action = 1005;
            label = "Save (.mid source only)";
          }
          {
            action = 1013;
            label = "Revert (.mid source only)";
          }
          reaperMenus.divider
          {
            action = 40042;
            label = "Piano roll";
          }
          {
            action = 40043;
            label = "Named notes";
          }
          {
            action = 40056;
            label = "Event list";
          }
          {
            action = 40954;
            label = "Musical notation";
          }
          reaperMenus.divider
          {
            action = 40449;
            label = "Rectangular notes (normal mode)";
          }
          {
            action = 40448;
            label = "Triangular notes (drum mode)";
          }
          {
            action = 40450;
            label = "Diamond notes (drum mode)";
          }
          reaperMenus.divider
          {
            action = "custom_piano_view";
            label = "Piano view";
            icon = "toolbar_midi_mode_piano_roll.png";
          }
          {
            action = "custom_drum_view";
            label = "Drum view";
            icon = "toolbar_misc_drum.png";
          }
          reaperMenus.divider
          {
            action = 40471;
            label = "Filter";
          }
          {
            action = 40818;
            label = "Track List";
          }
          {
            action = 40009;
            label = "Quantize";
          }
          {
            action = 1215;
            label = "CC selection follows note selection";
          }
          {
            action = 40481;
            label = "Step sequencing: use all MIDI inputs for step recording";
          }
          reaperMenus.divider
          {
            action = 1017;
            label = "Show grid";
          }
          {
            action = 1014;
            label = "Snap to grid";
          }
          reaperMenus.divider
          {
            action = 40750;
            label = "Follow playhead";
            icon = "toolbar_sync_follow_play.png";
          }
          {
            action = 40018;
            label = "Dock editor";
          }
        ];
      };
    };
  };
}
