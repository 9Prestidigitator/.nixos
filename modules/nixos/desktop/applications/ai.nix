{inputs, ...}: {
  flake.nixosModules.ai = {pkgs, ...}: {
    imports = [inputs.hermes-agent.nixosModules.default];

    services.hermes-agent = {
      enable = true;
      settings.model = {
        provider = "openai-codex";
        default = "gpt-5.4-mini";
      };
      addToSystemPackages = true;
    };

    environment.systemPackages = with pkgs; [codex];

    persist.userDirs = [
      ".codex"
      ".claude"
      ".hermes"
    ];
  };
}
