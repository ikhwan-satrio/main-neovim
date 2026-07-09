---@type vim.lsp.Config
return {
  cmd = { "gopls", "serve" },
  filetypes = { "go", "gomod" },
  settings = {
    gopls = {
      hints = {
        assignVariableTypes    = true,
        compositeLiteralFields = true,
        compositeLiteralTypes  = true,
        constantValues         = true,
        functionTypeParameters = true,
        parameterNames         = true,
        rangeVariableTypes     = true,
      },
    },
  },
}
