{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    colorschemes.gruvbox.enable = true;
    globals.mapleader = " ";

    autoCmd = [
      {
        event = "BufWritePre";
        command = "lua vim.lsp.buf.format()";
      }
    ];

    keymaps = [
      # HOP

      {
        key = "f";
        action.__raw = "function() require('hop').hint_char1({ direction = require('hop.hint').HintDirection.AFTER_CURSOR }) end";
        options.remap = true;
      }
      {
        key = "F";
        action.__raw = "function() require('hop').hint_char1({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR }) end";
        options.remap = true;
      }

      #TELESCOPE

      {
        action = "<cmd>Telescope live_grep<CR>";
        key = "<leader>fw";
      }
      {
        action = "<cmd>Telescope find_files<CR>";
        key = "<leader>ff";
      }
      {
        action = "<cmd>Telescope git_commits<CR>";
        key = "<leader>fg";
      }
      {
        action = "<cmd>Telescope oldfiles<CR>";
        key = "<leader>fh";
      }
      {
        action = "<cmd>Telescope colorscheme<CR>";
        key = "<leader>ch";
      }

      {
        action = "<cmd>Telescope man_pages<CR>";
        key = "<leader>fm";
      }
      {
        mode = [ "i" "x" "n" "s" ];
        key = "<C-s>";
        action = "<cmd>w<cr><esc>";
        options = { desc = "Save File"; };
      }

      #NONE-LS

      {
        key = "<leader>dl";
        action.__raw = ''
          function()
            vim.diagnostic.open_float({ scope = "line" })
          end
        '';
        options = {
          desc = "View current line diagnostics";
          silent = true;
        };
      }

      # CMP
      {
        mode = "i";
        key = "<Tab>";
        action.__raw = "function() local cmp = require('cmp') if cmp.visible() then return cmp.mapping.confirm({select = true})() end return '<Tab>' end";
        options = {
          expr = true;
          silent = true;
        };
      }
      {
        mode = "i";
        key = "<C-j>";
        action.__raw = ''
          function()
            local cmp = require('cmp')
            if cmp.visible() then
              return cmp.mapping.select_next_item()()
            end
          end
        '';
        options.silent = true;
      }
      {
        mode = "i";
        key = "<C-k>";
        action.__raw = ''
          function()
            local cmp = require('cmp')
            if cmp.visible() then
              return cmp.mapping.select_prev_item()()
            end
          end
        '';
        options.silent = true;
      }
      {
        mode = "i";
        key = "<C-e>";
        action.__raw = ''
          function()
            local cmp = require('cmp')
            if cmp.visible() then
              return cmp.mapping.abort()()
            end
          end
        '';
        options = {
          silent = true;
          desc = "Cancel completion";
        };
      }
    ];

    plugins = {
      web-devicons = {
        enable = true;
      };

      which-key = {
        enable = true;
      };

      luasnip.enable = true;

      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          snippet = {
            expand = ''              function(args)
                          require('luasnip').lsp_expand(args.body)
                        end'';
          };
          sources = [
            { name = "luasnip"; }
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "buffer"; }
          ];
        };
      };

      hop = {
        enable = true;
      };

      none-ls = {
        enable = true;
        sources = {
          code_actions = {
            statix.enable = true;
            gitsigns.enable = true;
          };
          diagnostics = {
            statix.enable = true;
            deadnix.enable = true;
            pylint.enable = true;
            checkstyle.enable = true;
          };
          formatting = {
            alejandra.enable = true;
            stylua.enable = true;
            shfmt.enable = true;
            nixpkgs_fmt.enable = true;
            google_java_format.enable = false;
            prettier = {
              enable = true;
              disableTsServerFormatter = true;
            };
          };
          completion = {
            luasnip.enable = true;
            spell.enable = true;
          };
        };
      };

      nix = {
        enable = true;
      };

      presence-nvim = {
        enable = true;
      };

      # Language server
      lsp = {
        enable = true;
        servers = {
          # Average webdev LSPs
          ts_ls.enable = true; # TS/JS
          cssls.enable = true; # CSS
          tailwindcss.enable = true; # TailwindCSS
          html.enable = true; # HTML
          pyright.enable = true; # Python
          marksman.enable = true; # Markdown
          nil_ls.enable = true; # Nix
          dockerls.enable = true; # Docker
          bashls.enable = true; # Bash
          clangd.enable = true; # C/C++
          csharp_ls.enable = true; # C#
          yamlls.enable = true; # YAML

          lua_ls = {
            # Lua
            enable = true;
            settings.telemetry.enable = false;
          };

          # Rust
          rust_analyzer = {
            enable = true;
            installRustc = true;
            installCargo = true;
            settings = {
              procMacro = {
                enable = true;
              };
              checkOnSave = true;
              command = "clippy";
            };
          };
        };
      };

      telescope = {
        enable = true;
      };
    };
  };
}
