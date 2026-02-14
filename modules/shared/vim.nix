{ pkgs, ... }:
{
  programs.nixvim = {
    config = {
      enable = true;
      defaultEditor = true;
      colorschemes.gruvbox.enable = true;
      globals.mapleader = " ";
      opts = {
        number = true;
        spell = true;
        spelllang = [
          "en_gb"
          "sv"
        ];
        clipboard = "unnamedplus"; # Enable system clipboard integration
      };

      autoCmd = [
        {
          event = "BufWritePre";
          command = "lua vim.lsp.buf.format()";
        }
      ];

      keymaps = [
        # Visual mode ctrl+shift+c to copy to clipboard
        {
          mode = "v";
          key = "<C-S-c>";
          action = "\"+y";
          options = {
            desc = "Copy selection to system clipboard";
          };
        }

        # Disable arrow keys
        {
          key = "<Up>";
          action = "<Nop>";
          options = {
            desc = "Disable up arrow key";
          };
        }
        {
          key = "<Down>";
          action = "<Nop>";
          options = {
            desc = "Disable down arrow key";
          };
        }
        {
          key = "<Left>";
          action = "<Nop>";
          options = {
            desc = "Disable left arrow key";
          };
        }
        {
          key = "<Right>";
          action = "<Nop>";
          options = {
            desc = "Disable right arrow key";
          };
        }

        # Disable arrow keys in insert mode
        {
          mode = "i";
          key = "<Up>";
          action = "<Nop>";
          options = {
            desc = "Disable up arrow key in insert mode";
          };
        }
        {
          mode = "i";
          key = "<Down>";
          action = "<Nop>";
          options = {
            desc = "Disable down arrow key in insert mode";
          };
        }
        {
          mode = "i";
          key = "<Left>";
          action = "<Nop>";
          options = {
            desc = "Disable left arrow key in insert mode";
          };
        }
        {
          mode = "i";
          key = "<Right>";
          action = "<Nop>";
          options = {
            desc = "Disable right arrow key in insert mode";
          };
        }

        # YAZI
        {
          key = "<leader>fy";
          action = "<cmd>Yazi<CR>";
          options = {
            desc = "Open Yazi file manager";
          };
        }

        # HOP

        {
          key = "f";
          action.__raw = "function() require('hop').hint_char1({ direction = require('hop.hint').HintDirection.AFTER_CURSOR }) end";
          options = {
            remap = true;
            desc = "Hop after cursor";
          };
        }
        {
          key = "F";
          action.__raw = "function() require('hop').hint_char1({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR }) end";
          options = {
            remap = true;
            desc = "Hop after cursor";
          };
        }

        # Terminal
        {
          mode = [ "t" ];
          key = "<Esc><Esc>";
          action = "<C-\\><C-n>";
          options.desc = "Exit terminal mode";
        }

        # Opencode
        {
          mode = [
            "n"
            "v"
          ];
          key = "<leader>aa";
          action.__raw = "function() require('opencode').ask('@this: ', { submit = true }) end";
          options.desc = "Ask opencode";
        }
        {
          mode = [
            "n"
            "v"
          ];
          key = "<leader>ac";
          action.__raw = "function() require('opencode').toggle() end";
          options.desc = "Toggle opencode";
        }
        {
          mode = [
            "n"
            "v"
          ];
          key = "<leader>as";
          action.__raw = "function() require('opencode').select() end";
          options.desc = "Opencode select";
        }

        #TELESCOPE

        {
          action = "<cmd>Telescope live_grep<CR>";
          key = "<leader>fw";
          options = {
            desc = "Live Grep";
          };
        }
        {
          action = "<cmd>Telescope find_files<CR>";
          key = "<leader>ff";
          options = {
            desc = "Find files";
          };
        }
        {
          action = "<cmd>Telescope git_commits<CR>";
          key = "<leader>fg";
          options = {
            desc = "Browse git commits";
          };
        }
        {
          action = "<cmd>Telescope oldfiles<CR>";
          key = "<leader>fh";
          options = {
            desc = "Browse accessed files";
          };
        }
        {
          action = "<cmd>Telescope colorscheme<CR>";
          key = "<leader>ch";
          options = {
            desc = "Change colorscheme";
          };
        }

        {
          action = "<cmd>Telescope man_pages<CR>";
          key = "<leader>fm";
        }

        # FUGITIVE
        {
          action = "<cmd>Git<CR>";
          key = "<leader>gs";
          options = {
            desc = "Git status";
          };
        }
        {
          action = "<cmd>Gvdiffsplit @{upstream}<CR>";
          key = "<leader>gd";
          options = {
            desc = "Git vertical diff split against remote";
          };
        }
        {
          action = "<cmd>Git commit<CR>";
          key = "<leader>gc";
          options = {
            desc = "Git commit";
          };
        }
        {
          action = "<cmd>Git add %<CR>";
          key = "<leader>ga";
          options = {
            desc = "Git add current file";
          };
        }
        {
          action = "<cmd>Git add .<CR>";
          key = "<leader>gA";
          options = {
            desc = "Git add all files";
          };
        }
        {
          key = "<leader>gp";
          action.__raw = ''
            function()
              local commit = vim.fn.system("git blame -l -L " .. vim.fn.line(".") .. "," .. vim.fn.line(".") .. " -- " .. vim.fn.expand("%") .. " | awk '{print $1}'"):gsub("%s+", "")
              if commit and commit ~= "" and not commit:match("^0+$") then
                vim.fn.system("gh pr list --search " .. commit .. " --state merged --json url --jq '.[0].url' | xargs xdg-open")
              else
                vim.notify("No commit found for this line", vim.log.levels.WARN)
              end
            end
          '';
          options = {
            desc = "Open PR for current line";
          };
        }

        # DAP (Debug Adapter Protocol)
        {
          action.__raw = "function() require('dap').continue() end";
          key = "<leader>dc";
          options = {
            desc = "Debug: Continue";
          };
        }
        {
          action.__raw = "function() require('dap').step_over() end";
          key = "<leader>do";
          options = {
            desc = "Debug: Step Over";
          };
        }
        {
          action.__raw = "function() require('dap').step_into() end";
          key = "<leader>di";
          options = {
            desc = "Debug: Step Into";
          };
        }
        {
          action.__raw = "function() require('dap').step_out() end";
          key = "<leader>dO";
          options = {
            desc = "Debug: Step Out";
          };
        }
        {
          action.__raw = "function() require('dap').toggle_breakpoint() end";
          key = "<leader>db";
          options = {
            desc = "Debug: Toggle Breakpoint";
          };
        }
        {
          action.__raw = "function() require('dap').terminate() end";
          key = "<leader>dt";
          options = {
            desc = "Debug: Terminate";
          };
        }
        {
          action.__raw = "function() require('dapui').toggle() end";
          key = "<leader>du";
          options = {
            desc = "Debug: Toggle UI";
          };
        }
        {
          action = "<cmd>split ~/.local/share/nvim/dap.log<CR>";
          key = "<leader>dl";
          options = {
            desc = "Debug: Show DAP logs";
          };
        }
        {
          action = "<cmd>Telescope lsp_definitions<CR>";
          key = "gd";
          options = {
            desc = "Jump to definition";
          };
        }
        {
          action = "<cmd>Telescope lsp_references<CR>";
          key = "gr";
          options = {
            desc = "Go to references";
          };
        }
        {
          key = "<leader>w";
          action = "<cmd>w<cr><esc>";
          options = {
            desc = "Save File";
          };
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
          key = "<C-Space>";
          action.__raw = ''
            function()
              local cmp = require('cmp')
              if not cmp.visible() then
                return cmp.complete()
              end
            end
          '';
          options = {
            silent = true;
            desc = "Trigger suggestions";
          };
        }

        {
          mode = "i";
          key = "<C-y>";
          action = "<Cmd>lua require('cmp').confirm({ select = true })<CR>";
          options = {
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

      extraConfigLua = ''
        -- Wilder configuration for nice popup menus
        local wilder = require('wilder')

        wilder.set_option('renderer', wilder.popupmenu_renderer(
          wilder.popupmenu_border_theme({
            highlights = {
              border = 'Normal',
              accent = wilder.make_hl('WilderAccent', 'Pmenu', {{a = 1}, {a = 1}, {foreground = '#f4468f'}}),
            },
            border = 'rounded',
            max_height = '30%',
            min_height = 0,
            prompt_position = 'top',
            reverse = 0,
            left = {' ', wilder.popupmenu_devicons()},
            right = {' ', wilder.popupmenu_scrollbar()},
          })
        ))

        -- Enable fuzzy matching with vim's built-in fuzzy filter
        wilder.set_option('pipeline', {
          wilder.branch(
            wilder.cmdline_pipeline({
              fuzzy = 1,
              fuzzy_filter = wilder.vim_fuzzy_filter(),
            }),
            wilder.vim_search_pipeline({
              fuzzy = 1,
            })
          ),
        })
      '';

      plugins = {
        comment = {
          enable = true;
        };

        wilder = {
          enable = true;
          settings.modes = [
            ":"
            "/"
            "?"
          ];
        };

        gitblame = {
          enable = true;
          settings = {
            currentLineBlame = true;
            currentLineBlameFormatter = ''
              function(blame)
                return blame
              end'';
            currentLineBlameDelay = 1000;
            currentLineBlamePriority = 10;
          };
        };

        treesitter = {
          enable = true;
          settings = {
            ensure_installed = [
              "bash"
              "c"
              "cpp"
              "css"
              "dockerfile"
              "go"
              "html"
              "javascript"
              "json"
              "lua"
              "markdown"
              "markdown_inline"
              "nix"
              "python"
              "typescript"
              "yaml"
            ];
            highlight = {
              enable = true;
            };
            indent = {
              enable = true;
            };
          };
        };

        web-devicons = {
          enable = true;
        };

        which-key = {
          enable = true;
        };

        friendly-snippets = {
          enable = true;
        };

        luasnip.enable = true;

        cmp = {
          enable = true;
          autoEnableSources = true;
          settings = {
            snippet = {
              expand = ''
                function(args)
                            require('luasnip').lsp_expand(args.body)
                          end'';
            };
            sources = [
              {
                name = "copilot";
                priority = 1000;
              }
              {
                name = "nvim_lsp";
                priority = 900;
              }
              {
                name = "luasnip";
                priority = 800;
              }
              {
                name = "path";
                priority = 700;
              }
              {
                name = "buffer";
                priority = 600;
              }
            ];
          };
        };

        hop = {
          enable = true;
        };

        # Yazi file manager plugin
        yazi = {
          enable = true;
        };

        copilot-lua = {
          enable = true;
        };

        copilot-cmp = {
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
              codespell.enable = true;
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

        neoscroll = {
          enable = true;
          settings = {
            mappings = [
              "<C-u>"
              "<C-d>"
              "<C-b>"
              "<C-f>"
              "<C-y>"
              "<C-e>"
            ];
          };
        };

        presence = {
          enable = true;
        };

        # Language server
        lsp = {
          enable = true;
          servers = {
            ts_ls = {
              enable = true;
              extraOptions = {
                init_options = {
                  preferences = {
                    includeCompletionsForModuleExports = true;
                    includeCompletionsWithInsertText = true;
                    includeCompletionsWithSnippetText = true;
                  };
                };
              };
              settings = {
                implicitProjectConfiguration = {
                  checkJs = true;
                  target = "ES2022";
                };
                javascript = {
                  suggest = {
                    completeFunctionCalls = true;
                    includeCompletionsWithSnippetText = true;
                    includeCompletionsForModuleExports = true;
                    includeCompletionsWithInsertText = true;
                  };
                  format = {
                    enable = true;
                  };
                };
                typescript = {
                  suggest = {
                    completeFunctionCalls = true;
                    includeCompletionsWithSnippetText = true;
                    includeCompletionsForModuleExports = true;
                    includeCompletionsWithInsertText = true;
                  };
                  format = {
                    enable = true;
                  };
                };
              };
            };
            cssls.enable = true; # CSS
            tailwindcss.enable = true; # TailwindCSS
            html.enable = true; # HTML
            pyright.enable = true; # Python
            marksman.enable = true; # Markdown
            nil_ls.enable = true; # Nix
            dockerls.enable = true; # Docker
            bashls.enable = true; # Bash
            clangd.enable = true; # C/C++
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
                diagnostics.enabled = true;
                inlayHints.enable = true;
                checkOnSave = true;
                command = "clippy";
              };
            };
          };
        };

        telescope = {
          enable = true;
        };

        lsp-lines = {
          enable = true;
        };

        lualine = {
          enable = true;
        };

        startify = {
          enable = true;
          settings = {
            change_to_dir = false;
          };
        };

        fugitive = {
          enable = true;
        };

        dap = {
          enable = true;
          adapters = {
            servers = {
              pwa-node = {
                host = "127.0.0.1";
                port = 8123;
                executable = {
                  command = "${pkgs.nodejs}/bin/node";
                  args = [
                    "${pkgs.vscode-js-debug}/lib/node_modules/js-debug/dist/src/dapDebugServer.js"
                    "8123"
                    "127.0.0.1"
                  ];
                };
              };
            };
          };
          configurations = {
            javascript = [
              {
                name = "Attach to Node.js";
                type = "pwa-node";
                request = "attach";
                port = 9229;
                address = "127.0.0.1";
                localRoot = "\${workspaceFolder}";
                remoteRoot = "\${workspaceFolder}";
                sourceMaps = true;
                restart = true;
              }
              {
                name = "Launch file";
                type = "pwa-node";
                request = "launch";
                program = "\${file}";
                cwd = "\${workspaceFolder}";
              }
            ];
            typescript = [
              {
                name = "Attach to Node.js";
                type = "pwa-node";
                request = "attach";
                port = 9229;
                address = "127.0.0.1";
                localRoot = "\${workspaceFolder}";
                remoteRoot = "\${workspaceFolder}";
                sourceMaps = true;
                restart = true;
              }
              {
                name = "Launch file";
                type = "pwa-node";
                request = "launch";
                program = "\${file}";
                cwd = "\${workspaceFolder}";
              }
            ];
          };
        };

        dap-ui = {
          enable = true;
        };

        dap-virtual-text = {
          enable = true;
        };

        opencode = {
          enable = true;
        };
      };
    };
  };
}
