{ config, ... }: {

    imports = [        
        ./cpp.nix
        ./embedded.nix
        ./python.nix
        ./java.nix
        ./nodejs.nix
        ./agents.nix
        ./neovim.nix
    ];

    config.home-manager.users.${config.user}.programs.zsh.shellAliases = {
        kdevshell = "nix develop nixos-config -c zsh -i";
    };
}