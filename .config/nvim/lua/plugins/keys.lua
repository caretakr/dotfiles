--
-- Keys config
--

return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = function()
      local extras = require("which-key.extras")

      return {
        icons = {
          separator = "",
        },
        preset = "modern",
        spec = {
          {
            mode = { "n", "v" },
            { "<leader><tab>", group = "tabs" },
            { "<leader>c", group = "code" },
            { "<leader>f", group = "file/find" },
            { "<leader>g", group = "git" },
            { "<leader>gh", group = "hunks" },
            { "<leader>q", group = "quit/session" },
            { "<leader>s", group = "search" },
            { "<leader>sn", group = "noice" },
            { "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
            { "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
            { "[", group = "prev" },
            { "]", group = "next" },
            { "g", group = "goto" },
            { "gs", group = "surround" },
            { "z", group = "fold" },
            {
              "<leader>b",
              group = "buffer",
              expand = function()
                return extras.expand.buf()
              end,
            },
            {
              "<leader>w",
              group = "windows",
              proxy = "<c-w>",
              expand = function()
                return extras.expand.win()
              end,
            },
            { "gx", desc = "Open with system app" },
          },
        },
        win = {
          width = 0.8,
          row = -2,
        },
      }
    end,
    keys = function()
      local which_key = require("which-key")

      return {
        {
          "<leader>?",
          function()
            which_key.show({
              global = false,
            })
          end,
          desc = "Local keymaps",
        },
      }
    end,
  },
}
