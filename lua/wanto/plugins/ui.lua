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

  -- venv selector
  {
    "linux-cultist/venv-selector.nvim",
    ft = "python",                              -- Load when opening Python files
    keys = { { ",v", "<cmd>VenvSelect<cr>" } }, -- Open picker on keymap
    opts = {
      options = {},                             -- plugin-wide options
      search = {}                               -- custom search definitions
    },
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
      local colors = {
        rosewater = "#f5e0dc",
        flamingo  = "#f2cdcd",
        pink      = "#f5c2e7",
        mauve     = "#cba6f7",
        red       = "#f38ba8",
        maroon    = "#eba0ac",
        peach     = "#fab387",
        yellow    = "#f9e2af",
        green     = "#a6e3a1",
        teal      = "#94e2d5",
        sky       = "#89dceb",
        sapphire  = "#74c7ec",
        blue      = "#89b4fa",
        lavender  = "#b4befe",
        text      = "#cdd6f4",
        subtext1  = "#bac2de",
        overlay1  = "#7f849c",
        surface1  = "#45475a",
        surface0  = "#313244",
        base      = "#1e1e2e",
        mantle    = "#181825",
        crust     = "#11111b",
      }

      -- Mode colors mapping
      local mode_colors = {
        n     = colors.blue,
        i     = colors.green,
        v     = colors.mauve,
        ['']  = colors.mauve,
        V     = colors.mauve,
        c     = colors.peach,
        s     = colors.maroon,
        S     = colors.maroon,
        ['']  = colors.maroon,
        R     = colors.red,
        r     = colors.red,
        ['!'] = colors.red,
        t     = colors.teal,
      }

      local mode_labels = {
        n     = "NORMAL",
        i     = "INSERT",
        v     = "VISUAL",
        ['']  = "VBLOCK",
        V     = "VLINE",
        c     = "COMMAND",
        s     = "SELECT",
        S     = "SLINE",
        ['']  = "SBLOCK",
        R     = "REPLACE",
        r     = "RCONFIRM",
        ['!'] = "SHELL",
        t     = "TERMINAL",
      }

      -- Copilot status component
      local function copilot_status()
        local ok, clients = pcall(vim.lsp.get_clients, { name = "copilot", bufnr = 0 })
        if not ok or #clients == 0 then return "" end

        local copilot_loaded = package.loaded["copilot"]
        if not copilot_loaded then return "" end

        local status_ok, status_data = pcall(function()
          return require("copilot.status").data.status
        end)
        if not status_ok then return "" end

        if status_data == "InProgress" then
          return "%#CopilotProgress# 󰚩 Copilot%*"
        elseif status_data == "Warning" then
          return "%#CopilotWarning#  Copilot%*"
        else
          return "%#CopilotOk# 󰊤 Copilot%*"
        end
      end

      -- LSP names component
      local function lsp_names()
        local clients = vim.lsp.get_clients { bufnr = 0 }
        if not clients or vim.tbl_isempty(clients) then
          return "%#LualineNoLsp# 󰅖 No LSP%*"
        end
        local names = {}
        for _, client in pairs(clients) do
          if client.name ~= "copilot" then
            table.insert(names, client.name)
          end
        end
        if #names == 0 then return "" end
        return "%#LualineLsp# 󰒋 " .. table.concat(names, " · ") .. "%*"
      end

      -- Network Status
      local _net_cache = { status = nil, last_check = 0 }

      local function network_status()
        local now = os.time()
        -- cek ulang setiap 10 detik
        if now - _net_cache.last_check > 10 then
          local result          = os.execute('ping -c 1 -W 1 8.8.8.8 > /dev/null 2>&1')
          _net_cache.status     = (result == 0)
          _net_cache.last_check = now
        end

        if _net_cache.status then
          return "" -- online → tidak tampil
        else
          return "%#NetworkOffline# 󰖪 OFFLINE%*"
        end
      end

      -- Setup custom highlights
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          vim.api.nvim_set_hl(0, "CopilotOk", { fg = colors.base, bg = colors.green, bold = true })
          vim.api.nvim_set_hl(0, "CopilotProgress", { fg = colors.base, bg = colors.yellow, bold = true })
          vim.api.nvim_set_hl(0, "CopilotWarning", { fg = colors.base, bg = colors.red, bold = true })
          vim.api.nvim_set_hl(0, "LualineLsp", { fg = colors.base, bg = colors.blue, bold = true })
          vim.api.nvim_set_hl(0, "LualineNoLsp", { fg = colors.overlay1, bg = colors.surface0 })
          vim.api.nvim_set_hl(0, "NetworkOffline", { fg = colors.base, bg = colors.red, bold = true })
          vim.api.nvim_set_hl(0, "NetworkOnline", { fg = colors.base, bg = colors.surface1, bold = true })
        end,
      })
      -- Apply immediately on load
      vim.api.nvim_set_hl(0, "CopilotOk", { fg = colors.base, bg = colors.green, bold = true })
      vim.api.nvim_set_hl(0, "CopilotProgress", { fg = colors.base, bg = colors.yellow, bold = true })
      vim.api.nvim_set_hl(0, "CopilotWarning", { fg = colors.base, bg = colors.red, bold = true })
      vim.api.nvim_set_hl(0, "LualineLsp", { fg = colors.base, bg = colors.blue, bold = true })
      vim.api.nvim_set_hl(0, "LualineNoLsp", { fg = colors.overlay1, bg = colors.surface0 })
      vim.api.nvim_set_hl(0, "NetworkOffline", { fg = colors.base, bg = colors.red, bold = true })
      vim.api.nvim_set_hl(0, "NetworkOnline", { fg = colors.base, bg = colors.surface1, bold = true })

      -- Dynamic theme: mode color updates lualine_a bg
      local custom_theme = {
        normal = {
          a = { fg = colors.base, bg = colors.blue, gui = "bold" },
          b = { fg = colors.text, bg = colors.surface1 },
          c = { fg = colors.subtext1, bg = colors.mantle },
        },
        insert = {
          a = { fg = colors.base, bg = colors.green, gui = "bold" },
          b = { fg = colors.text, bg = colors.surface1 },
          c = { fg = colors.subtext1, bg = colors.mantle },
        },
        visual = {
          a = { fg = colors.base, bg = colors.mauve, gui = "bold" },
          b = { fg = colors.text, bg = colors.surface1 },
          c = { fg = colors.subtext1, bg = colors.mantle },
        },
        replace = {
          a = { fg = colors.base, bg = colors.red, gui = "bold" },
          b = { fg = colors.text, bg = colors.surface1 },
          c = { fg = colors.subtext1, bg = colors.mantle },
        },
        command = {
          a = { fg = colors.base, bg = colors.peach, gui = "bold" },
          b = { fg = colors.text, bg = colors.surface1 },
          c = { fg = colors.subtext1, bg = colors.mantle },
        },
        terminal = {
          a = { fg = colors.base, bg = colors.teal, gui = "bold" },
          b = { fg = colors.text, bg = colors.surface1 },
          c = { fg = colors.subtext1, bg = colors.mantle },
        },
        inactive = {
          a = { fg = colors.overlay1, bg = colors.mantle },
          b = { fg = colors.overlay1, bg = colors.mantle },
          c = { fg = colors.overlay1, bg = colors.mantle },
        },
      }

      require('lualine').setup {
        options = {
          theme                = custom_theme,
          globalstatus         = true,
          -- Pill shape: rounded separators
          component_separators = { left = '', right = '' },
          section_separators   = { left = '', right = '' },
          disabled_filetypes   = { statusline = { 'NvimTree', 'alpha', 'dashboard' } },
          refresh              = { statusline = 500 },
        },
        sections = {
          lualine_a = {
            {
              -- Mode pill: full label + dynamic color
              function()
                local mode = vim.fn.mode()
                return " " .. (mode_labels[mode] or mode) .. " "
              end,
              color = function()
                local mode = vim.fn.mode()
                return { fg = colors.base, bg = mode_colors[mode] or colors.blue, gui = "bold" }
              end,
              separator = { left = '', right = '' },
            },
          },
          lualine_b = {
            {
              'branch',
              icon = '',
              color = { fg = colors.mauve, gui = "bold" },
            },
            {
              'diff',
              source = function()
                local has_mini_diff = pcall(require, 'mini.diff')
                if has_mini_diff then
                  local summary = vim.b.minidiff_summary
                  if summary then
                    return { added = summary.add, modified = summary.change, removed = summary.delete }
                  end
                end
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return { added = gitsigns.added, modified = gitsigns.changed, removed = gitsigns.removed }
                end
              end,
              symbols = { added = ' ', modified = ' ', removed = ' ' },
              diff_color = {
                added    = { fg = colors.green },
                modified = { fg = colors.yellow },
                removed  = { fg = colors.red },
              },
            },
          },
          lualine_c = {
            {
              'filename',
              file_status = true,
              path = 1, -- relative path
              symbols = {
                modified = '  ',
                readonly = '  ',
                unnamed  = '  No Name',
                newfile  = '  New',
              },
              color = { fg = colors.text, gui = "bold" },
            },
            {
              'diagnostics',
              sources           = { 'nvim_diagnostic' },
              sections          = { 'error', 'warn', 'info', 'hint' },
              symbols           = {
                error = ' ',
                warn  = ' ',
                info  = ' ',
                hint  = '󰌵 ',
              },
              diagnostics_color = {
                error = { fg = colors.red },
                warn  = { fg = colors.yellow },
                info  = { fg = colors.sky },
                hint  = { fg = colors.teal },
              },
            },
          },
          lualine_x = {
            -- Copilot pill
            {
              network_status,
              color = { bg = "NONE" },
            },
            {
              copilot_status,
              color = { bg = "NONE" },
            },
            -- LSP pill
            {
              lsp_names,
              color = { bg = "NONE" },
            },
            -- Encoding (only show if not utf-8)
            {
              'encoding',
              cond = function() return vim.opt.fileencoding:get() ~= 'utf-8' end,
              color = { fg = colors.overlay1 },
            },
            {
              'fileformat',
              symbols = { unix = ' LF', dos = ' CRLF', mac = ' CR' },
              color = { fg = colors.overlay1 },
            },
            {
              'filetype',
              icon_only = false,
              color = { fg = colors.lavender, gui = "bold" },
            },
          },
          lualine_y = {
            {
              'progress',
              color = { fg = colors.subtext1, gui = "bold" },
            },
          },
          lualine_z = {
            {
              'location',
              color = { fg = colors.base, bg = colors.lavender, gui = "bold" },
            },
          },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {
            { 'filename', color = { fg = colors.overlay1 } },
          },
          lualine_x = {
            { 'location', color = { fg = colors.overlay1 } },
          },
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
          inc_rename = true,
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
      vim.api.nvim_set_hl(0, "CursorLine", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "NONE", fg = "#cba6f7", bold = true }) -- optional, biar nomor baris tetap keliatan
      require('catppuccin').setup {
        flavour = 'mocha',
        transparent_background = true,
        dim_inactive = {
          enabled = false,
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
