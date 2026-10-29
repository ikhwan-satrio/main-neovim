vim.env.CARGO_TARGET_DIR = vim.fn.expand('~/.cache/cargo-target')

return {
  cmd = { 'nil' },
  filetypes = { 'nix' },

  settings = {
    ['nil'] = {
      formatting = {
        command = { 'nixfmt' }, -- or 'alejandra', 'statix'
      },
      nix = {
        flake = {
          autoArchive = true,
        },
      },
    },
  },

  on_attach = function(client, bufnr)
    -- Enable inlay hints if supported
    if client.supports_method('textDocument/inlayHint') then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end

    -- Set keymaps for LSP functionality
    local opts = { noremap = true, silent = true }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  end,
}
