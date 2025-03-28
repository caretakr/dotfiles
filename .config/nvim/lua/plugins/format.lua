--
-- Format config
--

return {
  {
    "stevearc/conform.nvim",
    cmd = "ConformInfo",
    keys = function()
      local conform = require("conform")

      return {
        {
          "<leader>cF",
          function()
            conform.format({
              formatters = {
                "injected",
              },
              timeout_ms = 5000,
            })
          end,
          mode = { "n", "v" },
          desc = "Format injected languages",
        },
      }
    end,
    opts = {
      formatters_by_ft = {
        c = { "clang-format" },
        cpp = { "clang-format" },
        css = { "prettierd" },
        dockerfile = { lsp_format = "never" },
        go = { "goimports", "gofumpt" },
        graphql = { "prettierd" },
        handlebars = { "prettierd" },
        html = { "prettierd" },
        htmlangular = { "prettierd" },
        javascript = { "prettierd" },
        javascriptreact = { "prettierd" },
        json = { "prettierd" },
        jsonc = { "prettierd" },
        lua = { "stylua" },
        markdown = { "prettierd" },
        python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
        rust = { "rustfmt" },
        scss = { "prettierd" },
        sh = { lsp_format = "never" },
        terraform = { "terraform_fmt" },
        ["terraform-vars"] = { "terraform_fmt" },
        tf = { "terraform_fmt" },
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
        vue = { "prettierd" },
        yaml = { "prettierd" },
      },
      format_on_save = {
        timeout_ms = 5000,
      },
      formatters = {
        injected = {
          options = {
            ignore_errors = true,
          },
        },
      },
    },
  },
}
