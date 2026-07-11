local home = os.getenv("HOME")

-- Paths
local jdtls_path = home .. "/.local/share/nvim/mason/packages/jdtls"
local lombok_path = jdtls_path .. "/lombok.jar"
local workspace_dir = home .. "/.cache/nvim/jdtls-workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

---@type vim.lsp.Config
return {
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",

    -- Lombok support
    "-javaagent:" .. lombok_path,

    "-jar", vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
    "-configuration", jdtls_path .. "/config_linux",
    "-data", workspace_dir,
  },

  filetypes = { "java" },
  root_markers = { "mvnw", "gradlew", "pom.xml", "build.gradle" },

  settings = {
    java = {
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      format = {
        enabled = true,
      },
    },
    signatureHelp = { enabled = true },
    completion = {
      favoriteStaticMembers = {
        "org.junit.jupiter.api.Assertions.*",
        "java.util.Objects.requireNonNull",
        "org.mockito.Mockito.*",
      },
    },
    contentProvider = { preferred = "fernflower" },
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
  },

  flags = {
    allow_incremental_sync = true,
  },

  init_options = {
    bundles = {},
  },
}
