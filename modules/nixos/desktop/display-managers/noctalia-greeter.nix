{
  flake.nixosModules.noctalia-greeter = {
    services.displayManager.noctalia-greeter = {
      enable = true;
      settings.cursor.size = 24;
    };

    persist.directories = [
      {
        directory = "/var/lib/noctalia-greeter";
        user = "greeter";
        group = "greeter";
        mode = "0755";
      }
    ];
  };
}
