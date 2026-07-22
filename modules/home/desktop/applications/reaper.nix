{inputs, ...}: {
  flake.homeModules.reaper = {
    config,
    pkgs,
    reaperActions,
    reaperMouse,
    reaperWindows,
    reaperMenus,
    reaperLayout,
    reaperGeneral,
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
        reapack = {
          enable = true;
          repositories = [
            {
              name = "reaper-keys";
              url = "https://raw.githubusercontent.com/gwatcha/reaper-keys/master/index.xml";
            }
          ];
          synchronizeOnActivation = true;
        };

        sws.enable = true;
      };

      preferences = {
        general = {
          startupSettings = {
            openProjectOnStartup = reaperGeneral.openProjectOnStartup.newProjectIgnoreDefaultTemplate;
            createNewProjectTabWhenOpeningMedia = true;
          };

          undo = {
            maximumUndoMemory = 512;
            saveHistoryWithProjectFiles = true;
          };
        };

        project = {
          projectLoading = {
            lookForProjectMediaInProjectDirectoryBeforeQualifiedPath = true;
          };
        };

        windows = {
          tcpHelpBar = {
            informationDisplay = reaperWindows.tcpHelpBar.informationDisplay.cpuRamUseTimeSinceLastSave;
            showMouseEditingHelp = true;
          };
          mixer.master.showInDockerOrWindow = true;
        };

        project = {
          backups = {
            whenSaving = {
              preservePreviousVersionAsRppBak = false;
              preserveAllPreviousVersionsInOneRppBak = false;
              preservePreviouslySavedVersionOfProjectAsRppBak = {
                enable = true;
                saveTimestampedBackupsToProjectBackupsSubdirectory = true;

                limitAutoSavedBackupsToMostRecent = {
                  enable = true;
                  count = 50;
                  unit = "copies";
                };
              };
            };

            autoSave = {
              autoSaveToTimestampedFileInProjectDirectory = {
                enable = true;
                saveBackupsToProjectAutoSavesSubdirectory = true;

                limitAutoSavedBackupsToMostRecent = {
                  enable = true;
                  count = 50;
                  unit = "copies";
                };
              };

              autoSaveUnsavedProjectsToTemporaryFile = true;
              autoSaveInterval = {
                minutes = 10;
                mode = "whenNotRecording";
              };
            };
          };
        };

        appearance = {
          trackControlPanels = {
            setTrackLabelBackgroundToCustomTrackColors = true;
            tintTrackPanelBackgrounds = false;
            alignTcpControlsWhenTrackIconsOrFixedItemLanesAreUsed = true;

            showFxInserts = true;
            showSends = true;
            groupSendsWithFxInserts = false;
            groupFxParametersWithInserts = true;

            trackGroupingIndicators = reaperAppearance.trackControlPanels.trackGroupingIndicators.ribbons;
            folderCollapseButtonCyclesTrackHeights = reaperAppearance.trackControlPanels.folderCollapseButtonCyclesTrackHeights.normalHidden;
            fixedLaneCollapseButtonChangesDisplay = reaperAppearance.trackControlPanels.fixedLaneCollapseButtonChangesDisplay.oneManyLanes;
          };

          zoomScrollOffset = {
            verticalZoomCenter = reaperAppearance.zoomScrollOffset.zoomCenter.vertical.lastSelectedTrack;
            maximumVerticalZoom = 0.90;
            envelopeLaneVerticalZoom = 0.5;
            horizontalZoomCenter = reaperAppearance.zoomScrollOffset.zoomCenter.horizontal.mouseCursor;

            limitHorizontalZoomScrollToProjectStart = true;
            verticalScrollStep = {
              unit = reaperAppearance.zoomScrollOffset.verticalScrollStep.units.trackHeight;
              trackHeight = 0.5;
              arrangeViewHeight = 0.1;
            };
            disableMousewheelVerticalZoomForTracksThatArePinnedInArrangeView = true;
            overlappingMediaItems = {
              offset = 100;
              drawAsOpaque = true;
              arrangeInCreationOrder = false;
            };
          };
        };

        editingBehavior = {
          mouseModifiers = {
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
        };

        plugIns.reascript.python.enable = true;
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
              shortcut = "Ctrl+Shift+I";
              command = 40214;
              actionName = "Insert Midi item";
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

      menus = {
        "${reaperMenus.toolbars.main}" = {
          entries = [
            {
              action = 40021;
              label = "Project settings...";
            }
            {
              action = 43645;
              label = "New project...";
            }
            {
              action = 40025;
              label = "Open project...";
            }
            {
              action = 40026;
              label = "Save project";
            }
            reaperMenus.divider
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
              action = 42616;
              label = "Marquee selection";
              toolbarFlags = 1;
            }
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
              action = 40145;
              label = "Show arrange view grid";
            }
            {
              action = 1157;
              label = "Enable snapping";
            }
            {
              action = 1135;
              label = "Enable locking";
            }
            {
              action = 42336;
              label = "Toggle track height lock";
              icon = "toolbar_zoom_selected.png";
            }
            {
              action = 42618;
              label = "Razor editing";
              toolbarFlags = 1;
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

      layout = {
        docks = {
          bottom = {
            id = 3;
            position = "bottom";
            selectedPanel = "mixer";
          };

          left = {
            id = 2;
            position = "left";
            size = 395;
            selectedPanel = "explorer";
          };

          right = {
            id = 1;
            position = "right";
            selectedPanel = "mastermixer";
          };
        };

        transport = {
          visible = true;
          dockPosition = reaperWindows.transport.topOfMainWindow;
        };

        masterMixer = {
          visible = true;
          docked = true;
          dock = "right";
          tabOrder = 0.0;
        };

        mixer = {
          visible = false;
          docked = true;
          dock = "bottom";
          tabOrder = 0.0;
        };

        panels.explorer = {
          id = "explorer";
          section = "reaper_sexplorer";
          keyStyle = "window";
          visible = false;
          docked = true;
          dock = "left";
          tabOrder = 0.5;
        };
      };

      theme = {
        active = "Reapertips Theme.ReaperThemeZip";
        packages = [
          inputs.reaper-flake.packages.${pkgs.system}.smooth6-theme
          inputs.reaper-flake.packages.${pkgs.system}.reapertips-theme
        ];
      };

      swell.colortheme = {
        enable = true;
        preset = "stylix";
      };
    };

    persist.directories = [".config/${reaper-config}"];
  };
}
