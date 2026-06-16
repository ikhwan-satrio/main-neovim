return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "BufReadPost",
    opts = function()
      -- cek koneksi ke github
      local online = vim.fn.system('ping -c 1 -W 1 github.com > /dev/null 2>&1; echo $?')
      local is_online = vim.trim(online) == '0'

      return {
        suggestion = {
          enabled = is_online and not vim.g.ai_cmp,
          auto_trigger = is_online,
          hide_during_completion = vim.g.ai_cmp,
          keymap = {
            accept = "<S-Tab>",
            next = "<M-]>",
            prev = "<M-[>",
          },
        },
        panel = { enabled = false },
        filetypes = {
          markdown = true,
          help = true,
        },
      }
    end,
  },

}
