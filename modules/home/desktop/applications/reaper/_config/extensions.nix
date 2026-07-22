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
        synchronizeOnActivation = true;
      };

      sws.enable = true;
    };
  };
}
