return {
  {
    "aikhe/wrapped.nvim",
    dependencies = { "nvzone/volt" },
    cmd = { "WrappedNvim" },
    opts = {},
  },
  {
    "smjonas/inc-rename.nvim",
    opts = {}
  },
  { "nvzone/volt", lazy = true },
  { "nvzone/menu", lazy = true },
  {
    "nvzone/minty",
    cmd = { "Shades", "Huefy" },
    config = function()
      require('minty').setup({
        huefy = {
          border = true
        },
        shades = {
          border = true
        }
      })
    end
  },
  { 'nvim-lua/plenary.nvim', lazy = true },
  { 'MunifTanjim/nui.nvim',  lazy = true },
  { 'tpope/vim-fugitive',    cmd = 'Git' },
  {
    'nvim-mini/mini.nvim',
    version = '*',
    lazy = false,
    config = function()
      require('mini.icons').mock_nvim_web_devicons()
      require('mini.bufremove').setup()
      -- require('mini.indentscope').setup()
      require('mini.pairs').setup()
      require('mini.diff').setup {
        -- View settings (equivalent to signs)
        view = {
          style = 'sign', -- 'sign' | 'number' | 'none'
          signs = {
            add = '┃',
            change = '┃',
            delete = '_',
          },
          priority = 6, -- sign_priority
        },

        -- Source settings
        source = nil, -- Default auto-detect git

        -- Delay for update (equivalent to update_debounce)
        delay = {
          text_change = 100, -- update_debounce
        },

        -- Mappings
        mappings = {
          -- Apply hunks
          apply = 'gh',
          reset = 'gH',

          -- Hunk text object
          textobject = 'gh',

          -- Navigate hunks
          goto_first = '[H',
          goto_prev = '[h',
          goto_next = ']h',
          goto_last = ']H',
        },

        -- Options
        options = {
          algorithm = 'histogram', -- 'myers' | 'minimal' | 'patience' | 'histogram'
          indent_heuristic = true,
          linematch = 60,          -- Performance optimization
          wrap_goto = false,
        },
      }
    end
  },
  {
    'windwp/nvim-ts-autotag',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('nvim-ts-autotag').setup({
        opts = {
          enable_close = true,          -- Auto close tags
          enable_rename = true,         -- Auto rename pairs of tags
          enable_close_on_slash = false -- Auto close on trailing </
        },
        -- Override default file types
        per_filetype = {
          ["html"] = {
            enable_close = true
          }
        }
      })
    end
  },
  -- DAP
  {
    'mfussenegger/nvim-dap',
    cmd = { 'DapContinue', 'DapToggleBreakpoint' },
    keys = {
      { '<leader>db', '<cmd>DapToggleBreakpoint<cr>', desc = 'Toggle breakpoint' },
      { '<leader>dc', '<cmd>DapContinue<cr>',         desc = 'Continue' },
    },
    config = function()
      -- DAP config
    end
  },

  -- Discord Presence
  {
    'vyfor/cord.nvim',
    event = 'VeryLazy',
    config = function()
      require('cord').setup {
        editor = {
          client = 'neovim',
          tooltip = 'ngoding dulu le',
        },
        display = {
          theme = 'catppuccin',
          flavor = 'dark',
        },
        buttons = {
          {
            label = 'View My Github',
            url = 'https://github.com/wanto-production',
          },
          {
            label = 'View My Portofolio',
            url = 'https://portofolio-wanto.vercel.app',
          },
        },
      }
    end
  },
}
