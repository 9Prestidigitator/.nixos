{inputs, ...}: {
  flake.nixosModules.nix = {
    pkgs,
    lib,
    ...
  }: {
    imports = [inputs.nix-index-database.nixosModules.default];
    environment.systemPackages = with pkgs; [nix-inspect];

    programs = {
      nix-ld.enable = true;
      nix-index-database.comma.enable = true;
    };

    nixpkgs.config.allowUnfree = true;

    nix = {
      gc = {
        automatic = lib.mkDefault true;
        dates = lib.mkDefault "weekly";
        options = lib.mkDefault "--delete-older-than 7d";
      };
      settings = {
        experimental-features = ["nix-command" "flakes"];
        # TODO(max): Do more research into the implications of including guest in this
        allowed-users = ["@wheel" "guest"];
        trusted-users = ["@wheel" "nixremote"];
      };
    };
  };
}
