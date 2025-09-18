{ config, pkgs, ... }:

{
    home-manager.users.${config.user} = {

        programs.neovim = {
            enable = true;
            viAlias = true;
            vimAlias = true;
            package = pkgs.neovim.override {
                withNodeJs = true;
                withPython = true;
                withRuby = false;
                withPerl = false;
                withLua = true;
            };
            extraConfig = ''
                set number
                set relativenumber
                set tabstop=4
                set shiftwidth=4
                set expandtab
                set smartindent
                set clipboard=unnamedplus
                syntax on
                filetype plugin indent on
            '';
        };

    };

}