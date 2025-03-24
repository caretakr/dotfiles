--
-- Lines config
--

return {
  {
    "romgrk/barbar.nvim",
    event = "VeryLazy",
    dependencies = {
      "lewis6991/gitsigns.nvim",
      "echasnovski/mini.icons",
    },
    keys = {
      { "<leader>bp", "<Cmd>BufferPin<CR>", desc = "Toggle Pin" },
      { "<leader>bP", "<Cmd>BufferCloseAllButCurrentOrPinned<CR>", desc = "Delete Non-Pinned Buffers" },
      { "<leader>br", "<Cmd>BufferCloseBuffersRight<CR>", desc = "Delete Buffers to the Right" },
      { "<leader>bl", "<Cmd>BufferCloseBuffersLeft<CR>", desc = "Delete Buffers to the Left" },
      { "<S-h>", "<cmd>BufferPrevious<cr>", desc = "Prev Buffer" },
      { "<S-l>", "<cmd>BufferNext<cr>", desc = "Next Buffer" },
      { "[b", "<cmd>BufferPrevious<cr>", desc = "Prev Buffer" },
      { "]b", "<cmd>BufferNext<cr>", desc = "Next Buffer" },
      { "[B", "<cmd>BufferMovePrevious<cr>", desc = "Move buffer prev" },
      { "]B", "<cmd>BufferMoveNext<cr>", desc = "Move buffer next" },
    },
    opts = {
      maximum_padding = 0,
      minimum_padding = 2,
      icons = {
        separator = { left = "", right = "" },
        separator_at_end = false,
        inactive = {
          separator = {
            left = "", -- Disable separators for good
          },
        },
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
      "echasnovski/mini.icons",
    },
    opts = function()
      local icons = require("core.icons")
      local lualine_require = require("lualine_require")

      -- PERF: Disable lualine custom require
      lualine_require.require = require

      return {
        options = {
          component_separators = { left = "", right = "" },
          globalstatus = true,
          theme = function()
            local colors = require("catppuccin.palettes").get_palette("mocha")

            return {
              normal = {
                a = { bg = colors.blue, fg = colors.mantle, gui = "bold" },
                b = { bg = colors.surface0, fg = colors.blue },
                c = { bg = colors.base, fg = colors.text },
              },

              insert = {
                a = { bg = colors.green, fg = colors.base, gui = "bold" },
                b = { bg = colors.surface0, fg = colors.green },
              },

              terminal = {
                a = { bg = colors.green, fg = colors.base, gui = "bold" },
                b = { bg = colors.surface0, fg = colors.green },
              },

              command = {
                a = { bg = colors.peach, fg = colors.base, gui = "bold" },
                b = { bg = colors.surface0, fg = colors.peach },
              },
              visual = {
                a = { bg = colors.mauve, fg = colors.base, gui = "bold" },
                b = { bg = colors.surface0, fg = colors.mauve },
              },
              replace = {
                a = { bg = colors.red, fg = colors.base, gui = "bold" },
                b = { bg = colors.surface0, fg = colors.red },
              },
              inactive = {
                a = { bg = colors.base, fg = colors.blue },
                b = { bg = colors.base, fg = colors.surface1, gui = "bold" },
                c = { bg = colors.base, fg = colors.overlay0 },
              },
            }
          end,
        },
        sections = {
          lualine_b = { "branch", "diff" },
          lualine_c = {
            {
              "windows",
              cond = function()
                local bufname = vim.api.nvim_buf_get_name(0)
                local filetype = vim.bo.filetype

                local filetypes = {
                  "NvimTree",
                  "Avante",
                  "AvanteOutline",
                  "AvantePreview",
                }

                return not vim.tbl_contains(filetypes, filetype) and bufname ~= ""
              end,
              disabled_buftypes = { "quickfix", "prompt", "nofile" },
              show_filename_only = false,
            },
            "searchcount",
            "selectioncount",
            "command",
          },
          lualine_x = {
            "copilot",
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
          },
        },
        inactive_sections = {
          lualine_b = { "branch", "diff" },
          lualine_c = {},
          lualine_x = {
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
          },
        },
        extensions = {
          "fzf",
          "lazy",
          "trouble",
        },
      }
    end,
  },
}
