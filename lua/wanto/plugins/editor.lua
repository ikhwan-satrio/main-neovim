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
    "Owen-Dechow/videre.nvim",
    cmd = "Videre",
    dependencies = {
      "Owen-Dechow/graph_view_yaml_parser", -- Optional: add YAML support
      "Owen-Dechow/graph_view_toml_parser", -- Optional: add TOML support
      "a-usr/xml2lua.nvim",                 -- Optional | Experimental: add XML support
    },
    opts = {
      box_style = "sharp",
    }
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
          provider = "telescope", -- "snacks | telescope | fzf-lua | ui-select"
        },
      },
    },
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
          tabs = {
            { source = 'filesystem', display_name = ' 󰉋 Files ', },
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

  -- {
  --   "antosha417/nvim-lsp-file-operations",
  --   dependencies = { "nvim-lua/plenary.nvim" },
  --   config = function()
  --     require("lsp-file-operations").setup({
  --       operations = {
  --         willRenameFiles = true,
  --         didRenameFiles = true,
  --       },
  --     })
  --   end,
  -- },

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
