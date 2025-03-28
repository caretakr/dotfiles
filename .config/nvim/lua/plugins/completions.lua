--
-- Completions config
--

return {
  {
    "saghen/blink.cmp",
    event = "InsertEnter",
    dependencies = {
      "echasnovski/mini.icons",
      "rafamadriz/friendly-snippets",
    },
    opts = function()
      local mini_icons = require("mini.icons")

      return {
        appearance = {
          nerd_font_variant = "mono",
          use_nvim_cmp_as_default = true,
        },
        cmdline = {
          enabled = false,
        },
        completion = {
          accept = {
            auto_brackets = {
              enabled = true,
            },
          },
          documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
            window = {
              -- border = { "▄", "▄", "▄", "█", "▀", "▀", "▀", "█" },
            },
          },
          ghost_text = {
            enabled = true,
          },
          menu = {
            -- border = { "▄", "▄", "▄", "█", "▀", "▀", "▀", "█" },
            draw = {
              components = {
                kind_icon = {
                  ellipsis = false,
                  text = function(ctx)
                    local kind_icon, _, _ = mini_icons.get("lsp", ctx.kind)

                    return kind_icon
                  end,
                  highlight = function(ctx)
                    local _, hl, _ = mini_icons.get("lsp", ctx.kind)

                    return hl
                  end,
                },
              },
              treesitter = { "lsp" },
            },
          },
        },
        keymap = {
          preset = "enter",
          ["<C-y>"] = { "select_and_accept" },
        },

        -- Experimental signature help support
        -- signature = {
        --   enabled = true,
        --   window = {
        --     -- border = { "▄", "▄", "▄", "█", "▀", "▀", "▀", "█" },
        --   },
        -- },

        sources = {
          default = {
            "lsp",
            "path",
            "snippets",
            "buffer",
          },
          compat = {
            -- Use nvim-cmp sources with blink.compat
          },
        },
      }
    end,
    config = function(_, opts)
      local enabled = opts.sources.default

      -- Setup compat sources
      for _, source in ipairs(opts.sources.compat or {}) do
        opts.sources.providers[source] = vim.tbl_deep_extend(
          "force",
          { name = source, module = "blink.compat.source" },
          opts.sources.providers[source] or {}
        )

        if type(enabled) == "table" and not vim.tbl_contains(enabled, source) then
          table.insert(enabled, source)
        end
      end

      -- Unset custom prop to pass blink.cmp validation
      opts.sources.compat = nil

      require("blink.cmp").setup(opts)
    end,
  },
}
