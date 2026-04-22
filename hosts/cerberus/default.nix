# system configuration for WSL on workstation (cerberus)

{ inputs, globals, overlays, ... }:

with inputs;

nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    # nixpkgs-unstable exposes legacyPackages for system pkgsets
    specialArgs = { unstable = inputs.nixpkgs-unstable.legacyPackages.x86_64-linux; };
    modules = [
        ../../modules/common
        ../../modules/nixos
        ../../modules/wsl
        globals
        wsl.nixosModules.wsl
        home-manager.nixosModules.home-manager
        ({ config, pkgs, lib, ... }: {
            system.stateVersion = "25.11";
            networking = {
                hostName = "cerberus";
                # TODO: make tailscale integration more declarative?
                search = ["tail1e793.ts.net"]; 
                nameservers = ["10.255.255.254"];
            };
            nixpkgs.overlays = overlays;
            # set registry to flake packages, used for nix X commands
            nix.registry.nixpkgs.flake = nixpkgs;
            nix.registry.nixos-config.to = {
                type = "path";
                path = "/home/${globals.user}/.nixos-config";
            };
            # Allow the claude-code package (proprietary) while keeping others disallowed
            nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "claude-code" ];
            identityFile = "/home/${globals.user}/.ssh/id_ed25519";
            gui.enable = true;
            desktop.gdm.enable = true;
            # TODO: fix this
            passwordHash = nixpkgs.lib.fileContents ../../password.sha512;
            wsl = {
                enable = true;
                wslConf.automount.root = "/mnt";
                defaultUser = globals.user;
                startMenuLaunchers = true;
                wslConf.network.generateResolvConf = false; # disabled because it breaks tailscale
                interop.includePath = true; # include Windows PATH
            };
            # Add claude-code package to system packages (provided by overlay)
            environment.systemPackages = with pkgs; [ claude-code ];
        })
    ];
}