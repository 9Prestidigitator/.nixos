{inputs, ...}: {
  flake.nixosModules.surface-6 = {pkgs, ...}: {
    imports = [inputs.nixos-hardware.nixosModules.microsoft-surface-common];

    boot = {
      kernelParams = ["mem_sleep_default=deep" "kernel.nmi_watchdog=0" "vm.dirty_writeback_centisecs=1500"];
      extraModprobeConfig = ''
        options i915 enable_fbc=1 enable_rc6=1 modeset=1
        options snd_hda_intel power_save=1
        options snd_ac97_codec power_save=1
        options iwldvm force_cam=N
        options iwlwifi power_save=N
        options iwlmvm power_schema=1
      '';
      initrd = {
        availableKernelModules = ["xhci_pci" "nvme" "usbhid"];
        kernelModules = ["surface_aggregator" "surface_aggregator_registry" "surface_aggregator_hub"];
      };
      kernelPatches = [
        {
          name = "surface-config";
          patch = null;
          # Options from https://github.com/linux-surface/linux-surface/blob/master/configs/surface-6.18.config
          extraConfig = ''
            SURFACE_AGGREGATOR m
            SURFACE_AGGREGATOR_ERROR_INJECTION n
            SURFACE_AGGREGATOR_BUS y
            SURFACE_AGGREGATOR_CDEV m
            SURFACE_AGGREGATOR_HUB m
            SURFACE_AGGREGATOR_REGISTRY m
            SURFACE_AGGREGATOR_TABLET_SWITCH m

            SURFACE_ACPI_NOTIFY m
            SURFACE_DTX m
            SURFACE_PLATFORM_PROFILE m

            SURFACE_HID m
            SURFACE_KBD m

            BATTERY_SURFACE m
            CHARGER_SURFACE m

            SENSORS_SURFACE_TEMP m
            SENSORS_SURFACE_FAN m

            RTC_DRV_SURFACE m

            SURFACE_HOTPLUG m

            HID_IPTS m
            HID_ITHC m
            INTEL_THC_HID m
            INTEL_QUICKSPI m

            VIDEO_DW9719 m
            VIDEO_IPU3_IMGU m
            VIDEO_IPU3_CIO2 m
            IPU_BRIDGE m
            INTEL_SKL_INT3472 m
            REGULATOR_TPS68470 m
            COMMON_CLK_TPS68470 m
            LEDS_TPS68470 m

            VIDEO_OV5693 m
            VIDEO_OV7251 m
            VIDEO_OV8865 m

            INPUT_SOC_BUTTON_ARRAY m
            SURFACE_3_POWER_OPREGION m
            SURFACE_PRO3_BUTTON m
            SURFACE_GPE m
            SURFACE_BOOK1_DGPU_SWITCH m
            HID_SURFACE m
          '';
        }
      ];
    };

    # The default tty font size is too small!
    console.font = "ter-v32b";

    hardware = {
      microsoft-surface.kernelVersion = "longterm";
      sensor.iio.enable = true;
    };

    environment.systemPackages = with pkgs; [iptsd surface-control libinput libinput-gestures];
    services.udev.packages = with pkgs; [iptsd surface-control];
  };
}
