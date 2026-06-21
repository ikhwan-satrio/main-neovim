-- keymaps
local map = vim.keymap.set
local builtIn = require 'telescope.builtin'
local extensions = require('telescope').extensions

-- Telescope
map({ 'n' }, '<leader>sf', builtIn.find_files, { desc = '[F] files' })
map({ 'n' }, '<leader>sd', builtIn.diagnostics, { desc = '[F] diagnostic' })
map({ 'n' }, '<leader>sp', extensions.project.project, { desc = '[F] projects' })
map({ 'n' }, '<leader>sn', extensions.notify.notify, { desc = '[F] notifications' })
map({ 'n' }, '<leader>su', extensions.undo.undo, { desc = '[F] undo' })

-- =====================================
-- FILE & SEARCH
-- =====================================
map({ 'n' }, '<leader>tm', function()
  require('mini.files').open()
end, { desc = "[T] mini" })
map('n', '<leader>ti', function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = '[T] inlay hints' })

map({ 'n' }, '<leader>sg', builtIn.live_grep, { desc = '[F] live grep' })
map({ 'n' }, '<leader>sw', builtIn.grep_string, { desc = '[F] word under cursor' })
map({ 'n' }, '<leader>sr', builtIn.oldfiles, { desc = '[F] recent files' })
map({ 'n' }, '<leader>sb', builtIn.buffers, { desc = '[F] buffers' })
map({ 'n' }, '<leader>sh', builtIn.help_tags, { desc = '[F] help tags' })
map({ 'n' }, '<leader>sk', builtIn.keymaps, { desc = '[F] keymaps' })
map({ 'n' }, '<leader>sc', builtIn.commands, { desc = '[F] commands' })
map({ 'n' }, '<leader>sm', builtIn.marks, { desc = '[F] marks' })
map({ 'n' }, '<leader>sj', builtIn.jumplist, { desc = '[F] jumplist' })
map({ 'n' }, '<leader>sq', builtIn.quickfix, { desc = '[F] quickfix' })

-- =====================================
-- LSP
-- =====================================
map({ 'n' }, '<leader>slr', builtIn.lsp_references, { desc = '[L] references' })
map({ 'n' }, '<leader>sld', builtIn.lsp_definitions, { desc = '[L] definitions' })
map({ 'n' }, '<leader>slt', builtIn.lsp_type_definitions, { desc = '[L] type definitions' })
map({ 'n' }, '<leader>sli', builtIn.lsp_implementations, { desc = '[L] implementations' })
map({ 'n' }, '<leader>sls', builtIn.lsp_document_symbols, { desc = '[L] document symbols' })
map({ 'n' }, '<leader>slw', builtIn.lsp_workspace_symbols, { desc = '[L] workspace symbols' })
map({ 'n' }, '<leader>lc', vim.lsp.buf.code_action, { desc = '[L] code action' })

-- =====================================
-- MISC
-- =====================================
map({ 'n' }, '<leader>s/', builtIn.current_buffer_fuzzy_find, { desc = '[F] current buffer' })
map({ 'n' }, '<leader>s:', builtIn.command_history, { desc = '[F] command history' })
map({ 'n' }, '<leader>s;', builtIn.search_history, { desc = '[F] search history' })
map({ 'n' }, '<leader>sR', builtIn.resume, { desc = '[F] resume last picker' })
map({ 'n' }, '<leader>sC', builtIn.colorscheme, { desc = '[F] colorscheme' })
map({ 'n' }, '<leader>sH', builtIn.highlights, { desc = '[F] highlights' })
map({ 'n' }, '<leader>sA', builtIn.autocommands, { desc = '[F] autocommands' })
map({ 'n' }, '<leader>sO', builtIn.vim_options, { desc = '[F] vim options' })

-- Find files including hidden/ignored
map({ 'n' }, '<leader>sF', function()
  builtIn.find_files({ hidden = true, no_ignore = true })
end, { desc = '[F] all files (hidden)' })

-- Terminal

-- Insert
map("n", "<leader>rn", function()
  return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true })
map('i', '<A-Up>', '<Esc>:m .-2<CR>==gi', { desc = 'Move line up', silent = true })
map('i', '<A-Down>', '<Esc>:m .+1<CR>==gi', { desc = 'Move line down', silent = true })

-- Visual
map('v', '<A-Down>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down', silent = true })
map('v', '<A-Up>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up', silent = true })

-- Normal
map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus left' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus right' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus down' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus up' })
map('n', '<A-Up>', ':m .-2<CR>==', { desc = 'Move line up', silent = true })
map('n', '<A-Down>', ':m .+1<CR>==', { desc = 'Move line down', silent = true })
map('n', 'D', '"_D')
map('n', '<leader>e', function()
  require('nvim-tree.api').tree.toggle()
end, { desc = '[E]xplorer' })
map('n', '<leader>xx', function()
  require('trouble').toggle { mode = 'diagnostics' }
end, { desc = 'Diagnostics (Trouble)' })

map('n', '<leader>bd', function()
  MiniBufremove.delete()
end, { desc = 'Buffer [D]elete' })
map('n', '<leader>bD', function()
  MiniBufremove.wipeout()
end, { desc = 'Buffer [D]elete!' })
map('n', '[b', '<cmd>bprevious<CR>', { desc = 'Prev Buffer' }) -- UPDATE (no BufferLine)
map('n', ']b', '<cmd>bnext<CR>', { desc = 'Next Buffer' })     -- UPDATE (no BufferLine)
map('n', '<leader>f', function()
  require('conform').format { async = true, lsp_fallback = true }
end, { desc = '[F]ormat buffer' })
map("n", "<C-t>", function()
  require("menu").open("default", { border = true })
end, {})

-- Mixed
map({ "n", "v" }, "<RightMouse>", function()
  require('menu.utils').delete_old_menus()

  vim.cmd.exec '"normal! \\<RightMouse>"'

  -- clicked buf
  local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
  local options = vim.bo[buf].ft == "NvimTree" and "nvimtree" or "default"

  require("menu").open(options, { mouse = true, border = true })
end, {})
map({ 'n', 'i' }, '<leader>tt', ':ToggleTerm<CR>', { desc = "[T] term" })
map({ 'n', 'v' }, 'd', '"_d')
map({ 'n', 'i', 'v' }, '<C-s>', function()
  if vim.bo.modified then
    vim.cmd 'write'
  end
end, { desc = 'Save file', silent = true })
