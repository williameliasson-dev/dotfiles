{pkgs, ...}: {
  programs.nixvim = {
    config = {
      enable = true;
      defaultEditor = true;
      colorschemes.gruvbox.enable = true;
      globals.mapleader = " ";
      opts = {
        number = true;
        relativenumber = true;
        spell = true;
        spelllang = [
          "en_gb"
          "sv"
        ];
        clipboard = "unnamedplus"; # Enable system clipboard integration
      };

      globals.rustfmt_autosave = 0; # Disable rust.vim's broken rustfmt integration

      keymaps = [
        # Toggle between relative and absolute line numbers
        {
          key = "<leader>ln";
          action.__raw = ''
            function()
              vim.wo.relativenumber = not vim.wo.relativenumber
            end
          '';
          options.desc = "Toggle relative/absolute line numbers";
        }

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
          mode = ["t"];
          key = "<C-Space>";
          action = "<C-\\><C-n>";
          options.desc = "Exit terminal mode";
        }
        {
          mode = ["t"];
          key = "<C-@>";
          action = "<C-\\><C-n>";
          options.desc = "Exit terminal mode";
        }

        # Claude Code
        {
          key = "<leader>cc";
          action = "<cmd>ClaudeCode<CR>";
          options.desc = "Toggle Claude Code";
        }
        {
          key = "<leader>cf";
          action = "<cmd>ClaudeCodeFocus<CR>";
          options.desc = "Focus Claude Code";
        }
        {
          mode = "v";
          key = "<leader>cs";
          action = "<cmd>ClaudeCodeSend<CR>";
          options.desc = "Send selection to Claude";
        }
        {
          key = "<leader>ca";
          action = "<cmd>ClaudeCodeDiffAccept<CR>";
          options.desc = "Accept Claude diff";
        }
        {
          key = "<leader>cd";
          action = "<cmd>ClaudeCodeDiffDeny<CR>";
          options.desc = "Deny Claude diff";
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
          action = "<cmd>silent Git<CR>";
          key = "<leader>gs";
          options = {
            desc = "Git status";
          };
        }
        {
          action = "<cmd>silent Gvdiffsplit @{upstream}<CR>";
          key = "<leader>gd";
          options = {
            desc = "Git vertical diff split against remote";
          };
        }
        {
          action = "<cmd>silent Git commit<CR>";
          key = "<leader>gc";
          options = {
            desc = "Git commit";
          };
        }
        {
          action = "<cmd>silent Git add %<CR>";
          key = "<leader>ga";
          options = {
            desc = "Git add current file";
          };
        }
        {
          action = "<cmd>silent Git add .<CR>";
          key = "<leader>gA";
          options = {
            desc = "Git add all files";
          };
        }
        {
          key = "<leader>gP";
          action.__raw = ''
            function()
              local buf = vim.api.nvim_create_buf(false, true)
              local lines = {
                "",
                "   Git Push Confirmation  ",
                "",
                "  Push to remote? (y/n)  ",
                "",
              }
              vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

              local width = 26
              local height = #lines
              local win = vim.api.nvim_open_win(buf, true, {
                relative = "editor",
                width = width,
                height = height,
                row = math.floor((vim.o.lines - height) / 2),
                col = math.floor((vim.o.columns - width) / 2),
                style = "minimal",
                border = "rounded",
                title = " Git Push ",
                title_pos = "center",
              })

              vim.api.nvim_set_option_value("winhl", "Normal:DiagnosticFloatingInfo,FloatBorder:DiagnosticFloatingInfo", { win = win })

              local function close()
                vim.api.nvim_win_close(win, true)
                vim.api.nvim_buf_delete(buf, { force = true })
              end

                vim.keymap.set("n", "y", function()
                close()
                vim.cmd("silent Git push")
              end, { buffer = buf, nowait = true })

              vim.keymap.set("n", "n", function()
                close()
                vim.notify("Git push cancelled", vim.log.levels.INFO)
              end, { buffer = buf, nowait = true })

              vim.keymap.set("n", "<Esc>", function()
                close()
                vim.notify("Git push cancelled", vim.log.levels.INFO)
              end, { buffer = buf, nowait = true })

              vim.keymap.set("n", "q", function()
                close()
                vim.notify("Git push cancelled", vim.log.levels.INFO)
              end, { buffer = buf, nowait = true })
            end
          '';
          options = {
            desc = "Git push (with confirmation)";
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

        # DIFFVIEW
        {
          action = "<cmd>DiffviewOpen<CR>";
          key = "<leader>gv";
          options = {
            desc = "Diffview open";
          };
        }
        {
          action = "<cmd>DiffviewFileHistory %<CR>";
          key = "<leader>gh";
          options = {
            desc = "Diffview file history";
          };
        }
        {
          action = "<cmd>DiffviewFileHistory<CR>";
          key = "<leader>gH";
          options = {
            desc = "Diffview repo history";
          };
        }
        {
          action = "<cmd>DiffviewClose<CR>";
          key = "<leader>gx";
          options = {
            desc = "Diffview close";
          };
        }

        # DADBOD
        {
          action = "<cmd>DBUIToggle<CR>";
          key = "<leader>DD";
          options = {
            desc = "Toggle Dadbod UI";
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
          action = "<cmd>lua vim.lsp.buf.rename()<CR>";
          key = "<leader>rn";
          options = {
            desc = "Rename symbol";
          };
        }
        {
          action = "<cmd>lua require('spectre').toggle()<CR>";
          key = "<leader>sr";
          options = {
            desc = "Search and replace across project";
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
      ];

      extraPlugins = with pkgs.vimPlugins; [
        snacks-nvim
        claudecode-nvim
        kitty-scrollback-nvim
        nvim-spectre
      ];

      extraConfigLua = ''
        -- Tell kitty to leave Ctrl+Space alone while editing (kitty nav mode entry)
        local kitty_var_on = "\27]1337;SetUserVar=in_editor=MQ==\7"
        local kitty_var_off = "\27]1337;SetUserVar=in_editor\7"
        local function kitty_set_in_editor_var()
          if vim.api.nvim_ui_send then
            vim.api.nvim_ui_send(kitty_var_on)
          else
            io.stdout:write(kitty_var_on)
            io.stdout:flush()
          end
        end
        local function kitty_unset_in_editor_var()
          if vim.api.nvim_ui_send then
            vim.api.nvim_ui_send(kitty_var_off)
          else
            io.stdout:write(kitty_var_off)
            io.stdout:flush()
          end
        end
        vim.api.nvim_create_autocmd({ "VimEnter", "VimResume" }, {
          group = vim.api.nvim_create_augroup("KittySetInEditor", { clear = true }),
          callback = kitty_set_in_editor_var,
        })
        vim.api.nvim_create_autocmd({ "VimLeave", "VimSuspend" }, {
          group = vim.api.nvim_create_augroup("KittyUnsetInEditor", { clear = true }),
          callback = kitty_unset_in_editor_var,
        })

        vim.diagnostic.config({ virtual_text = false, virtual_lines = { current_line = true } })

        require('spectre').setup()
        require('kitty-scrollback').setup()

        require('claudecode').setup({
          terminal = {
            split_side = "right",
            split_width_percentage = 0.4,
          },
        })

        -- Register JS debug adapters with dynamic port allocation
        local dap = require('dap')
        local js_debug_path = "${pkgs.vscode-js-debug}/lib/node_modules/js-debug/dist/src/dapDebugServer.js"

        dap.adapters["pwa-node"] = {
          type = "server",
          host = "127.0.0.1",
          port = "${"$"}{port}",
          executable = {
            command = "${pkgs.nodejs}/bin/node",
            args = { js_debug_path, "${"$"}{port}", "127.0.0.1" },
          },
        }

        -- "node" adapter reuses pwa-node (vscode-js-debug handles both)
        dap.adapters.node = dap.adapters["pwa-node"]

        -- Map VS Code launch.json types to filetypes (dap reads .vscode/launch.json automatically)
        local vscode = require('dap.ext.vscode')
        vscode.type_to_filetypes["node"] = { "typescript", "javascript" }
        vscode.type_to_filetypes["debugpy"] = { "python" }

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
              "rust"
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

        blink-cmp = {
          enable = true;
          settings = {
            keymap = {
              preset = "super-tab";
            };
            snippets = {
              expand.__raw = "function(snippet) require('luasnip').lsp_expand(snippet) end";
              active.__raw = "function(filter) return require('luasnip').in_snippet() end";
              jump.__raw = "function(direction) require('luasnip').jump(direction) end";
            };
            sources = {
              # Command-line completion stays on wilder; avoid a second popup on ":"
              cmdline = [];
              default = ["lsp" "path" "snippets" "buffer"];
              per_filetype = {
                sql = ["snippets" "dadbod" "buffer"];
                mysql = ["snippets" "dadbod" "buffer"];
                plsql = ["snippets" "dadbod" "buffer"];
              };
              providers = {
                dadbod = {
                  name = "Dadbod";
                  module = "vim_dadbod_completion.blink";
                };
              };
            };
          };
        };

        hop = {
          enable = true;
        };

        # Yazi file manager plugin
        yazi = {
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
            completion = {
              luasnip.enable = true;
              spell.enable = true;
            };
          };
        };

        # Formatting: explicit formatters for nix/lua/sh. For JS/TS/JSON/CSS,
        # try each formatter in order and use whichever is actually installed
        # in the project's own node_modules (stop_after_first) — no hardcoded
        # "always use X" assumption about what a given repo uses. Everything
        # else (e.g. Rust) falls back to whatever the attached LSP can format.
        conform-nvim = {
          enable = true;
          autoInstall = {
            enable = true;
            # These are resolved per-project from node_modules, not installed
            # globally — a global fallback would defeat the point of
            # detecting what each repo actually uses.
            overrides = {
              oxfmt = null;
              prettier = null;
              biome = null;
            };
          };
          settings = let
            jsFormatters = {
              __unkeyed-1 = "oxfmt";
              __unkeyed-2 = "prettier";
              __unkeyed-3 = "biome";
              stop_after_first = true;
            };
          in {
            formatters_by_ft = {
              nix = ["alejandra"];
              lua = ["stylua"];
              sh = ["shfmt"];
              bash = ["shfmt"];
              javascript = jsFormatters;
              javascriptreact = jsFormatters;
              typescript = jsFormatters;
              typescriptreact = jsFormatters;
              json = jsFormatters;
              jsonc = jsFormatters;
              css = jsFormatters;
            };
            format_on_save = {
              lsp_format = "fallback";
              timeout_ms = 3000;
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

        # Language server
        lsp = {
          enable = true;
          servers = {
            vtsls = {
              enable = true;
              settings = {
                # Limit memory and reduce scope
                vtsls = {
                  experimental = {
                    maxInlayHintLength = 30;
                    completion = {
                      enableServerSideFuzzyMatch = true;
                    };
                  };
                };
                typescript = {
                  enableProjectDiagnostics = false;
                  tsserver = {
                    maxTsServerMemory = 8192;
                    watchOptions = {
                      excludeDirectories = ["**/node_modules" "**/.git" "**/dist" "**/.nx" "**/coverage" "**/test-results"];
                    };
                  };
                  suggest = {
                    completeFunctionCalls = true;
                    autoImports = true; # Keep auto imports
                  };
                  format = {
                    enable = false; # Use oxfmt instead
                  };
                  # Disable file move updates to reduce load
                  updateImportsOnFileMove = {
                    enabled = "never";
                  };
                };
                javascript = {
                  suggest = {
                    completeFunctionCalls = true;
                    autoImports = true; # Keep auto imports
                  };
                  format = {
                    enable = false; # Use oxfmt instead
                  };
                  updateImportsOnFileMove = {
                    enabled = "never";
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
              installCargo = false;
              installRustc = false;
              settings = {
                procMacro = {
                  enable = true;
                };
                diagnostics.enable = true;
                inlayHints.enable = true;
                checkOnSave = true;
                check = {
                  command = "clippy";
                };
              };
            };
          };
        };

        telescope = {
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

        diffview = {
          enable = true;
        };

        vim-dadbod = {
          enable = true;
        };

        vim-dadbod-ui = {
          enable = true;
        };

        vim-dadbod-completion = {
          enable = true;
        };

        dap = {
          enable = true;
          adapters = {
            executables = {
              debugpy = {
                command = "${pkgs.python3Packages.debugpy}/bin/python";
                args = ["-m" "debugpy.adapter"];
              };
            };
          };
          # Configurations loaded from .vscode/launch.json via dap.ext.vscode
        };

        dap-ui = {
          enable = true;
        };

        dap-virtual-text = {
          enable = true;
        };
      };
    };
  };
}
