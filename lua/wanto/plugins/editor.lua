return {
  {
    'barelief/buftyper.nvim',
    config = function()
      require('buftyper').setup({
        show_wpm = true,
        show_mode_indicator = false,
      })
    end
  },

  {
    '2kabhishek/nerdy.nvim',
    dependencies = {
    },
    cmd = 'Nerdy',
    opts = {
      max_recents = 30,          -- Configure recent icons limit
      copy_to_clipboard = false, -- Copy glyph to clipboard instead of inserting
      copy_register = '+',       -- Register to use for copying (if `copy_to_clipboard` is true)
    },
    keys = {
      { '<leader>sin', '<cmd>Nerdy list<CR>',    desc = "Browse nerd icons" },
      { '<leader>siN', '<cmd>Nerdy recents<CR>', desc = "Browse recent nerd icons" },
    },
  },

  {
    "ariedov/android-nvim",
    config = function()
      require('android-nvim').setup()
    end
  },

  {
    "AlexandrosAlexiou/kotlin.nvim",
    ft = { "kotlin" },
    dependencies = {
      "mason-org/mason-lspconfig.nvim",
    },
    config = function()
      require("kotlin").setup {
        root_markers = {
          "gradlew",
          ".git",
          "mvnw",
          "settings.gradle",
        },

        jre_path = nil,

        jdk_for_symbol_resolution = nil,

        jvm_args = {
          "-Xmx4g",
        },

        inlay_hints = {
          enabled = true,
          parameters = true,
          parameters_compiled = true,
          parameters_excluded = false,
          types_property = true,
          types_variable = true,
          function_return = true,
          function_parameter = true,
          lambda_return = true,
          lambda_receivers_parameters = true,
          value_ranges = true,
          kotlin_time = true,
        },
        folding = { enabled = true },
      }
    end,
  },

  {
    "Owen-Dechow/videre.nvim",
    cmd = "Videre",
    dependencies = {
      "Owen-Dechow/graph_view_yaml_parser",
      "Owen-Dechow/graph_view_toml_parser",
      "a-usr/xml2lua.nvim",
    },
    opts = {
      box_style = "sharp",
    }
  },

  {
    "adalessa/laravel.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-neotest/nvim-nio",
    },
    ft = { "php", "blade" },
    event = {
      "BufEnter composer.json",
    },
    opts = {
      features = {
        pickers = {
          provider = "telescope",
        },
      },
    },
  },

  {
    "swaits/zellij-nav.nvim",
    lazy = true,
    event = "VeryLazy",
    keys = {
      { "<c-h>", "<cmd>ZellijNavigateLeftTab<cr>",  { silent = true, desc = "navigate left or tab" } },
      { "<c-j>", "<cmd>ZellijNavigateDown<cr>",     { silent = true, desc = "navigate down" } },
      { "<c-k>", "<cmd>ZellijNavigateUp<cr>",       { silent = true, desc = "navigate up" } },
      { "<c-l>", "<cmd>ZellijNavigateRightTab<cr>", { silent = true, desc = "navigate right or tab" } },
    },
    opts = {},
  },

  {
    "3rd/image.nvim",
    config = function()
      require("image").setup {
        render = {
          min_padding = 5,
          show_label = true,
          use_dither = true,
        },
      }
    end,
  },

  -- ============================================================================
  -- FILE EXPLORER
  -- ============================================================================
  {
    'nvim-neo-tree/neo-tree.nvim',
    config = function()
      require('neo-tree').setup {
        use_popups_for_input = false,
        close_if_last_window = false,
        enable_git_status = true,
        enable_diagnostics = true,
        sources = {
          'filesystem',
          'buffers',
          'git_status',
        },
        clipboard = { sync = "universal" },
        source_selector = {
          winbar = true,
          statusline = false,
          truncation_character = " ",
          tabs = {
            { source = 'filesystem', display_name = ' 󰉋 Files ' },
            { source = 'buffers', display_name = ' 󰈚 Buffers ' },
            { source = 'git_status', display_name = ' 󰊢 Git ' },
          },
        },
        window = {
          position = 'right',
          width = 30,
          mappings = {
            ['<tab>'] = 'next_source',
            ['<s-tab>'] = 'prev_source',
          },
        },
        default_component_configs = {
          indent = {
            with_markers = true,
            indent_marker = '│',
            last_indent_marker = '└',
            indent_size = 2,
          },
        },
        filesystem = {
          window = {
            mappings = {
              ["d"] = "trash",  -- ganti delete jadi trash bawaan
              ["D"] = "delete", -- opsional: tetap simpan delete permanen di key lain, kalau perlu
            },
          },
          follow_current_file = {
            enabled = true,
          },
          use_libuv_file_watcher = true,
          filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = false,
          },
        },
      }
    end,
  },

  -- ============================================================================
  -- TREESITTER
  -- ============================================================================
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false, -- plugin ini nggak support lazy-loading
    build = ':TSUpdate',
    dependencies = {
      {
        "romus204/tree-sitter-manager.nvim",
        config = function()
          require("tree-sitter-manager").setup({
            auto_install = true,
            ensure_installed = {
              'bash', 'vue', 'angular', 'scss', 'typescript', 'javascript',
              'astro', 'svelte', 'css', 'html', 'c', 'c_sharp', 'diff',
              'lua', 'luadoc', 'markdown', 'markdown_inline', 'query',
              'vim', 'vimdoc', 'rust', 'ron', 'regex', 'php', 'latex',
              'typst', 'nix', 'yaml', 'tsx',
            },
          })
        end,
      }
    },
    config = function()
      local ft_list = {
        'sh', 'vue', 'scss', 'typescript', 'javascript',
        'astro', 'svelte', 'css', 'html', 'c', 'cs', 'diff',
        'lua', 'markdown', 'query', 'vim', 'help', 'rust', 'ron',
        'php', 'tex', 'plaintex', 'norg', 'typst', 'nix', 'yaml',
        'typescriptreact', 'zig',
      }

      vim.api.nvim_create_autocmd('FileType', {
        pattern = ft_list,
        callback = function(args)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(args.buf))
          if ok and stats and stats.size > max_filesize then
            return
          end
          vim.treesitter.start(args.buf)
        end,
      })
    end,
  },

  -- ============================================================================
  -- TERMINAL
  -- ============================================================================
  {
    "kremovtort/tabterm.nvim",
    config = function() end
  },

  -- ============================================================================
  -- Trouble
  -- ============================================================================
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
  },

  -- ============================================================================
  -- HLchunk
  -- ============================================================================
  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("hlchunk").setup({
        chunk = {
          enable = true,
          chars = {
            horizontal_line = "─",
            vertical_line = "│",
            left_top = "╭",
            left_bottom = "╰",
            right_arrow = ">",
          },
          style = "#806d9c",
        },
      })
    end
  },

  -- ============================================================================
  -- MARKDOWN & LATEX
  -- ============================================================================
  {
    'OXY2DEV/markview.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('markview').setup {
        modes = { 'n', 'i', 'c' }, -- Render di normal/insert/command
        signs = true,
        headings = true,
        conceal = true,
      }
    end
  },

  {
    'lervag/vimtex',
    ft = 'tex',
    config = function()
      vim.g.vimtex_view_method = 'zathura'
    end
  },
}
