{ config, pkgs, ... }:

{
    home-manager.users.${config.user} = {

        home.packages = with pkgs; [
            neovim
            neovim-remote
            tree-sitter
        ];

    };

}