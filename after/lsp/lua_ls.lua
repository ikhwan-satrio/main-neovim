return {
  cmd = { "lua-language-server" },
  filetypes = { 'lua' }, -- Hanya aktif di .lua files
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        -- Tambahkan 'hl' ke globals agar tidak dianggap undefined
        globals = { "vim", "hl" },
      },
      workspace = {
        -- Ambil runtime files Neovim, lalu tambahkan direktori stub Hyprland
        library = vim.api.nvim_get_runtime_file("", true), -- load semua runtime Neovim
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
