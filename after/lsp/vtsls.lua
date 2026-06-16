local function get_pkg_path(pkg, subpath)
  local base = vim.fn.stdpath("data") .. "/mason/packages/" .. pkg
  if subpath then
    base = base .. subpath
  end
  return base
end

local additional_plugins = {
  {
    name = "typescript-svelte-plugin",
    location = get_pkg_path("svelte-language-server", "/node_modules/typescript-svelte-plugin"),
    enableForWorkspaceTypeScriptVersions = true,
  },
  {
    name = "@astrojs/ts-plugin",
    location = get_pkg_path("astro-language-server", "/node_modules/@astrojs/ts-plugin"),
    enableForWorkspaceTypeScriptVersions = true,
  },
  {
    name = "@angular/language-server",
    location = get_pkg_path("angular-language-server", "/node_modules/@angular/language-server"),
    enableForWorkspaceTypeScriptVersions = false,
  },
  {
    name = "@vue/typescript-plugin",
    location = get_pkg_path("vue-language-server", "/node_modules/@vue/language-server"),
    languages = { "vue" },
    configNamespace = "typescript",
    enableForWorkspaceTypeScriptVersions = true,
  },
}

---@type vim.lsp.Config
return {
  cmd = { "vtsls", "--stdio" },
  root_markers = { "node_modules", "package.json" },
  filetypes = {
    "typescript",
    "javascript",
    "javascriptreact",
    "typescriptreact",
    "vue",
  },
  settings = {
    complete_function_calls = true,
    vtsls = {
      enableMoveToFileCodeAction = true,
      autoUseWorkspaceTsdk = true,
      experimental = {
        maxInlayHintLength = 30,
        completion = {
          enableServerSideFuzzyMatch = true,
        },
      },
      tsserver = {
        globalPlugins = additional_plugins,
      },
    },
    typescript = {
      tsdk = (function()
        local local_ts = vim.fn.getcwd() .. "/node_modules/typescript/lib"
        if vim.fn.isdirectory(local_ts) == 1 then
          return local_ts
        end
        return vim.fn.stdpath("data") ..
            "/mason/packages/vtsls/node_modules/@vtsls/language-server/node_modules/typescript/lib"
      end)(),
      updateImportsOnFileMove = {
        enabled = "always",
      },
      suggest = {
        completeFunctionCalls = true,
      },
      inlayHints = {
        enumMemberValues = { enabled = true },
        functionLikeReturnTypes = { enabled = false },
        parameterNames = { enabled = "literals" },
        parameterTypes = { enabled = false },
        propertyDeclarationTypes = { enabled = false },
        variableTypes = { enabled = false },
      },
    },
  },
  on_attach = function()
    vim.lsp.enable('vue_ls')
  end,
}
