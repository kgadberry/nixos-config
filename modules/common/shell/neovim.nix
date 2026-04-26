{ config, pkgs, inputs, ... }:

{
    home-manager.users.${config.user} = {
	programs.nixvim = {
            enable = true;

	    colorschemes.catppuccin.enable = true;
            plugins.lualine.enable = true;
#	    plugins.claude-code.enable = true;
	    plugins.floaterm.enable = true;
	};

        home.sessionVariables = {
            EDITOR = "nvim";
       };

    };

}
