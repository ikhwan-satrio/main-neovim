local ts_path = vim.fn.stdpath("data")
    .. "/mason/packages/vtsls/node_modules/@vtsls/language-server/node_modules/typescript/lib"

---@type vim.lsp.Config
return {
  cmd = { "vue-language-server", "--stdio", "--tsdk=" .. ts_path },
  filetypes = { "vue" },
}
