--
-- Treesitter config
--

return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufWritePost", "BufNewFile", "VeryLazy" },
    build = ":TSUpdate",
    cmd = { "TSInstall", "TSUpdate", "TSUpdateSync" },
    keys = function(_, keys)
      local utils = require("core.utils")
      local opts = utils.get_opts("nvim-treesitter")

      local mappings = {
        {
          opts.incremental_selection.node_incremental,
          desc = "Increment selection",
        },
        {
          opts.incremental_selection.node_decremental,
          desc = "Decrement selection",
          mode = "x",
        },
      }

      mappings = vim.tbl_filter(function(m)
        return m[1] and #m[1] > 0
      end, mappings)

      return vim.list_extend(mappings, keys)
    end,
    opts = function(_, opts)
      return {
        ensure_installed = {
          "bash",
          "comment",
          "c",
          "cpp",
          "css",
          "csv",
          "diff",
          "dockerfile",
          "go",
          "gomod",
          "gosum",
          "gowork",
          "hcl",
          "html",
          "ini",
          "javascript",
          "jq",
          "jsdoc",
          "json",
          "json5",
          "jsonc",
          "lua",
          "luadoc",
          "markdown",
          "markdown_inline",
          "ninja",
          "printf",
          "proto",
          "python",
          "query",
          "regex",
          "ron",
          "rst",
          "rust",
          "scss",
          "terraform",
          "textproto",
          "toml",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "xml",
          "yaml",
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
        textobjects = {
          move = {
            enable = true,
            goto_next_start = {
              ["]f"] = "@function.outer",
              ["]c"] = "@class.outer",
              ["]a"] = "@parameter.inner",
            },
            goto_next_end = {
              ["]F"] = "@function.outer",
              ["]C"] = "@class.outer",
              ["]A"] = "@parameter.inner",
            },
            goto_previous_start = {
              ["[f"] = "@function.outer",
              ["[c"] = "@class.outer",
              ["[a"] = "@parameter.inner",
            },
            goto_previous_end = {
              ["[F"] = "@function.outer",
              ["[C"] = "@class.outer",
              ["[A"] = "@parameter.inner",
            },
          },
        },
      }
    end,
    config = function(_, opts)
      local utils = require("core.utils")

      if type(opts.ensure_installed) == "table" then
        opts.ensure_installed = utils.dedup(opts.ensure_installed)
      end

      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      max_lines = 4,
      separator = "─",
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "VeryLazy",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      local utils = require("core.utils")

      if utils.is_loaded("nvim-treesitter") then
        local opts = utils.get_opts("nvim-treesitter")

        require("nvim-treesitter.configs").setup({
          textobjects = opts.textobjects,
        })
      end

      -- When in diff mode, we want to use the default
      -- vim text objects c & C instead of the treesitter ones.
      ---@type table<string,fun(...)>
      local move = require("nvim-treesitter.textobjects.move")
      local configs = require("nvim-treesitter.configs")

      for name, fn in pairs(move) do
        if name:find("goto") == 1 then
          move[name] = function(q, ...)
            if vim.wo.diff then
              ---@type table<string,string>
              local config = configs.get_module("textobjects.move")[name]

              for key, query in pairs(config or {}) do
                if q == query and key:find("[%]%[][cC]") then
                  vim.cmd("normal! " .. key)

                  return
                end
              end
            end

            return fn(q, ...)
          end
        end
      end
    end,
  },
  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
  },
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
  },
}
