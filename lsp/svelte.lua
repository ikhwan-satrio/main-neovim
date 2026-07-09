return {
  cmd = { "svelteserver", "--stdio" },
  filetypes = { "svelte" },
  on_attach = function(_, bufnr)
    vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
  end,
}
