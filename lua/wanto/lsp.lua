vim.lsp.document_color.enable(false)

local enabled = {}

local filetype_to_lsp = {
  graphql         = { 'graphql' },
  toml            = { 'taplo' },
  zig             = { 'zls' },
  html            = { 'emmet_ls' },
  kotlin          = { 'kotlin-lsp' },
  rust            = { 'rust-analyzer' },
  java            = { 'jdtls' },
  hypr            = { 'hyprls' },
  go              = { 'gopls' },
  astro           = { 'astro' },
  elixir          = { 'elixirls' },
  json            = { 'jsonls' },
  jsonc           = { 'jsonls' },
  lua             = { 'lua_ls' },
  svelte          = { 'svelte', 'tailwindcss' },
  typescript      = { 'vtsls', 'tailwindcss', 'denols' },
  typescriptreact = { 'vtsls', 'tailwindcss', 'denols' },
  javascript      = { 'vtsls' },
  javascriptreact = { 'vtsls' },
  vue             = { 'vtsls', 'tailwindcss' },
  nix             = { 'nixd' },
  markdown        = { 'marksman' },
  python          = { 'basedpyright' },
  c               = { 'clangd' },
  cpp             = { 'clangd' },
  php             = { 'intelephense' },
  odin            = { 'ols' },
  spwn            = { 'protols' },
}

vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local servers = filetype_to_lsp[vim.bo[args.buf].filetype]
    if servers then
      for _, server in ipairs(servers) do
        if not enabled[server] then
          enabled[server] = true
          vim.lsp.enable(server)
        end
      end
    end
  end,
})
