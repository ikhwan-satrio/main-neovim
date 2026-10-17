-- keymaps
local map = vim.keymap.set

map("v", "<leader>cn", ":CarbonNow<CR>", { silent = true })

-- Telescope (lazy require: only loaded when keymap is triggered)
map({ 'n' }, '<leader>sf', function() require('telescope.builtin').find_files() end, { desc = '[F] files' })
map({ 'n' }, '<leader>sd', function() require('telescope.builtin').diagnostics() end, { desc = '[F] diagnostic' })
map({ 'n' }, '<leader>sp', function() require('telescope').extensions.project.project() end, { desc = '[F] projects' })
map({ 'n' }, '<leader>sn', function() require('telescope').extensions.notify.notify() end, { desc = '[F] notifications' })
map({ 'n' }, '<leader>su', function() require('telescope').extensions.undo.undo() end, { desc = '[F] undo' })

-- =====================================
-- FILE & SEARCH
-- =====================================
map({ 'n' }, '<leader>tm', function()
  require('mini.files').open()
end, { desc = "[T] mini" })
map('n', '<leader>ti', function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = '[T] inlay hints' })

map({ 'n' }, '<leader>sg', function() require('telescope.builtin').live_grep() end, { desc = '[F] live grep' })
map({ 'n' }, '<leader>sw', function() require('telescope.builtin').grep_string() end, { desc = '[F] word under cursor' })
map({ 'n' }, '<leader>sr', function() require('telescope.builtin').oldfiles() end, { desc = '[F] recent files' })
map({ 'n' }, '<leader>sb', function() require('telescope.builtin').buffers() end, { desc = '[F] buffers' })
map({ 'n' }, '<leader>sh', function() require('telescope.builtin').help_tags() end, { desc = '[F] help tags' })
map({ 'n' }, '<leader>sk', function() require('telescope.builtin').keymaps() end, { desc = '[F] keymaps' })
map({ 'n' }, '<leader>sc', function() require('telescope.builtin').commands() end, { desc = '[F] commands' })
map({ 'n' }, '<leader>sm', function() require('telescope.builtin').marks() end, { desc = '[F] marks' })
map({ 'n' }, '<leader>sj', function() require('telescope.builtin').jumplist() end, { desc = '[F] jumplist' })
map({ 'n' }, '<leader>sq', function() require('telescope.builtin').quickfix() end, { desc = '[F] quickfix' })

-- =====================================
-- LSP
-- =====================================
map({ 'n' }, '<leader>slr', function() require('telescope.builtin').lsp_references() end, { desc = '[L] references' })
map({ 'n' }, '<leader>sld', function() require('telescope.builtin').lsp_definitions() end, { desc = '[L] definitions' })
map({ 'n' }, '<leader>slt', function() require('telescope.builtin').lsp_type_definitions() end, { desc = '[L] type definitions' })
map({ 'n' }, '<leader>sli', function() require('telescope.builtin').lsp_implementations() end, { desc = '[L] implementations' })
map({ 'n' }, '<leader>sls', function() require('telescope.builtin').lsp_document_symbols() end, { desc = '[L] document symbols' })
map({ 'n' }, '<leader>slw', function() require('telescope.builtin').lsp_workspace_symbols() end, { desc = '[L] workspace symbols' })
map({ 'n' }, '<leader>lc', vim.lsp.buf.code_action, { desc = '[L] code action' })

-- =====================================
-- MISC
-- =====================================
map({ 'n' }, '<leader>s/', function() require('telescope.builtin').current_buffer_fuzzy_find() end, { desc = '[F] current buffer' })
map({ 'n' }, '<leader>s:', function() require('telescope.builtin').command_history() end, { desc = '[F] command history' })
map({ 'n' }, '<leader>s;', function() require('telescope.builtin').search_history() end, { desc = '[F] search history' })
map({ 'n' }, '<leader>sR', function() require('telescope.builtin').resume() end, { desc = '[F] resume last picker' })
map({ 'n' }, '<leader>sC', function() require('telescope.builtin').colorscheme() end, { desc = '[F] colorscheme' })
map({ 'n' }, '<leader>sH', function() require('telescope.builtin').highlights() end, { desc = '[F] highlights' })
map({ 'n' }, '<leader>sA', function() require('telescope.builtin').autocommands() end, { desc = '[F] autocommands' })
map({ 'n' }, '<leader>sO', function() require('telescope.builtin').vim_options() end, { desc = '[F] vim options' })

-- Find files including hidden/ignored
map({ 'n' }, '<leader>sF', function()
  require('telescope.builtin').find_files({ hidden = true, no_ignore = true })
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
map('n', '<A-Up>', ':m .-2<CR>==', { desc = 'Move line up', silent = true })
map('n', '<A-Down>', ':m .+1<CR>==', { desc = 'Move line down', silent = true })
map('n', 'D', '"_D')
map('n', '<leader>e', function()
  local ok, command = pcall(require, 'neo-tree.command')
  if ok then
    command.execute({ action = 'focus', toggle = true, source = 'filesystem' })
  end
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
map('n', '[b', '<cmd>bprevious<CR>', { desc = 'Prev Buffer' })
map('n', ']b', '<cmd>bnext<CR>', { desc = 'Next Buffer' })
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

map({ 'n', 'v' }, 'd', '"_d')
map({ 'n', 'i', 'v' }, '<C-s>', function()
  if vim.bo.modified then
    vim.cmd 'write'
  end
end, { desc = 'Save file', silent = true })
