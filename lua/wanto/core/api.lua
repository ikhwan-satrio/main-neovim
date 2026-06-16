vim.api.nvim_create_autocmd("LspAttach", {
  callback = function()
    vim.lsp.handlers["textDocument/signatureHelp"] = function() end
  end,
})

vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
  pattern = { '*.component.html', '*.container.html' },
  callback = function()
    vim.treesitter.start(nil, 'angular')
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end
  end,
})
