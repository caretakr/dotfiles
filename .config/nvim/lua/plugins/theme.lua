--
-- Theme config
--

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    version = false, -- blink_cmp integration not exists on last release
    lazy = false,
    priority = 1000,
    opts = function()
      local utils = require("core.utils")

      return {
        -- transparent_background = true,
        integrations = {
          blink_cmp = true,
          dashboard = true,
          fzf = true,
          gitsigns = true,
          grug_far = true,
          lsp_trouble = true,
          markdown = true,
          mini = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "undercurl" },
              hints = { "undercurl" },
              warnings = { "undercurl" },
              information = { "undercurl" },
            },
            inlay_hints = {
              background = true,
            },
          },
          noice = true,
          semantic_tokens = true,
          snacks = true,
          treesitter = true,
          treesitter_context = true,
          which_key = true,
        },
        custom_highlights = function(colors)
          return {
            BlinkCmpDoc = { bg = colors.surface0 },
            BlinkCmpDocBorder = { bg = colors.surface0, fg = colors.surface0 },
            BlinkCmpGhostText = { fg = colors.overlay0 },
            BlinkCmpMenu = { bg = colors.surface0 },
            BlinkCmpMenuBorder = { bg = "none", fg = colors.surface0 },
            BlinkCmpSignatureHelp = { bg = colors.surface0 },
            BlinkCmpSignatureHelpBorder = { bg = "none", fg = colors.surface0 },
            BufferInactive = { bg = "none", fg = colors.overlay0 },
            BufferTabpageFill = { bg = colors.base },
            BufferScrollArrow = { bg = colors.base, fg = colors.text },
            BufferVisible = { bg = "none", fg = colors.overlay0 },
            DiagnosticVirtualTextError = {
              bg = utils.blend(colors.red, colors.base, 0.8),
              style = {},
            },
            DiagnosticVirtualTextInfo = { fg = colors.green, style = {} },
            DiagnosticVirtualTextWarn = {
              bg = utils.blend(colors.yellow, colors.base, 0.8),
              style = {},
            },
            NormalFloat = { bg = "none" },
            SnacksIndent = { fg = colors.surface0 },
            SnacksIndentScope = { fg = colors.overlay0 },
            TreesitterContext = { bg = "none" },
            TreesitterContextLineNumber = { bg = "none" },
            TreesitterContextSeparator = { fg = colors.surface0 },
          }
        end,
      }
    end,
    config = function(_, opts)
      require("catppuccin").setup(opts)

      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
