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
            ##
            ## Surface Aggregator Module
            ##
            CONFIG_SURFACE_AGGREGATOR=m
            # CONFIG_SURFACE_AGGREGATOR_ERROR_INJECTION is not set
            CONFIG_SURFACE_AGGREGATOR_BUS=y
            CONFIG_SURFACE_AGGREGATOR_CDEV=m
            CONFIG_SURFACE_AGGREGATOR_HUB=m
            CONFIG_SURFACE_AGGREGATOR_REGISTRY=m
            CONFIG_SURFACE_AGGREGATOR_TABLET_SWITCH=m

            CONFIG_SURFACE_ACPI_NOTIFY=m
            CONFIG_SURFACE_DTX=m
            CONFIG_SURFACE_PLATFORM_PROFILE=m

            CONFIG_SURFACE_HID=m
            CONFIG_SURFACE_KBD=m

            CONFIG_BATTERY_SURFACE=m
            CONFIG_CHARGER_SURFACE=m

            CONFIG_SENSORS_SURFACE_TEMP=m
            CONFIG_SENSORS_SURFACE_FAN=m

            CONFIG_RTC_DRV_SURFACE=m

            ##
            ## Surface Hotplug
            ##
            CONFIG_SURFACE_HOTPLUG=m

            ##
            ## IPTS and ITHC touchscreen
            ##
            ## This only enables the user interface for IPTS/ITHC data.
            ## For the touchscreen to work, you need to install iptsd.
            ##
            CONFIG_HID_IPTS=m
            CONFIG_HID_ITHC=m
            CONFIG_INTEL_THC_HID=m
            CONFIG_INTEL_QUICKSPI=m

            ##
            ## Cameras: IPU3
            ##
            CONFIG_VIDEO_DW9719=m
            CONFIG_VIDEO_IPU3_IMGU=m
            CONFIG_VIDEO_IPU3_CIO2=m
            CONFIG_IPU_BRIDGE=m
            CONFIG_INTEL_SKL_INT3472=m
            CONFIG_REGULATOR_TPS68470=m
            CONFIG_COMMON_CLK_TPS68470=m
            CONFIG_LEDS_TPS68470=m

            ##
            ## Cameras: Sensor drivers
            ##
            CONFIG_VIDEO_OV5693=m
            CONFIG_VIDEO_OV7251=m
            CONFIG_VIDEO_OV8865=m

            ##
            ## Other Drivers
            ##
            CONFIG_INPUT_SOC_BUTTON_ARRAY=m
            CONFIG_SURFACE_3_POWER_OPREGION=m
            CONFIG_SURFACE_PRO3_BUTTON=m
            CONFIG_SURFACE_GPE=m
            CONFIG_SURFACE_BOOK1_DGPU_SWITCH=m
            CONFIG_HID_SURFACE=m
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
