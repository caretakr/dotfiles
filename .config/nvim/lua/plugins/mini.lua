--
-- Mini config
--

return {
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    dependencies = {
      "echasnovski/mini.extra",
    },
    opts = function()
      local ai = require("mini.ai")
      local extra = require("mini.extra")

      return {
        n_lines = 1000,
        custom_textobjects = {
          c = ai.gen_spec.treesitter({ -- Class
            a = "@class.outer",
            i = "@class.inner",
          }),
          d = extra.gen_ai_spec.number(), -- Digits
          e = { -- Word (with case)
            {
              "%u[%l%d]+%f[^%l%d]",
              "%f[%S][%l%d]+%f[^%l%d]",
              "%f[%P][%l%d]+%f[^%l%d]",
              "^[%l%d]+%f[^%l%d]",
            },
            "^().*()$",
          },
          f = ai.gen_spec.treesitter({ -- Function
            a = "@function.outer",
            i = "@function.inner",
          }),
          g = extra.gen_ai_spec.buffer(), -- Buffer
          i = extra.gen_ai_spec.indent(), -- Indent
          o = ai.gen_spec.treesitter({ -- Code block
            a = {
              "@block.outer",
              "@conditional.outer",
              "@loop.outer",
            },
            i = {
              "@block.inner",
              "@conditional.inner",
              "@loop.inner",
            },
          }),
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
        },
      }
    end,
    config = function(_, opts)
      local utils = require("core.utils")

      require("mini.ai").setup(opts)

      utils.on_load("which-key.nvim", function()
        vim.schedule(function()
          local objects = {
            { " ", desc = "whitespace" },
            { '"', desc = '" string' },
            { "'", desc = "' string" },
            { "(", desc = "() block" },
            { ")", desc = "() block with ws" },
            { "<", desc = "<> block" },
            { ">", desc = "<> block with ws" },
            { "?", desc = "user prompt" },
            { "U", desc = "use/call without dot" },
            { "[", desc = "[] block" },
            { "]", desc = "[] block with ws" },
            { "_", desc = "underscore" },
            { "`", desc = "` string" },
            { "a", desc = "argument" },
            { "b", desc = ")]} block" },
            { "c", desc = "class" },
            { "d", desc = "digit(s)" },
            { "e", desc = "CamelCase / snake_case" },
            { "f", desc = "function" },
            { "g", desc = "entire file" },
            { "i", desc = "indent" },
            { "o", desc = "block, conditional, loop" },
            { "q", desc = "quote `\"'" },
            { "t", desc = "tag" },
            { "u", desc = "use/call" },
            { "{", desc = "{} block" },
            { "}", desc = "{} with ws" },
          }

          local ret = { mode = { "o", "x" } }

          ---@type table<string, string>
          local mappings = vim.tbl_extend("force", {}, {
            around = "a",
            inside = "i",
            around_next = "an",
            inside_next = "in",
            around_last = "al",
            inside_last = "il",
          }, opts.mappings or {})

          mappings.goto_left = nil
          mappings.goto_right = nil

          for name, prefix in pairs(mappings) do
            name = name:gsub("^around_", ""):gsub("^inside_", "")
            ret[#ret + 1] = { prefix, group = name }

            for _, obj in ipairs(objects) do
              local desc = obj.desc

              if prefix:sub(1, 1) == "i" then
                desc = desc:gsub(" with ws", "")
              end

              ret[#ret + 1] = { prefix .. obj[1], desc = obj.desc }
            end
          end

          require("which-key").add(ret, {
            notify = false,
          })
        end)
      end)
    end,
  },
  {
    "echasnovski/mini.icons",
    lazy = true,
    opts = {
      file = {
        [".eslintrc.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
        [".node-version"] = { glyph = "", hl = "MiniIconsGreen" },
        [".prettierrc"] = { glyph = "", hl = "MiniIconsPurple" },
        [".yarnrc.yml"] = { glyph = "", hl = "MiniIconsBlue" },
        ["eslint.config.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
        ["package.json"] = { glyph = "", hl = "MiniIconsGreen" },
        ["tsconfig.json"] = { glyph = "", hl = "MiniIconsAzure" },
        ["tsconfig.build.json"] = { glyph = "", hl = "MiniIconsAzure" },
        ["yarn.lock"] = { glyph = "", hl = "MiniIconsBlue" },
      },
    },
    config = function(_, opts)
      require("mini.icons").setup(opts)

      -- Mimic `nvim-web-devicons`
      MiniIcons.mock_nvim_web_devicons()
    end,
  },
  {
    "echasnovski/mini.move",
    event = "VeryLazy",
    keys = function(_, keys)
      local utils = require("core.utils")
      local opts = utils.get_opts("mini.move")

      local mappings = {
        { opts.mappings.left, desc = "Move selection (left)", mode = { "v" } },
        { opts.mappings.right, desc = "Move selection (right)", mode = "v" },
        { opts.mappings.down, desc = "Move selection (down)", mode = "v" },
        { opts.mappings.up, desc = "Move selection (up)", mode = "v" },
        { opts.mappings.line_left, desc = "Move line (left)", mode = "n" },
        { opts.mappings.line_right, desc = "Move line (right)", mode = "n" },
        { opts.mappings.line_down, desc = "Move line (down)", mode = "n" },
        { opts.mappings.line_up, desc = "Move line (up)", mode = "n" },
      }

      mappings = vim.tbl_filter(function(m)
        return m[1] and #m[1] > 0
      end, mappings)

      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = {
        -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
        left = "<S-h>",
        right = "<S-l>",
        down = "<S-j>",
        up = "<S-k>",

        -- Move current line in Normal mode
        line_left = "<S-h>",
        line_right = "<S-l>",
        line_down = "<S-j>",
        line_up = "<S-k>",
      },
    },
  },
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {
      modes = {
        insert = true,
        command = true,
        terminal = false,
      },
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=], -- skip autopair when next character is one of these
      skip_ts = { "string" }, -- skip autopair when the cursor is inside these treesitter nodes
      skip_unbalanced = true, -- skip autopair when next character closes with more closings
      markdown = true, -- better deal with markdown code blocks
    },
  },
  {
    "echasnovski/mini.surround",
    keys = function(_, keys)
      local utils = require("core.utils")
      local opts = utils.get_opts("mini.surround")

      local mappings = {
        { opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
        { opts.mappings.delete, desc = "Delete surrounding" },
        { opts.mappings.find, desc = "Find right rurrounding" },
        { opts.mappings.find_left, desc = "Find left surrounding" },
        { opts.mappings.highlight, desc = "Highlight surrounding" },
        { opts.mappings.replace, desc = "Replace surrounding" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      }

      mappings = vim.tbl_filter(function(m)
        return m[1] and #m[1] > 0
      end, mappings)

      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = {
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "gsr", -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
    },
  },
}
