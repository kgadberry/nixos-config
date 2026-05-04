{ config, pkgs, inputs, ... }:

{
    home-manager.users.${config.user} = {
	programs.nixvim = {
	    imports = [
                ./config
            ];

            enable = true;
	};

        home.sessionVariables = {
            EDITOR = "nvim";
       };

    };

}
