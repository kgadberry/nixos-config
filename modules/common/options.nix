{ config, lib, ... }:

{
    options = {
        user = lib.mkOption {
            type = lib.types.str;
            description = "Primary user of the system.";
        };
        fullName = lib.mkOption {
            type = lib.types.str;
            description = "Human readable name of the user.";
        };
        identityFile = lib.mkOption {
            type = lib.types.str;
            description = "Path to existing private key file.";
            default = "/etc/ssh/ssh_host_ed25519_key";
        };
        gui = {
            enable = lib.mkEnableOption {
                description = "Enable graphics.";
                default = false;
            };
        };
        homePath = lib.mkOption {
            type = lib.types.path;
            description = "Path of user's home directory.";
            default = builtins.toPath ("/home/${config.user}");
        };
        dotfilesPath = lib.mkOption {
            type = lib.types.path;
            description = "Path of dotfiles repository.";
            default = config.homePath + "/.nixos-config";
        };
        dotfilesRepo = lib.mkOption {
            type = lib.types.str;
            description = "Link to dotfiles repository.";
        };
        unfreePackages = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            description = "List of unfree packages to allow.";
            default = [ ];
        };
    };

    config.home-manager.users.root.home.stateVersion = "25.11";
    config.home-manager.users.${config.user}.home = {
        stateVersion = "25.11";

        sessionVariables = {
            NIX_CONFIG = "experimental-features = nix-command flakes";
        };
    };
}
