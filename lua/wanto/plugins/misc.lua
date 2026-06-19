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

      -- ~/.config/nvim/lua/config/mini-files-copy.lua
      local MiniFiles = require('mini.files')

      local clip_file = vim.fn.stdpath('cache') .. '/mini_files_clip.json'

      local function write_clip(data)
        local f = io.open(clip_file, 'w')
        if f then
          f:write(vim.json.encode(data))
          f:close()
        end
      end

      local function read_clip()
        local f = io.open(clip_file, 'r')
        if not f then return nil end
        local content = f:read('*a')
        f:close()
        local ok, data = pcall(vim.json.decode, content)
        return ok and data or nil
      end

      local function get_entry_path()
        local cur_entry = MiniFiles.get_fs_entry()
        return cur_entry and cur_entry.path or nil
      end

      -- Tandai file/dir untuk di-copy
      local function mark_copy()
        local path = get_entry_path()
        if not path then return end
        write_clip({ path = path, mode = 'copy' })
        vim.notify('Copied: ' .. path)
      end

      -- Tandai file/dir untuk di-cut (move)
      local function mark_cut()
        local path = get_entry_path()
        if not path then return end
        write_clip({ path = path, mode = 'cut' })
        vim.notify('Cut: ' .. path)
      end

      -- Paste ke direktori yang sedang dibuka di window mini.files
      local function paste()
        local clip = read_clip()
        if not clip then
          vim.notify('Clipboard kosong', vim.log.levels.WARN)
          return
        end

        local cur_entry = MiniFiles.get_fs_entry()
        local dest_dir

        if cur_entry and cur_entry.fs_type == 'directory' then
          dest_dir = cur_entry.path
        elseif cur_entry then
          -- entry adalah file -> ambil parent dir-nya
          dest_dir = vim.fn.fnamemodify(cur_entry.path, ':h')
        else
          -- fallback terakhir: ambil dari nama buffer mini.files saat ini
          local buf_name = vim.api.nvim_buf_get_name(0)
          dest_dir = vim.fn.fnamemodify(buf_name, ':h')
        end

        if not dest_dir or dest_dir == '' then
          vim.notify('Gagal menentukan direktori tujuan', vim.log.levels.ERROR)
          return
        end

        local basename = vim.fn.fnamemodify(clip.path, ':t')
        local dest_path = dest_dir .. '/' .. basename

        if vim.fn.isdirectory(clip.path) == 1 then
          vim.fn.system({ 'cp', '-r', clip.path, dest_path })
        else
          vim.fn.system({ 'cp', clip.path, dest_path })
        end

        if clip.mode == 'cut' then
          vim.fn.system({ 'rm', '-rf', clip.path })
          write_clip(nil)
        end

        MiniFiles.synchronize()
        vim.notify('Pasted to: ' .. dest_path)
      end

      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        callback = function(args)
          local buf_id = args.data.buf_id
          vim.keymap.set('n', 'yy', mark_copy, { buffer = buf_id, desc = 'Copy file/dir' })
          vim.keymap.set('n', 'xx', mark_cut, { buffer = buf_id, desc = 'Cut file/dir' })
          vim.keymap.set('n', 'p', paste, { buffer = buf_id, desc = 'Paste file/dir' })
        end,
      })
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
