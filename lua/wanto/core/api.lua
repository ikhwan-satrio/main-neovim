-- Disable signature help popup (biar gak ganggu)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function()
    vim.lsp.handlers["textDocument/signatureHelp"] = function() end
  end,
})

-- Treesitter untuk Angular template files
vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
  pattern = { '*.component.html', '*.container.html' },
  callback = function()
    vim.treesitter.start(nil, 'angular')
  end,
})

-- NOTE: Ensures that when exiting NeoVim, Zellij returns to normal mode
vim.api.nvim_create_autocmd("VimLeave", {
  pattern = "*",
  command = "silent !zellij action switch-mode normal"
})

vim.api.nvim_create_autocmd("User", {
  pattern = "TabtermShellCommandFinished",
  callback = function(ev)
    local data = ev.data or {}
    if data.workspace_visible then
      return
    end

    local label = data.command_label or data.terminal_label or "shell command"
    local level = data.success and vim.log.levels.INFO or vim.log.levels.ERROR
    vim.notify(("%s finished"):format(label), level)
  end,
})
