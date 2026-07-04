---@type vim.lsp.Config
return {
  cmd = { "deno", "lsp" },
  single_file_support = false,
  settings = {
    deno = {
      enable = true,
      lint = true,
      unstable = true,
      suggest = {
        imports = {
          hosts = {
            ["https://deno.land"] = true,
            ["https://esm.sh"] = true,
          },
        },
      },
    },
  },
  on_attach = function(_, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
      vim.lsp.buf.format({ bufnr = bufnr })
    end, {})
  end
}
