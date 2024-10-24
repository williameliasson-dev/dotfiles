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
    ];

    plugins = {
      which-key = {
        enable = true;
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

      # Language server
      lsp = {
        enable = true;
        servers = {
          # Average webdev LSPs
          tsserver.enable = true; # TS/JS
          cssls.enable = true; # CSS
          tailwindcss.enable = true; # TailwindCSS
          html.enable = true; # HTML
          pyright.enable = true; # Python
          marksman.enable = true; # Markdown
          nil-ls.enable = true; # Nix
          dockerls.enable = true; # Docker
          bashls.enable = true; # Bash
          clangd.enable = true; # C/C++
          csharp-ls.enable = true; # C#
          yamlls.enable = true; # YAML

          lua-ls = {
            # Lua
            enable = true;
            settings.telemetry.enable = false;
          };

          # Rust
          rust-analyzer = {
            enable = true;
            installRustc = true;
            installCargo = true;
          };
        };
      };

      telescope = {
        enable = true;
      };
    };
  };
}
