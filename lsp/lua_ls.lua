return {
  cmd = { "lua-language-server" },
  filetypes = { 'lua' },   -- Hanya aktif di .lua files
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
      hint = {
        arrayIndex = "Disable",
      },
    },
  },
}
