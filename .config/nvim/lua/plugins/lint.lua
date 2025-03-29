--
-- Lint config
--

return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    opts = {
      events = { "BufWritePost", "BufReadPost", "InsertLeave" },
      linters_by_ft = {
        c = { "cppcheck" },
        css = { "stylelint" },
        cpp = { "cppcheck" },
        go = { "golangcilint" },
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        lua = { "luacheck" },
        python = { "ruff" },
        scss = { "stylelint" },
        sh = { "shellcheck" },
        terraform = { "terraform_validate" },
        tf = { "terraform_validate" },
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        yaml = { "yamllint" },
        ["yaml.action"] = { "actionlint" },
        ["yaml.ansible"] = { "ansible_lint" },
        ["*"] = { "editorconfig-checker" },
      },
      linters = {
        stylelint = {
          enabled = function(ctx)
            local files = {
              ".stylelintrc.js",
              ".stylelintrc.cjs",
              ".stylelintrc.yaml",
              ".stylelintrc.yml",
              ".stylelintrc.json",
              "package.json",
            }

            for _, file in ipairs(files) do
              local found = vim.fs.find({ file }, { path = ctx.dirname, upward = true })[1]

              if found and #found > 0 then
                if file == "package.json" then
                  local content = vim.fn.json_decode(vim.fn.readfile(found))

                  if content.stylelintConfig then
                    return true
                  end
                else
                  return true
                end
              end
            end

            return false
          end,
        },
      },
    },
    config = function(_, opts)
      local lint = require("lint")

      local M = {}

      for name, linter in pairs(opts.linters or {}) do
        if type(linter) == "table" and type(lint.linters[name]) == "table" then
          lint.linters[name] = vim.tbl_deep_extend("force", lint.linters[name], linter)

          if type(linter.prepend_args) == "table" then
            lint.linters[name].args = lint.linters[name].args or {}
            vim.list_extend(lint.linters[name].args, linter.prepend_args)
          end
        else
          lint.linters[name] = linter
        end
      end

      lint.linters_by_ft = opts.linters_by_ft

      function M.debounce(ms, fn)
        local timer = vim.uv.new_timer()

        return function(...)
          local argv = { ... }

          timer:start(ms, 0, function()
            timer:stop()
            vim.schedule_wrap(fn)(unpack(argv))
          end)
        end
      end

      function M.lint()
        -- Use nvim-lint's logic first:
        -- * checks if linters exist for the full filetype first
        -- * otherwise will split filetype by "." and add all those linters
        -- * this differs from conform.nvim which only uses the first filetype that has a formatter
        local names = lint._resolve_linter_by_ft(vim.bo.filetype)

        -- Create a copy of the names table to avoid modifying the original.
        names = vim.list_extend({}, names)

        -- Add fallback linters.
        if #names == 0 then
          vim.list_extend(names, lint.linters_by_ft["_"] or {})
        end

        -- Add global linters.
        vim.list_extend(names, lint.linters_by_ft["*"] or {})

        -- Filter out linters that don't exist or don't match the enabled.
        local ctx = { filename = vim.api.nvim_buf_get_name(0) }

        ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")

        names = vim.tbl_filter(function(name)
          local linter = lint.linters[name]

          if not linter then
            vim.notify("Linter not found: " .. name, { title = "nvim-lint" })
          end

          return linter and not (type(linter) == "table" and linter.enabled and not linter.enabled(ctx))
        end, names)

        -- Run linters.
        if #names > 0 then
          lint.try_lint(names)
        end
      end

      vim.api.nvim_create_autocmd(opts.events, {
        group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
        callback = M.debounce(100, M.lint),
      })
    end,
  },
}
