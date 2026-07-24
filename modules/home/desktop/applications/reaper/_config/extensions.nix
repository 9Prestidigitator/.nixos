{
  programs.reaper = {
    extensions = {
      reapack = {
        enable = true;

        repositories = [
          {
            name = "reaper-keys";
            url = "https://raw.githubusercontent.com/gwatcha/reaper-keys/master/index.xml";
          }
        ];

        packages = [
          {
            repository = "MPL Scripts";
            category = "FX";
            name = "mpl_Toggle bypass FX with latency (PDC) higher than X samples.lua";
          }
        ];

        promptToUninstallObsoletePackages = true;
        synchronizeOnActivation = true;
      };

      sws.enable = true;
    };
  };
}
