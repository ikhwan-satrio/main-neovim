vim.cmd [[set mouse=]]
vim.cmd [[set noswapfile]]

local severity = vim.diagnostic.severity
vim.diagnostic.config {
  virtual_text = true,
  underline = false,
  update_in_insert = false,
  severity_sort = true,
  signs = {
    text = {
      [severity.ERROR] = ' ',
      [severity.WARN] = ' ',
      [severity.HINT] = '󰠠 ',
      [severity.INFO] = ' ',
    },
  },
}

-- Settings
vim.g.lazyvim_rust_diagnostics = "rust-analyzer"
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = false
-- VimTeX global settings
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_view_forward_search_on_start = false
vim.g.vimtex_compiler_latexmk = {
  aux_dir = '/home/wanto/.textfiles/',
  out_dir = '/home/wanto/.textfiles/',
}
vim.g.vimtex_quickfix_open_on_warning = 0 -- No spam

vim.opt.termguicolors = true
vim.opt.wrap = false
vim.opt.sidescroll = 1
vim.opt.sidescrolloff = 5
vim.opt.laststatus = 3
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.o.cmdheight = 0
vim.o.number = true
vim.o.mouse = 'a'
vim.o.showmode = false
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true
