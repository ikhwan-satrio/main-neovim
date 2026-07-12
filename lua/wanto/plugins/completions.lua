return {
  -- ============================================================================
  -- LSP
  -- ============================================================================
  {
    "folke/lazydev.nvim",
    ft = "lua",
    dependencies = {
      { 'justinsgithub/wezterm-types', lazy = true },
    },
    opts = {
      library = {
        { path = 'wezterm-types',                              mods = { 'wezterm' } },
        { path = '${3rd}/luv/library',                         words = { 'vim%.uv' } },
        { path = vim.fn.expand(os.getenv("HYPR_STUBS") or ""), words = { "hl" } },
      },
    },
  },

  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' }, -- ⚡ KUNCI: Event yang tepat
  },

  {
    'williamboman/mason.nvim',
    opts = {
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    },
  },

  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    event = 'VimEnter',
    opts = {
      ensure_installed = {
        'vtsls',
        'tailwindcss-language-server',
        'svelte-language-server',
        'astro-language-server',
        'vue-language-server',
        'taplo'
      },
      auto_install = true,
      run_on_start = true,
      integrations = {
        ['mason-lspconfig'] = false,
        ['mason-null-ls'] = false,
        ['mason-nvim-dap'] = false,
      },
    },
  },

  -- ============================================================================
  -- COMPLETION
  -- ============================================================================
  {
    'Saghen/blink.cmp',
    event = 'InsertEnter', -- start only on insert to speed up startup
    version = '1.*',
    dependencies = {
      { 'b0o/schemastore.nvim' },
      {
        'saghen/blink.compat',
        version = '2.*',
        lazy = true,
        opts = {},
      },
    },
    opts = function()
      local mini_icons = require 'mini.icons'
      local capabilities = require('blink-cmp').get_lsp_capabilities()

      vim.lsp.config('*', {
        capabilities = capabilities,
      })

      return {
        keymap = {
          ['<CR>'] = { 'accept', 'fallback' },
        },
        appearance = { nerd_font_variant = 'mono' },
        completion = {
          documentation = {
            auto_show = true,
            window = {
              border = 'single',
            },
          },
          menu = {
            border = 'single',
            draw = {
              components = {
                kind_icon = {
                  text = function(ctx)
                    local icon = ''

                    if ctx.source_name == 'Path' then
                      icon = mini_icons.get('file', ctx.label)
                    else
                      icon = mini_icons.get('lsp', ctx.kind)
                    end

                    return (icon or '') .. ctx.icon_gap
                  end,
                  highlight = function(ctx)
                    if ctx.source_name == 'Path' then
                      local _, hl = mini_icons.get('file', ctx.label)
                      return hl
                    end

                    return ctx.kind_hl
                  end,
                },
              },
            },
          },
        },
        sources = {
          default = { 'lsp', 'path', 'lazydev', 'laravel' },
          providers = {
            lazydev = {
              module = 'lazydev.integrations.blink',
              score_offset = 100,
            },
            laravel = {
              name = "laravel",
              module = "blink.compat.source",
              score_offset = 95, -- show at a higher priority than lsp
            },
          },
        },
        fuzzy = {
          implementation = 'lua',
        },
        signature = { enabled = true },
      }
    end,
  },

  {
    'L3MON4D3/LuaSnip',
    event = 'InsertEnter',
    build = 'make install_jsregexp',
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
    end,
  },

  -- ============================================================================
  -- FORMATTING
  -- ============================================================================
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    config = function()
      require('conform').setup {
        formatters_by_ft = {
          vue = { "prettier" },
        },
        -- format_on_save = {
        --   -- These options will be passed to conform.format()
        --   timeout_ms = 500,
        --   lsp_format = 'fallback',
        -- },
      }
    end,
  },
}
