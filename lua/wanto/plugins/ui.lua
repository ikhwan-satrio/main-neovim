return {
  -- ============================================================================
  -- TELESCOPE & EXTENSIONS
  -- ============================================================================
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    cmd = 'Telescope',
    config = function()
      local telescope = require('telescope')
      local colors = require("catppuccin.palettes").get_palette()

      local TelescopeColor = {
        TelescopeMatching = { fg = colors.flamingo },
        TelescopeSelection = { fg = colors.text, bg = colors.surface0, bold = true },

        TelescopePromptPrefix = { bg = colors.surface0 },
        TelescopePromptNormal = { bg = colors.surface0 },
        TelescopeResultsNormal = { bg = colors.mantle },
        TelescopePreviewNormal = { bg = colors.mantle },
        TelescopePromptBorder = { bg = colors.surface0, fg = colors.lavender },
        TelescopeResultsBorder = { bg = colors.mantle, fg = colors.lavender },
        TelescopePreviewBorder = { bg = colors.mantle, fg = colors.lavender },
        TelescopePromptTitle = { bg = colors.pink, fg = colors.mantle },
        TelescopeResultsTitle = { bg = colors.lavender, fg = colors.mantle },
        TelescopePreviewTitle = { bg = colors.green, fg = colors.mantle },
      }

      for hl, col in pairs(TelescopeColor) do
        vim.api.nvim_set_hl(0, hl, col)
      end

      telescope.setup {
        defaults = {
          -- your defaults
        },
        extensions = {
          -- extensions will be configured by their own specs
        }
      }
    end
  },

  -- UI Select
  {
    'nvim-telescope/telescope-ui-select.nvim',
    config = function()
      require('telescope').setup {
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown()
          }
        }
      }
      pcall(require('telescope').load_extension, 'ui-select')
    end
  },

  -- Project Management
  {
    'nvim-telescope/telescope-project.nvim',
    config = function()
      local project_actions = require("telescope._extensions.project.actions")
      require('telescope').setup {
        extensions = {
          project = {
            base_dirs = {
              '~/projects',
            },
            ignore_missing_dirs = true, -- default: false
            hidden_files = true,        -- default: false
            theme = "dropdown",
            order_by = "asc",
            search_by = "title",
            sync_with_nvim_tree = true, -- default false
            on_project_selected = function(prompt_bufnr)
              -- Do anything you want in here. For example:
              project_actions.change_working_directory(prompt_bufnr, false)
              require("harpoon.ui").nav_file(1)
            end,
            mappings = {
              n = {
                ['d'] = project_actions.delete_project,
                ['r'] = project_actions.rename_project,
                ['c'] = project_actions.add_project,
                ['C'] = project_actions.add_project_cwd,
                ['f'] = project_actions.find_project_files,
                ['b'] = project_actions.browse_project_files,
                ['s'] = project_actions.search_in_project_files,
                ['R'] = project_actions.recent_project_files,
                ['w'] = project_actions.change_working_directory,
                ['o'] = project_actions.next_cd_scope,
              },
              i = {
                ['<c-d>'] = project_actions.delete_project,
                ['<c-v>'] = project_actions.rename_project,
                ['<c-a>'] = project_actions.add_project,
                ['<c-A>'] = project_actions.add_project_cwd,
                ['<c-f>'] = project_actions.find_project_files,
                ['<c-b>'] = project_actions.browse_project_files,
                ['<c-s>'] = project_actions.search_in_project_files,
                ['<c-r>'] = project_actions.recent_project_files,
                ['<c-l>'] = project_actions.change_working_directory,
                ['<c-o>'] = project_actions.next_cd_scope,
              }
            }
          }
        }
      }
      pcall(require('telescope').load_extension, 'project')
    end
  },

  -- Undo Tree
  {
    'debugloop/telescope-undo.nvim',
    config = function()
      require('telescope').setup {
        extensions = {
          undo = {
            side_by_side = true,
          }
        }
      }
      pcall(require('telescope').load_extension, 'undo')
    end
  },

  -- FZF Native
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    config = function()
      pcall(require('telescope').load_extension, 'fzf')
    end
  },

  -- Git File History
  {
    'isak102/telescope-git-file-history.nvim',
    dependencies = { 'tpope/vim-fugitive' },
    config = function()
      pcall(require('telescope').load_extension, 'git_file_history')
    end
  },

  -- ============================================================================
  -- STATUSLINE & UI
  -- ============================================================================
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      local function lsp_names()
        local clients = vim.lsp.get_clients { bufnr = 0 }
        if not clients or vim.tbl_isempty(clients) then
          return 'None'
        end
        local names = {}
        for _, client in pairs(clients) do
          table.insert(names, client.name)
        end
        return table.concat(names, ', ')
      end

      require('lualine').setup {
        options = {
          theme = 'auto', -- Ganti catppuccin kalau belum ada
          globalstatus = true,
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = { statusline = { 'NvimTree', 'alpha' } },
          refresh = { statusline = 1000 },
        },
        sections = {
          lualine_a = {
            {
              'mode',
              fmt = function(str)
                return str:sub(1, 1)
              end,
            },
          },
          lualine_b = {
            'branch',
            {
              source = function()
                -- Try mini.diff first
                local has_mini_diff = pcall(require, 'mini.diff')
                if has_mini_diff then
                  local summary = vim.b.minidiff_summary
                  if summary then
                    return {
                      added = summary.add,
                      modified = summary.change,
                      removed = summary.delete,
                    }
                  end
                end

                -- Fallback to gitsigns
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end

                return nil
              end,
            },
          },
          lualine_c = {
            {
              'filename',
              file_status = true,
              path = 0,
              symbols = { modified = ' [+]', readonly = ' RO' },
            },
            {
              'diagnostics',
              sources = { 'nvim_diagnostic' },
              sections = { 'error', 'warn', 'info', 'hint' },
            },
            'branch',
            'diff',
          },
          lualine_x = {
            lsp_names,
            'encoding',
            { 'fileformat', symbols = { unix = 'LF', dos = 'CRLF', mac = 'CR' } },
            'filetype',
          },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },
      }
    end
  },

  {
    'akinsho/bufferline.nvim',
    config = function()
      require('bufferline').setup {
        -- Catppuccin integration
        highlights = require('catppuccin.special.bufferline').get_theme(),

        options = {
          -- OIL PERFORMANCE FIX (no diagnostics lag)
          diagnostics = 'nvim_lsp',

          -- Icons via mini.icons
          get_element_icon = function(element)
            if element.filetype ~= '' then
              local icon, hl = require('mini.icons').get('filetype', element.filetype)
              return icon, hl
            elseif element.path ~= '' then
              local icon, hl = require('mini.icons').get('file', element.path)
              return icon, hl
            end
            return '', ''
          end,

          mode = 'buffers',
          numbers = 'ordinal',
          show_buffer_icons = true,
          show_close_icon = false,
          show_buffer_close_icons = false,
          always_show_bufferline = true,

          -- OIL OFFSET (highlight + text)
          offsets = {
            {
              filetype = 'oil',
              text = '📁 FILES',
              highlight = 'Directory',
              text_align = 'center',
              separator = true,
            },
          },
        },
      }
    end
  },

  -- ============================================================================
  -- NOTIFICATIONS & UI ENHANCEMENTS
  -- ============================================================================
  {
    'rcarriga/nvim-notify',
    event = 'VeryLazy',
    config = function()
      local notify = require('notify')
      notify.setup({
        stages = 'slide',
        timeout = 3000,
        background_colour = '#000000',
        render = 'compact',
        position = 'top_left', -- Pastikan ada spasi, bukan "top_left"
      })
      vim.notify = notify

      -- Load telescope extension
      pcall(require('telescope').load_extension, 'notify')
    end
  },

  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
    config = function()
      require('noice').setup {
        lsp = {
          progress = { enabled = true },
          override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
            ['cmp.entry.get_documentation'] = false,
          },
          signature = { enabled = false }
        },
        signature = { auto_open = false }, -- ❌ Matikan auto popup
        notify = { enabled = false },
        cmdline = {
          enabled = true,
          view = 'cmdline_popup',
        },
        views = {
          cmdline_popup = {
            border = { style = 'rounded' },
            position = { row = '10%', col = '50%' },
            size = { width = 60, height = 'auto' },
          },
        },
        presets = {
          inc_rename =true,
          bottom_search = true,
          command_palette = true,
          long_message_to_split = true,
        },
      }
    end
  },

  -- ============================================================================
  -- COLORSCHEME
  -- ============================================================================
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    event = "VimEnter",
    config = function()
      require('catppuccin').setup {
        flavour = 'mocha',
        transparent_background = false,
        dim_inactive = {
          enabled = true,
          shade = 'dark',
          percentage = 0.10,
        },
        styles = {
          comments = { 'italic' },
          keywords = { 'italic' },
        },
        color_overrides = {
          mocha = {
            base = '#11151c',   -- blue-black base
            mantle = '#0e1117', -- dark blue-black
            crust = '#0a0d12',  -- darkest
            text = '#c9d1d9',
            subtext1 = '#b1bac4',
            subtext0 = '#8b949e',
            surface0 = '#1a1f26',
            surface1 = '#252a32',
            surface2 = '#30353d',
          },
        },
        integrations = {
          -- snacks (kalau ada), fallback aman
          neotree = true,
          noice = true,
          notify = true,
          treesitter = true,
          native_lsp = true,
          lsp_trouble = true,
          mason = true,
          telescope = { enabled = true },
          which_key = true,
          dap = { enabled = true, enable_ui = true },
        },
      }
      vim.cmd.colorscheme 'catppuccin-mocha'
    end
  },

  -- ============================================================================
  -- WHICH-KEY
  -- ============================================================================
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      preset = 'modern',
      spec = {
        { '<leader>s', group = 'search' },
        { '<leader>g', group = 'git' },
        { '<leader>l', group = 'lsp' },
      }
    }
  },
}
