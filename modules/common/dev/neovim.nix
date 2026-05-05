# Neovim configuration using the LazyVim+NixVim setup from github:azuwis/lazyvim-nixvim
# with eca-nvim enabled per editor-code-assistant/eca-nvim installation docs.
{ config, lib, pkgs, inputs, ... }:

{
    options.neovim.enable = lib.mkEnableOption "nixvim-based Neovim with LazyVim and eca-nvim";

    config = lib.mkIf config.neovim.enable (
        let
            # Build eca-nvim from its pinned source in flake.lock
            eca-nvim-plugin = pkgs.vimUtils.buildVimPlugin {
                name = "eca-nvim";
                src = inputs.eca-nvim;
            };

            # mini.nvim provides multiple submodules under different names
            miniNvim = pkgs.vimPlugins.mini-nvim;

            # All lazy-managed plugins – mirrors azuwis/lazyvim-nixvim plus eca-nvim deps.
            # nui-nvim, plenary-nvim, and snacks-nvim are already present and satisfy
            # eca-nvim's required and optional dependency requirements.
            plugins = with pkgs.vimPlugins; [
                LazyVim
                bufferline-nvim
                cmp-buffer
                cmp-nvim-lsp
                cmp-path
                conform-nvim
                dashboard-nvim
                dressing-nvim
                flash-nvim
                friendly-snippets
                gitsigns-nvim
                grug-far-nvim
                indent-blankline-nvim
                lazydev-nvim
                lualine-nvim
                luvit-meta
                neo-tree-nvim
                noice-nvim
                nui-nvim          # required by eca-nvim
                nvim-cmp
                nvim-lint
                nvim-lspconfig
                nvim-snippets
                nvim-treesitter
                nvim-treesitter-textobjects
                nvim-ts-autotag
                persistence-nvim
                plenary-nvim      # optional for eca-nvim (enhanced async operations)
                snacks-nvim       # optional for eca-nvim (picker for server messages/tools)
                telescope-fzf-native-nvim
                telescope-nvim
                todo-comments-nvim
                tokyonight-nvim
                trouble-nvim
                ts-comments-nvim
                which-key-nvim
                { name = "catppuccin"; path = catppuccin-nvim; }
                { name = "mini.ai"; path = miniNvim; }
                { name = "mini.icons"; path = miniNvim; }
                { name = "mini.pairs"; path = miniNvim; }
                # eca-nvim itself
                eca-nvim-plugin
            ];

            mkEntryFromDrv = drv:
                if lib.isDerivation drv then
                    { name = "${lib.getName drv}"; path = drv; }
                else
                    drv;

            lazyPath = pkgs.linkFarm "lazy-plugins" (builtins.map mkEntryFromDrv plugins);

        in {
            home-manager.users.${config.user}.programs.nixvim = {
                enable = true;

                # Reduce closure size (mirrors lazyvim-nixvim defaults)
                enableMan = false;
                withPython3 = false;
                withRuby = false;

                extraPackages = with pkgs; [
                    # LazyVim tooling
                    lua-language-server
                    stylua
                    # Telescope
                    ripgrep
                    # eca-nvim system requirements
                    curl
                    unzip
                ];

                # Only lazy-nvim itself needs to be on neovim's rtp at startup;
                # all other plugins are managed by lazy.nvim via the linkFarm.
                extraPlugins = [ pkgs.vimPlugins.lazy-nvim ];

                extraConfigLua = ''
                    require("lazy").setup({
                      defaults = {
                        lazy = true,
                      },
                      dev = {
                        -- Reuse files from pkgs.vimPlugins.* via the Nix-built linkFarm
                        path = "${lazyPath}",
                        patterns = { "" },
                        -- Fall back to downloading if a plugin is missing from the store
                        fallback = true,
                      },
                      spec = {
                        { "LazyVim/LazyVim", import = "lazyvim.plugins" },
                        -- Required fixes for LazyVim on Nix (from azuwis/lazyvim-nixvim)
                        { "nvim-telescope/telescope-fzf-native.nvim", enabled = true },
                        { "williamboman/mason-lspconfig.nvim", enabled = false },
                        { "williamboman/mason.nvim", enabled = false },
                        -- eca-nvim plugin with its dependencies
                        {
                          "editor-code-assistant/eca-nvim",
                          dependencies = {
                            "MunifTanjim/nui.nvim",     -- required: UI framework
                            "nvim-lua/plenary.nvim",    -- optional: enhanced async operations
                            "folke/snacks.nvim",        -- optional: picker for server messages/tools
                          },
                          opts = {},
                        },
                        -- Clear ensure_installed to avoid mason downloads
                        { "nvim-treesitter/nvim-treesitter", opts = function(_, opts) opts.ensure_installed = {} end },
                      },
                    })
                '';
            };
        }
    );
}
