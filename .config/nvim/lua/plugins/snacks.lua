--
-- Snacks config
--

return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    keys = function()
      local snacks = require("snacks")

      return {
        {
          "<leader><space>",
          function()
            snacks.picker.smart()
          end,
          desc = "Smart Find Files",
        },
        {
          "<leader>,",
          function()
            snacks.picker.buffers()
          end,
          desc = "Buffers",
        },
        {
          "<leader>/",
          function()
            snacks.picker.grep()
          end,
          desc = "Grep",
        },
        {
          "<leader>:",
          function()
            snacks.picker.command_history()
          end,
          desc = "Command History",
        },
        {
          "<leader>n",
          function()
            snacks.picker.notifications()
          end,
          desc = "Notification History",
        },
        {
          "<leader>e",
          function()
            snacks.explorer()
          end,
          desc = "Explorer",
        },
        {
          "<leader>bd",
          function()
            snacks.bufdelete()
          end,
          desc = "Buffer",
        },
        {
          "<leader>bD",
          "<cmd>:bd<cr>",
          desc = "Buffer",
        },
        {
          "<leader>bo",
          function()
            snacks.bufdelete.other()
          end,
          desc = "Buffer (others)",
        },
        {
          "<leader>fb",
          function()
            snacks.picker.buffers()
          end,
          desc = "Buffers",
        },
        {
          "<leader>fc",
          function()
            snacks.picker.files({
              cwd = vim.fn.stdpath("config"),
              hidden = true,
              ignored = true,
            })
          end,
          desc = "Config (files)",
        },
        {
          "<leader>fe",
          function()
            snacks.explorer({
              hidden = true,
              ignored = true,
            })
          end,
          desc = "Explorer",
        },

        {
          "<leader>ff",
          function()
            snacks.picker.files({
              hidden = true,
              ignored = true,
            })
          end,
          desc = "Files",
        },
        {
          "<leader>fg",
          function()
            snacks.picker.git_files()
          end,
          desc = "Git (files)",
        },
        {
          "<leader>fp",
          function()
            snacks.picker.projects()
          end,
          desc = "Projects",
        },
        {
          "<leader>fr",
          function()
            snacks.picker.recent()
          end,
          desc = "Recent (files)",
        },
        {
          "<leader>gb",
          function()
            snacks.picker.git_branches()
          end,
          desc = "Branches",
        },
        {
          "<leader>gd",
          function()
            snacks.picker.git_diff()
          end,
          desc = "Diff (Hunks)",
        },
        {
          "<leader>gf",
          function()
            snacks.picker.git_log_file()
          end,
          desc = "File (log)",
        },
        {
          "<leader>gl",
          function()
            snacks.picker.git_log()
          end,
          desc = "Log",
        },
        {
          "<leader>gL",
          function()
            snacks.picker.git_log_line()
          end,
          desc = "Log (line)",
        },
        {
          "<leader>gs",
          function()
            snacks.picker.git_status()
          end,
          desc = "Status",
        },
        {
          "<leader>gS",
          function()
            snacks.picker.git_stash()
          end,
          desc = "Stash",
        },
        {
          '<leader>s"',
          function()
            snacks.picker.registers()
          end,
          desc = "Registers",
        },
        {
          "<leader>s/",
          function()
            snacks.picker.search_history()
          end,
          desc = "History",
        },
        {
          "<leader>sa",
          function()
            snacks.picker.autocmds()
          end,
          desc = "Autocmds",
        },
        {
          "<leader>sb",
          function()
            snacks.picker.lines()
          end,
          desc = "Buffer (lines)",
        },
        {
          "<leader>sB",
          function()
            snacks.picker.grep_buffers()
          end,
          desc = "Buffers",
        },
        {
          "<leader>sc",
          function()
            snacks.picker.commands()
          end,
          desc = "Commands",
        },
        {
          "<leader>sC",
          function()
            snacks.picker.command_history()
          end,
          desc = "Commands history",
        },
        {
          "<leader>sd",
          function()
            snacks.picker.diagnostics()
          end,
          desc = "Diagnostics",
        },
        {
          "<leader>sD",
          function()
            snacks.picker.diagnostics_buffer()
          end,
          desc = "Diagnostics (buffer)",
        },
        {
          "<leader>sg",
          function()
            snacks.picker.grep()
          end,
          desc = "Grep",
        },
        {
          "<leader>sh",
          function()
            snacks.picker.help()
          end,
          desc = "Help",
        },
        {
          "<leader>sH",
          function()
            snacks.picker.highlights()
          end,
          desc = "Highlights",
        },
        {
          "<leader>si",
          function()
            snacks.picker.icons()
          end,
          desc = "Icons",
        },
        {
          "<leader>sj",
          function()
            snacks.picker.jumps()
          end,
          desc = "Jumps",
        },
        {
          "<leader>sk",
          function()
            snacks.picker.keymaps()
          end,
          desc = "Keymaps",
        },
        {
          "<leader>sl",
          function()
            snacks.picker.loclist()
          end,
          desc = "Location list",
        },
        {
          "<leader>sm",
          function()
            snacks.picker.marks()
          end,
          desc = "Marks",
        },
        {
          "<leader>sM",
          function()
            snacks.picker.man()
          end,
          desc = "Man (pages)",
        },
        {
          "<leader>sp",
          function()
            snacks.picker.lazy()
          end,
          desc = "Plugin",
        },
        {
          "<leader>sq",
          function()
            snacks.picker.qflist()
          end,
          desc = "Quickfix (list)",
        },
        {
          "<leader>sR",
          function()
            snacks.picker.resume()
          end,
          desc = "Resume",
        },
        {
          "<leader>su",
          function()
            snacks.picker.undo()
          end,
          desc = "Undo (history)",
        },
        {
          "<leader>sw",
          function()
            snacks.picker.grep_word()
          end,
          desc = "Word",
          mode = { "n", "x" },
        },
        {
          "<leader>uC",
          function()
            snacks.picker.colorschemes()
          end,
          desc = "Colorschemes",
        },
        {
          "<M-i>",
          function()
            snacks.terminal.toggle()
          end,
          mode = { "n", "t" },
          desc = "Terminal",
        },
        {
          "gd",
          function()
            snacks.picker.lsp_definitions()
          end,
          desc = "Definition",
        },
        {
          "gD",
          function()
            snacks.picker.lsp_declarations()
          end,
          desc = "Declaration",
        },
        {
          "gr",
          function()
            snacks.picker.lsp_references()
          end,
          nowait = true,
          desc = "References",
        },
        {
          "gI",
          function()
            snacks.picker.lsp_implementations()
          end,
          desc = "Implementation",
        },
        {
          "gy",
          function()
            snacks.picker.lsp_type_definitions()
          end,
          desc = "T[y]pe Definition",
        },
        {
          "<leader>ss",
          function()
            snacks.picker.lsp_symbols()
          end,
          desc = "Symbols",
        },
        {
          "<leader>sS",
          function()
            snacks.picker.lsp_workspace_symbols()
          end,
          desc = "Symbols (workspace)",
        },
      }
    end,
    opts = {
      bigfile = {
        enabled = true,
      },
      dim = {
        enabled = true,
      },
      dashboard = {
        sections = {
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
        },
      },
      explorer = {
        enabled = true,
      },
      indent = {
        animate = {
          enabled = false,
        },
        chunk = {
          -- enabled = true,
          char = {
            corner_top = "╭",
            corner_bottom = "╰",
          },
        },
      },
      picker = {
        prompt = "  ",
        layouts = {
          telescope = {
            reverse = false,
            layout = {
              box = "horizontal",
              width = 0.8,
              min_width = 120,
              height = 0.75,
              {
                box = "vertical",
                border = "rounded",
                title = "{title} {live} {flags}",
                { win = "input", height = 1, border = "bottom" },
                { win = "list", border = "none" },
              },
              { win = "preview", title = "{preview}", border = "rounded", width = 0.6 },
            },
          },
        },
        layout = "telescope",
        sources = {
          explorer = {
            auto_close = true,
            layout = "telescope",
          },
        },
      },
      input = {
        enabled = true,
      },
      notifier = {
        enabled = true,
        top_down = false,
        margin = {
          bottom = 1,
          right = 2,
        },
      },
      scope = {
        enabled = true,
      },
      scroll = {
        enabled = true,
      },
      statuscolumn = {
        enabled = false, -- we set this in options.lua
      },
      terminal = {
        enabled = true,
        {
          win = { style = "terminal" },
        },
      },
      toggle = {
        enabled = true,
      },
      win = {
        backdrop = false,
      },
      words = {
        enabled = true,
      },
    },
    init = function()
      ---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
      local progress = vim.defaulttable()
      vim.api.nvim_create_autocmd("LspProgress", {
        ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
        callback = function(ev)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
          if not client or type(value) ~= "table" then
            return
          end
          local p = progress[client.id]

          for i = 1, #p + 1 do
            if i == #p + 1 or p[i].token == ev.data.params.token then
              p[i] = {
                token = ev.data.params.token,
                msg = ("[%3d%%] %s%s"):format(
                  value.kind == "end" and 100 or value.percentage or 100,
                  value.title or "",
                  value.message and (" **%s**"):format(value.message) or ""
                ),
                done = value.kind == "end",
              }
              break
            end
          end

          local msg = {} ---@type string[]
          progress[client.id] = vim.tbl_filter(function(v)
            return table.insert(msg, v.msg) or not v.done
          end, p)

          local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
          vim.notify(table.concat(msg, "\n"), "info", {
            id = "lsp_progress",
            title = client.name,
            opts = function(notif)
              notif.icon = #progress[client.id] == 0 and " "
                or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
            end,
          })
        end,
      })
    end,
  },
}
