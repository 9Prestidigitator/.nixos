{
  reaperGeneral,
  reaperAppearance,
  reaperMouse,
  reaperEditingBehavior,
  ...
}: {
  programs.reaper = {
    preferences = {
      general = {
        startupSettings = {
          openProjectOnStartup = reaperGeneral.openProjectOnStartup.prompt;
          createNewProjectTabWhenOpeningMedia = true;
          skipAnimation = false;
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

      project = {
        trackSendDefaults = {
          trackVolumeFaderGain = -10.0;
          mainParentSend = true;
          showInMixer = true;
        };

        backups = {
          whenSaving = {
            preservePreviouslySavedVersionOfProjectAsProjectRppBak = false;
            preserveAllPreviouslySavedVersionsOfProjectInOneLargeProjectRppBak = false;
            preservePreviouslySavedVersionsOfProjectAsProjectTimestampRppBak = {
              enable = true;
              saveTimestampedBackupsToBackupsProjectSubdirectory = true;
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
        midiEditor = {
          oneMidiEditorPer = reaperEditingBehavior.midiEditorPer.project;
          behaviorForOpenItemsInBuiltInMidiEditor = reaperEditingBehavior.openItemsInBuiltInMidiEditor.openAllSelectedMidiItems;
          whenUsingOneMidiEditorPerProject = {
            activeMidiItemFollowsSelectionChangesInArrangeView = {
              enable = true;
              type = reaperEditingBehavior.arrangeSelection.mediaItem;
            };
            selectionIsLinkedToVisibility = true;
            selectionIsLinkedToEditability = true;
            closeEditorWhenTheActiveItemIsDeletedInTheArrangeView = false;
          };
          avoid = {
            settingItemsOnOtherTracksEditable = true;
            settingItemsOnNonPlayingLanesVisible = true;
          };
          doubleClickOutsideTheBoundsOfAnyMediaItemToExtendTheNearestMedia = false;
        };
      };

      plugIns.reascript.python.enable = true;
    };
  };
}
