return {
  {
    "ellisonleao/carbon-now.nvim",
    lazy = true,
    cmd = "CarbonNow",
    ---@param opts cn.ConfigSchema
    opts = { [[ your custom config here ]] }
  },

  {
    'barelief/buftyper.nvim',
    event = 'VimEnter',
    config = function()
      require('buftyper').setup({
        show_wpm = true,
        show_mode_indicator = false,
      })
    end
  },

  {
    'Bekaboo/dropbar.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    -- optional, but required for fuzzy finder support
    dependencies = {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make'
    },
    config = function()
      local dropbar_api = require('dropbar.api')
      vim.keymap.set('n', '<Leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
      vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
      vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })
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
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
      completion = {
        crates = {
          enabled = true,
        },
      },
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    },
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
    "MuazTPM-YT/leetvim.nvim",
    name = "leetvim",
    cmd = { "LeetvimTemplate", "LeetvimAuth" },
    keys = {
      { "<leader>lt", ":LeetvimTemplate ", desc = "LeetVim Template" },
      { "<leader>la", ":LeetvimAuth<cr>",  desc = "LeetCode Auth" },
    },
    config = function()
      require("leetvim").setup({
        base_dir = vim.fn.expand("~/leetcode"),
        filename_pattern = "{number:03d}-{slug}.{ext}",
        include_test_stub = true,
        default_language = "python",
        create_subdirs = false,
      })
    end,
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
    event = { 'BufReadPre', 'BufNewFile' },
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
    cmd = { "TabTermToggle", "TabTermNew", "TabTermNewCommand" },
    keys = {
      { "<leader>tt", function() require("tabterm").toggle() end,      desc = "Toggle tabterm" },
      { "<leader>tn", function() require("tabterm").new_shell() end,   desc = "New tabterm shell" },
      { "<leader>tc", function() require("tabterm").new_command() end, desc = "New tabterm command" },
    },
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
    ft = { 'markdown', 'Avante' },
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
