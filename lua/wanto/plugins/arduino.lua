return {
  "yuukiflow/Arduino-Nvim",
  opts = {
    use_default_keymaps = true,  -- tetap load keymap bawaan (<Leader>ac, au, dst)
    use_default_commands = true,
    picker_backend = "telescope",
    keymaps = {
      {
        mode = "n",
        key = "<Leader>aR",
        func = ":InoUploadReset<CR>",
        desc = "Upload dengan reset manual (buat board yang susah sync)",
        opts = { silent = true },
      },
      {
        mode = "n",
        key = "<Leader>aD",
        func = ":InoDebugUpload<CR>",
        desc = "Debug upload (verbose)",
        opts = { silent = true },
      },
      {
        mode = "n",
        key = "<Leader>aL",
        func = ":InoList<CR>",
        desc = "List semua port Arduino yang terdeteksi",
        opts = { silent = true },
      },
      {
        mode = "n",
        key = "<Leader>aB",
        func = ":InoSetBaud 9600<CR>",
        desc = "Set baudrate serial monitor ke 9600",
        opts = { silent = true },
      },
    },
  },
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
}
