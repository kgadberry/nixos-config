{ config, ... }: {
    home-manager.users.${config.user}.programs.zsh.shellAliases = {
        kdevshell = "nix develop nixos-config -c zsh -i";
    };
}
