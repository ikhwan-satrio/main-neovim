return {
  cmd = { "astro-ls", "--stdio" },
  filetypes = { "astro" },
  init_options = {
    typescript = {
      tsdk = vim.fn.stdpath("data") ..
      "/mason/packages/vtsls/node_modules/@vtsls/language-server/node_modules/typescript/lib"
    },
  },
}
