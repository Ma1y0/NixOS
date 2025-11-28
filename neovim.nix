{ pkgs, ... }:

{
  programs.nixvim = {
    enable = true;

    globals.mapleader = " ";
    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2; # Tab width
      tabstop = 2;
      expandtab = true; # Use spaces instead of tabs
      spell = true;
      spelllang = "en_us";
      signcolumn = "yes"; # Keep space between numbers and the border
      scrolloff = 10; # Scrolls 10 lines in front of the cursor
      undofile = true;
    };

    clipboard.register = "unnamedplus"; # Use the system clipboard

    diagnostics.settings.config = {
      virtual_text = true;
      underline = true;
      signs = true;
      float = {
        border = "rounded";
        max_width = 80;
        max_height = 20;
        focusable = true;
        style = "minimal";
        source = "always";
      };
    };

    plugins = {
      # Helper
      which-key.enable = true;
      # Icons
      web-devicons.enable = true;
      # Insert and delete brackets, parens, quotes in pair automatically
      nvim-autopairs.enable = true;
      # Fuzzy finder
      telescope = {
        enable = true;
        # extensions.fzf-native.enable = true;
        extensions.fzy-native.enable = true; # Testing the author claims it has better algorithm
        keymaps = {
          "<leader>ff" = {
            action = "find_files";
            options = {
              desc = "Fuzzy find files in the cwd";
            };
          };
          "<leader>fg" = {
            action = "live_grep";
            options = {
              desc = "Live Grep";
            };
          };
        };
      };
      # Lualine
      lualine.enable = true;
      # Undotree
      undotree.enable = true;
      # Highlighting
      treesitter.enable = true;
      # LSP notifications
      fidget.enable = true;
      # LSP
      lsp = {
        enable = true;
        servers = {
          clangd.enable = true;
          cmake.enable = true;
          ts_ls.enable = true;
          nil_ls.enable = true; # A nix ls
          rust_analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
          ocamllsp.enable = true;
          ty.enable = true; # Python
          tailwindcss.enable = true;
          fish_lsp.enable = true;
          elixirls.enable = true;
          bashls.enable = true;
        };

        keymaps = {
          diagnostic = {
            "<leader>q" = {
              mode = "n";
              action = "setloclist";
              desc = "Open diagnostic quickfix list";
            };
            "[d" = {
              mode = "n";
              action = "goto_prev";
              desc = "Go to previous diagnostic";
            };
            "]d" = {
              mode = "n";
              action = "goto_next";
              desc = "Go to next diagnostic";
            };
            "<leader>d" = {
              mode = "n";
              action = "open_float";
              desc = "Show line diagnostics";
            };
          };

          lspBuf = {
            "gd" = {
              action = "definition";
              desc = "LSP: [G]oto [D]efinition";
            };
            "gr" = {
              action = "references";
              desc = "LSP: [G]oto [R]eferences";
            };
            "gD" = {
              action = "declaration";
              desc = "LSP: [G]oto [D]eclaration";
            };
            "gT" = {
              action = "type_definition";
              desc = "LSP: [G]oto [T]ype Definition";
            };
            "K" = {
              action = "hover";
              desc = "LSP: Hover Documentation";
            };
            "<leader>rn" = {
              action = "rename";
              desc = "LSP: [R]e[n]ame";
            };
            "<leader>ca" = {
              mode = [
                "n"
                "x"
              ];
              action = "code_action";
              desc = "LSP: Code [A]ction";
            };
          };
        };
      };
      # CMP
      blink-cmp = {
        enable = true;
        settings = {
          completion.documentation.auto_show = true;
          signature.enabled = true;
          completion.documentation.window.border = "rounded";
          completion.menu.border = "rounded";
          signature.window.border = "rounded";
          keymap = {
            preset = "enter";

            "<Tab>" = [
              "select_next"
              "fallback"
            ];
            "<S-Tab>" = [
              "select_prev"
              "fallback"
            ];
          };

          completion = {
            list = {
              selection = {
                preselect = true;
              }; # Automatically select first item
            };
          };
        };
      };
      # Formatter
      conform-nvim = {
        enable = true;

        settings = {
          formatters_by_ft = {
            nix = [ "nixfmt" ];
          };

          format_on_save = {
            lsp_fallback = true;
            timeout_ms = 500;
          };
        };
      };

    };

    extraConfigLua = ''
      -- Aliases, bacuse I can't type
      vim.cmd([[cabbrev W w]])
      vim.cmd([[cabbrev Wqa wqa]])

      -- Lsp hover border (is there a nix wat to do this?)
      vim.o.winborder = 'rounded'

      -- LSP Restart keymap
      vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", { desc = "Restart LSP" })

      -- Visual on yanking (bet there is nixvim way to add autogroups)
      vim.api.nvim_create_autocmd("TextYankPost", {
        desc = "Highlight when yanking (copying) text",
        group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
        callback = function()
          vim.highlight.on_yank()
        end,
      })
    '';
  };
}
