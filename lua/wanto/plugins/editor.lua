return {
  -- ============================================================================
  -- FILE EXPLORER
  -- ============================================================================
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
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
        source_selector = {
          winbar = true,
          statusline = false,
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
    branch = "master",
    event = { 'BufReadPost', 'BufNewFile' },
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          'regex',
          'bash',
          'vue',
          'angular',
          'scss',
          'typescript',
          'javascript',
          'astro',
          'svelte',
          'css',
          'html',
          'bash',
          'c',
          'c_sharp',
          'diff',
          'lua',
          'luadoc',
          'markdown',
          'markdown_inline',
          'query',
          'vim',
          'vimdoc',
          'rust',
          'ron',
          'regex',
          'php',
          'latex',
          'html',
          'norg',
          'typst',
          'nix',
          'markdown',
          'markdown_inline',
          'latex',
          'yaml',
          'tsx',
          'norg',
        },
        sync_install = false,
        ignore_install = {},
        modules = {},
        auto_install = true,
        highlight = {
          enable = true,
          disable = function(_, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
          additional_vim_regex_highlighting = false,
        },
      }

      vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
        pattern = { '*.component.html', '*.container.html' },
        callback = function()
          vim.treesitter.start(nil, 'angular')
        end,
      })
    end
  },

  -- ============================================================================
  -- TERMINAL
  -- ============================================================================
  {
    'akinsho/toggleterm.nvim',
    cmd = 'ToggleTerm',
    event = 'VeryLazy',
    config = function()
      require('toggleterm').setup {
        open_mapping = [[<leader>tt]],
        direction = 'float', -- floating window
        float_opts = {
          border = 'curved',
          winblend = 0,
        },
        shade_terminals = true,
      }
    end
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
