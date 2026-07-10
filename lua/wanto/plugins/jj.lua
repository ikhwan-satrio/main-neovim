return {
  -- ============================================================================
  -- JJ.NVIM - Core Jujutsu VCS integration
  -- ============================================================================
  {
    "nicolasgb/jj.nvim",
    version = "*",
    dependencies = {
      "sindrets/diffview.nvim",
      {
        "zschreur/telescope-jj.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
      },
    },

    config = function()
      local jj = require("jj")

      jj.setup({
        picker = {},

        editor = {
          auto_insert = true,
          window = {
            type = "floating",
            floating_width = 0.9,
            floating_height = 0.85,
          },
        },

        highlights = {
          editor = {
            renamed = { fg = "#d29922", ctermfg = "Yellow" },
          },
          log = {
            selected = { bg = "#3d2c52", ctermbg = "DarkMagenta" },
            targeted = { fg = "#5a9e6f", ctermfg = "Green" },
          },
        },

        terminal = {
          cursor_render_delay = 10,
          window = {
            type = "hsplit",
            split_size = 0.5,
            floating_width = 0.99,
            floating_height = 0.95,
          },
        },

        diff = {
          backend = "diffview",
        },

        cmd = {
          describe = {
            editor = {
              type = "buffer",
              keymaps = {
                close = { "q", "<Esc>", "<C-c>" },
              },
            },
          },
          log = {
            close_on_edit = false,
          },
          bookmark = {
            prefix = "",
          },
          keymaps = {
            log = {
              edit = "<CR>",
              edit_immutable = "<S-CR>",
              describe = "d",
              diff = "<S-d>",
              new = "n",
              new_after = "<C-n>",
              new_after_immutable = "<S-n>",
              undo = "<S-u>",
              redo = "<S-r>",
              abandon = "a",
              bookmark = "b",
              fetch = "f",
              push = "p",
              push_all = "<S-p>",
              open_pr = "o",
              open_pr_list = "<S-o>",
              rebase = "r",
              squash = "s",
              quick_squash = "<S-s>",
              split = "<C-s>",
              history = "<S-h>",
              change_revset = "<C-r>",
              tag_set = "<S-t>",
              summary = "<S-k>",
              select_next_revision = "gj",
              select_prev_revision = "gk",
            },
            status = {
              open_file = "<CR>",
              restore_file = "<S-x>",
            },
            close = { "q", "<Esc>" },
            floating = {
              close = "q",
              hide = "<Esc>",
            },
          },
        },
      })

      -- Load telescope-jj extension
      pcall(require("telescope").load_extension, "jj")

      -- ============ JJ.NVIM COMMAND KEYMAPS ============
      local cmd = require("jj.cmd")
      local diff = require("jj.diff")
      local annotate = require("jj.annotate")

      local map = vim.keymap.set
      local opts = { silent = true }

      -- Command inti
      map("n", "<leader>jd", cmd.describe, vim.tbl_extend("force", opts, { desc = "JJ describe" }))
      map("n", "<leader>je", cmd.edit, vim.tbl_extend("force", opts, { desc = "JJ edit" }))
      map("n", "<leader>jn", cmd.new, vim.tbl_extend("force", opts, { desc = "JJ new" }))
      map("n", "<leader>jc", cmd.commit, vim.tbl_extend("force", opts, { desc = "JJ commit (describe + new)" }))
      map("n", "<leader>jS", cmd.squash, vim.tbl_extend("force", opts, { desc = "JJ squash" }))
      map("n", "<leader>ju", cmd.undo, vim.tbl_extend("force", opts, { desc = "JJ undo" }))
      map("n", "<leader>jy", cmd.redo, vim.tbl_extend("force", opts, { desc = "JJ redo" }))
      map("n", "<leader>jr", cmd.rebase, vim.tbl_extend("force", opts, { desc = "JJ rebase" }))

      -- Bookmark
      map("n", "<leader>jbc", cmd.bookmark_create, vim.tbl_extend("force", opts, { desc = "JJ bookmark create" }))
      map("n", "<leader>jbd", cmd.bookmark_delete, vim.tbl_extend("force", opts, { desc = "JJ bookmark delete" }))
      map("n", "<leader>jbm", cmd.bookmark_move, vim.tbl_extend("force", opts, { desc = "JJ bookmark move" }))
      map("n", "<leader>jbt", cmd.bookmark_track, vim.tbl_extend("force", opts, { desc = "JJ bookmark track" }))
      map("n", "<leader>jbf", cmd.bookmark_forget, vim.tbl_extend("force", opts, { desc = "JJ bookmark forget" }))

      -- Tag
      map("n", "<leader>jts", cmd.tag_set, vim.tbl_extend("force", opts, { desc = "JJ tag set" }))
      map("n", "<leader>jtd", cmd.tag_delete, vim.tbl_extend("force", opts, { desc = "JJ tag delete" }))
      map("n", "<leader>jtp", cmd.tag_push, vim.tbl_extend("force", opts, { desc = "JJ tag push" }))

      -- Remote
      map("n", "<leader>ja", cmd.abandon, vim.tbl_extend("force", opts, { desc = "JJ abandon" }))
      map("n", "<leader>jf", cmd.fetch, vim.tbl_extend("force", opts, { desc = "JJ fetch" }))
      map("n", "<leader>jp", cmd.push, vim.tbl_extend("force", opts, { desc = "JJ push" }))
      map("n", "<leader>jpr", cmd.open_pr, vim.tbl_extend("force", opts, { desc = "JJ open PR" }))
      map("n", "<leader>jpl", function()
        cmd.open_pr({ list_bookmarks = true })
      end, vim.tbl_extend("force", opts, { desc = "JJ open PR (pilih bookmark)" }))

      -- Diff
      map("n", "<leader>dv", function() diff.open_vdiff() end,
        vim.tbl_extend("force", opts, { desc = "JJ vertical diff (vs parent)" }))
      map("n", "<leader>dh", function() diff.open_hdiff() end,
        vim.tbl_extend("force", opts, { desc = "JJ horizontal diff (vs parent)" }))

      -- Annotate (blame)
      map("n", "<leader>jaf", annotate.file, vim.tbl_extend("force", opts, { desc = "JJ annotate file" }))
      map("n", "<leader>jal", annotate.line, vim.tbl_extend("force", opts, { desc = "JJ annotate line" }))

      -- ============ CUSTOM TELESCOPE JJ PICKERS ============
      local pickers = require("telescope.pickers")
      local finders = require("telescope.finders")
      local conf = require("telescope.config").values
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")

      local function jj_cmd(args, callback)
        vim.system({ "jj" .. args }, { text = true }, function(out)
          vim.schedule(function()
            callback(out.stdout or "", out.stderr or "")
          end)
        end)
      end

      -- jj log picker
      map("n", "<leader>jl", function()
        jj_cmd(
        " log --no-graph -T 'change_id.short(8) ++ \"|\" ++ author.name() ++ \"|\" ++ description.first_line()' --limit 50",
          function(stdout)
            if stdout == "" then return end
            local entries = {}
            for line in stdout:gmatch("[^\n]+") do
              local change_id, author, desc = line:match("^(%S+)%|(.+)%|(.*)$")
              if change_id then
                table.insert(entries, {
                  change_id = change_id,
                  author = author,
                  display = string.format("%s  %s  %s", change_id, author, desc ~= "" and desc or "(no description)"),
                  ordinal = change_id .. " " .. author .. " " .. desc,
                })
              end
            end
            pickers
                .new({}, {
                  prompt_title = "JJ Log",
                  finder = finders.new_table({
                    results = entries,
                    entry_maker = function(entry)
                      return {
                        value = entry,
                        display = entry.display,
                        ordinal = entry.ordinal,
                      }
                    end,
                  }),
                  sorter = conf.generic_sorter({}),
                  previewer = nil,
                  attach_mappings = function(_, map_action)
                    map_action("i", "<CR>", function(prompt_bufnr)
                      local selection = action_state.get_selected_entry()
                      actions.close(prompt_bufnr)
                      if selection then
                        vim.cmd("J edit " .. selection.value.change_id)
                      end
                    end)
                    return true
                  end,
                })
                :find()
          end)
      end, vim.tbl_extend("force", opts, { desc = "JJ telescope log" }))

      -- jj log (all revisions)
      map("n", "<leader>jL", function()
        jj_cmd(" log --no-graph -T 'change_id.short(8) ++ \"|\" ++ author.name() ++ \"|\" ++ description.first_line()'",
          function(stdout)
            if stdout == "" then return end
            local entries = {}
            for line in stdout:gmatch("[^\n]+") do
              local change_id, author, desc = line:match("^(%S+)%|(.+)%|(.*)$")
              if change_id then
                table.insert(entries, {
                  change_id = change_id,
                  author = author,
                  display = string.format("%s  %s  %s", change_id, author, desc ~= "" and desc or "(no description)"),
                  ordinal = change_id .. " " .. author .. " " .. desc,
                })
              end
            end
            pickers
                .new({}, {
                  prompt_title = "JJ Log (All)",
                  finder = finders.new_table({
                    results = entries,
                    entry_maker = function(entry)
                      return {
                        value = entry,
                        display = entry.display,
                        ordinal = entry.ordinal,
                      }
                    end,
                  }),
                  sorter = conf.generic_sorter({}),
                  previewer = nil,
                  attach_mappings = function(_, map_action)
                    map_action("i", "<CR>", function(prompt_bufnr)
                      local selection = action_state.get_selected_entry()
                      actions.close(prompt_bufnr)
                      if selection then
                        vim.cmd("J edit " .. selection.value.change_id)
                      end
                    end)
                    return true
                  end,
                })
                :find()
          end)
      end, vim.tbl_extend("force", opts, { desc = "JJ telescope log (all)" }))

      -- jj status (changed files) via telescope-jj
      map("n", "<leader>js", function()
        local ok, jj_ext = pcall(require, "telescope-extensions.jj")
        if ok then
          jj_ext.diff()
        else
          vim.cmd("J status")
        end
      end, vim.tbl_extend("force", opts, { desc = "JJ telescope status (changed files)" }))

      -- jj files (all tracked files) via telescope-jj
      map("n", "<leader>gj", function()
        local ok, jj_ext = pcall(require, "telescope-extensions.jj")
        if ok then
          jj_ext.files()
        else
          vim.cmd("J status")
        end
      end, vim.tbl_extend("force", opts, { desc = "JJ telescope files" }))

      -- jj file history
      map("n", "<leader>jgh", function()
        local file = vim.fn.expand("%:p")
        if file == "" then return end
        jj_cmd(
        " log --no-graph -r 'file(\"" ..
        file .. "\")' -T 'change_id.short(8) ++ \"|\" ++ author.name() ++ \"|\" ++ description.first_line()'",
          function(stdout)
            if stdout == "" then
              vim.notify("Tidak ada riwayat untuk file ini", vim.log.levels.WARN)
              return
            end
            local entries = {}
            for line in stdout:gmatch("[^\n]+") do
              local change_id, author, desc = line:match("^(%S+)%|(.+)%|(.*)$")
              if change_id then
                table.insert(entries, {
                  change_id = change_id,
                  author = author,
                  display = string.format("%s  %s  %s", change_id, author, desc ~= "" and desc or "(no description)"),
                  ordinal = change_id .. " " .. author .. " " .. desc,
                })
              end
            end
            pickers
                .new({}, {
                  prompt_title = "JJ File History",
                  finder = finders.new_table({
                    results = entries,
                    entry_maker = function(entry)
                      return {
                        value = entry,
                        display = entry.display,
                        ordinal = entry.ordinal,
                      }
                    end,
                  }),
                  sorter = conf.generic_sorter({}),
                  previewer = nil,
                  attach_mappings = function(_, map_action)
                    map_action("i", "<CR>", function(prompt_bufnr)
                      local selection = action_state.get_selected_entry()
                      actions.close(prompt_bufnr)
                      if selection then
                        vim.cmd("J edit " .. selection.value.change_id)
                      end
                    end)
                    return true
                  end,
                })
                :find()
          end)
      end, vim.tbl_extend("force", opts, { desc = "JJ telescope file history" }))

      -- jj conflicts via telescope-jj
      map("n", "<leader>gC", function()
        local ok, jj_ext = pcall(require, "telescope-extensions.jj")
        if ok then
          jj_ext.conflict()
        else
          vim.cmd("J log -r 'conflicts()'")
        end
      end, vim.tbl_extend("force", opts, { desc = "JJ telescope conflicts" }))

      -- jj bookmarks picker
      map("n", "<leader>gB", function()
        jj_cmd(" bookmark list --no-graph -T 'name ++ \"|\" ++ change_id.short(8)'", function(stdout)
          if stdout == "" then
            vim.notify("Tidak ada bookmark", vim.log.levels.WARN)
            return
          end
          local entries = {}
          for line in stdout:gmatch("[^\n]+") do
            local name, change_id = line:match("^(%S+)%|(.+)$")
            if name then
              table.insert(entries, {
                name = name,
                change_id = change_id,
                display = string.format("%s  (%s)", name, change_id),
                ordinal = name,
              })
            end
          end
          pickers
              .new({}, {
                prompt_title = "JJ Bookmarks",
                finder = finders.new_table({
                  results = entries,
                  entry_maker = function(entry)
                    return {
                      value = entry,
                      display = entry.display,
                      ordinal = entry.ordinal,
                    }
                  end,
                }),
                sorter = conf.generic_sorter({}),
                previewer = nil,
                attach_mappings = function(_, map_action)
                  map_action("i", "<CR>", function(prompt_bufnr)
                    local selection = action_state.get_selected_entry()
                    actions.close(prompt_bufnr)
                    if selection then
                      vim.cmd("J edit " .. selection.value.change_id)
                    end
                  end)
                  return true
                end,
              })
              :find()
        end)
      end, vim.tbl_extend("force", opts, { desc = "JJ telescope bookmarks" }))

      -- jj tags picker
      map("n", "<leader>gT", function()
        jj_cmd(" tag list --no-graph -T 'name ++ \"|\" ++ change_id.short(8)'", function(stdout)
          if stdout == "" then
            vim.notify("Tidak ada tag", vim.log.levels.WARN)
            return
          end
          local entries = {}
          for line in stdout:gmatch("[^\n]+") do
            local name, change_id = line:match("^(%S+)%|(.+)$")
            if name then
              table.insert(entries, {
                name = name,
                change_id = change_id,
                display = string.format("%s  (%s)", name, change_id),
                ordinal = name,
              })
            end
          end
          pickers
              .new({}, {
                prompt_title = "JJ Tags",
                finder = finders.new_table({
                  results = entries,
                  entry_maker = function(entry)
                    return {
                      value = entry,
                      display = entry.display,
                      ordinal = entry.ordinal,
                    }
                  end,
                }),
                sorter = conf.generic_sorter({}),
                previewer = nil,
                attach_mappings = function(_, map_action)
                  map_action("i", "<CR>", function(prompt_bufnr)
                    local selection = action_state.get_selected_entry()
                    actions.close(prompt_bufnr)
                    if selection then
                      vim.cmd("J edit " .. selection.value.change_id)
                    end
                  end)
                  return true
                end,
              })
              :find()
        end)
      end, vim.tbl_extend("force", opts, { desc = "JJ telescope tags" }))

      -- jj operation log picker
      map("n", "<leader>go", function()
        jj_cmd(
        " op log --no-graph -T 'id.short(8) ++ \"|\" ++ description ++ \"|\" ++ time.format_utc(\"%Y-%m-%d %H:%M:%S\")'",
          function(stdout)
            if stdout == "" then return end
            local entries = {}
            for line in stdout:gmatch("[^\n]+") do
              local id, desc, time_str = line:match("^(%S+)%|(.+)%|(.*)$")
              if id then
                table.insert(entries, {
                  id = id,
                  display = string.format("%s  %s  %s", id, desc, time_str),
                  ordinal = id .. " " .. desc,
                })
              end
            end
            pickers
                .new({}, {
                  prompt_title = "JJ Operation Log",
                  finder = finders.new_table({
                    results = entries,
                    entry_maker = function(entry)
                      return {
                        value = entry,
                        display = entry.display,
                        ordinal = entry.ordinal,
                      }
                    end,
                  }),
                  sorter = conf.generic_sorter({}),
                  previewer = nil,
                  attach_mappings = function(_, map_action)
                    map_action("i", "<CR>", function(prompt_bufnr)
                      local selection = action_state.get_selected_entry()
                      actions.close(prompt_bufnr)
                      if selection then
                        vim.cmd("J undo " .. selection.value.id)
                      end
                    end)
                    return true
                  end,
                })
                :find()
          end)
      end, vim.tbl_extend("force", opts, { desc = "JJ telescope operation log" }))
    end,
  },

  -- ============================================================================
  -- JJ-SIGNS.NVIM - Gutter signs, hunk navigation, blame
  -- ============================================================================
  {
    "bnrobinson93/jj-signs.nvim",
    event = { "BufReadPost", "BufNewFile", "InsertEnter" },
    init = function()
      vim.api.nvim_create_autocmd("BufEnter", {
        callback = function()
          local jj_signs = require("jj-signs")
          if not jj_signs.is_attached() then
            jj_signs.attach()
          end
        end,
      })
    end,
    config = function()
      local jj_signs = require("jj-signs")

      jj_signs.setup({
        signs = {
          add          = { text = "▎" },
          change       = { text = "▎" },
          delete       = { text = "▁" },
          topdelete    = { text = "▔" },
          changedelete = { text = "▎" },
          conflict     = { text = "╪" },
        },
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        show_deleted = false,
        conflict_hl = true,
        max_file_length = 40000,
        sign_priority = 6,
        use_decoration_provider = true,
        jj_cmd = "jj",
        status_formatter = function(d)
          local parts = {}
          if (d.added or 0) > 0 then parts[#parts + 1] = "+" .. d.added end
          if (d.changed or 0) > 0 then parts[#parts + 1] = "~" .. d.changed end
          if (d.removed or 0) > 0 then parts[#parts + 1] = "-" .. d.removed end
          return table.concat(parts, " ")
        end,
        preview_config = {
          border = "rounded",
          style = "minimal",
          relative = "cursor",
          row = 1,
          col = 0,
        },
        nav = {
          wrap = true,
          navigation_message = true,
          foldopen = true,
          preview = false,
        },
        diff_opts = {
          algorithm = "myers",
          indent_heuristic = true,
          linematch = 60,
          ignore_whitespace = false,
          ignore_whitespace_change = false,
        },
        current_line_blame = true,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol",
          delay = 500,
          format = "‹ %s • %a • %r",
        },
      })

      local map = vim.keymap.set
      local opts = { silent = true }

      -- Hunk navigation
      map("n", "[c", function() jj_signs.nav_hunk("prev") end, vim.tbl_extend("force", opts, { desc = "JJ prev hunk" }))
      map("n", "]c", function() jj_signs.nav_hunk("next") end, vim.tbl_extend("force", opts, { desc = "JJ next hunk" }))

      -- Hunk actions
      map("n", "<leader>hp", function() jj_signs.preview_hunk() end,
        vim.tbl_extend("force", opts, { desc = "JJ preview hunk" }))
      map("n", "<leader>hs", function() jj_signs.select_hunk() end,
        vim.tbl_extend("force", opts, { desc = "JJ select hunk" }))
      map("n", "<leader>hr", function() jj_signs.reset_hunk() end,
        vim.tbl_extend("force", opts, { desc = "JJ reset hunk" }))
      map("n", "<leader>hR", function() jj_signs.reset_buffer() end,
        vim.tbl_extend("force", opts, { desc = "JJ reset buffer" }))
      map("n", "<leader>hd", function() jj_signs.diffthis() end, vim.tbl_extend("force", opts, { desc = "JJ diffthis" }))

      -- Blame
      map("n", "<leader>hb", function() jj_signs.blame_line() end,
        vim.tbl_extend("force", opts, { desc = "JJ blame line" }))
      map("n", "<leader>hB", function() jj_signs.blame() end, vim.tbl_extend("force", opts, { desc = "JJ blame file" }))
      map("n", "<leader>ht", function() jj_signs.toggle_current_line_blame() end,
        vim.tbl_extend("force", opts, { desc = "JJ toggle inline blame" }))

      -- Toggle
      map("n", "<leader>ts", function() jj_signs.toggle_signs() end,
        vim.tbl_extend("force", opts, { desc = "JJ toggle signs" }))
    end,
  },

  -- ============================================================================
  -- DIFFVIEW.NVIM - Diff panel & viewing
  -- ============================================================================
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose", "DiffviewRefresh" },
    config = function()
      local actions = require("diffview.actions")

      require("diffview").setup({
        enhanced_diff_hl = true,
        use_icons = true,
        keymaps = {
          disable_defaults = false,
          view = {
            { "n", "<leader>do", actions.toggle_files,       { desc = "Toggle file panel" } },
            { "n", "<leader>dc", "<Cmd>DiffviewClose<CR>",   { desc = "Close diffview" } },
            { "n", "<leader>dr", "<Cmd>DiffviewRefresh<CR>", { desc = "Refresh diffview" } },
          },
          file_panel = {
            { "n", "j",      actions.next_entry,         { desc = "Next entry" } },
            { "n", "<down>", actions.next_entry,         { desc = "Next entry" } },
            { "n", "k",      actions.prev_entry,         { desc = "Previous entry" } },
            { "n", "<up>",   actions.prev_entry,         { desc = "Previous entry" } },
            { "n", "<cr>",   actions.select_entry,       { desc = "Open diff" } },
            { "n", "o",      actions.select_entry,       { desc = "Open diff" } },
            { "n", "-",      actions.toggle_stage_entry, { desc = "Stage/unstage entry" } },
            { "n", "S",      actions.stage_all,          { desc = "Stage all" } },
            { "n", "U",      actions.unstage_all,        { desc = "Unstage all" } },
            { "n", "X",      actions.restore_entry,      { desc = "Restore entry" } },
            { "n", "L",      actions.open_commit_log,    { desc = "Open commit log" } },
            { "n", "gf",     actions.goto_file,          { desc = "Open file" } },
            { "n", "<C-v>",  actions.goto_file_edit,     { desc = "Open file in new tab" } },
          },
        },
      })
    end,
  },
}
