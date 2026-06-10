{inputs, ...}: {
  flake.nixosModules.noctalia-greeter = {
    imports = [inputs.noctalia-greeter.nixosModules.default];

    programs.noctalia-greeter = {
      enable = true;
      greeter-args = "--session niri";
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
