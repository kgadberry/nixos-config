{ config, pkgs, ... }:

{
    home-manager.users.${config.user} = {

        #TODO: use nixvim
        home.packages = with pkgs; [
            neovim
            neovim-remote
            tree-sitter
        ];

    };

}