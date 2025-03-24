--
-- Languages config
--

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    dependencies = {
      {
        "b0o/SchemaStore.nvim",
        version = false,
      },
    },
    opts = function()
      local utils = require("core.utils")
      local lspconfig_util = require("lspconfig.util")

      return {
        diagnostics = {
          underline = true,
          update_in_insert = false,
          virtual_text = {
            spacing = 1,
            source = "if_many",
            prefix = "",
          },
          severity_sort = true,
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = require("core.icons").diagnostics.Error,
              [vim.diagnostic.severity.WARN] = require("core.icons").diagnostics.Warn,
              [vim.diagnostic.severity.HINT] = require("core.icons").diagnostics.Hint,
              [vim.diagnostic.severity.INFO] = require("core.icons").diagnostics.Info,
            },
          },
        },
        inlay_hints = {
          enabled = true,
        },
        codelens = {
          enabled = true,
        },
        capabilities = {
          workspace = {
            fileOperations = {
              didRename = true,
              willRename = true,
            },
          },
        },
        servers = {
          ansiblels = {},
          bashls = {},
          clangd = {
            keys = {
              {
                "<leader>ch",
                "<cmd>ClangdSwitchSourceHeader<cr>",
                desc = "Switch Source/Header (C/C++)",
              },
            },
            root_dir = function(fname)
              return lspconfig_util.root_pattern(
                "Makefile",
                "configure.ac",
                "configure.in",
                "config.h.in",
                "meson.build",
                "meson_options.txt",
                "build.ninja"
              )(fname) or lspconfig_util.root_pattern("compile_commands.json", "compile_flags.txt")(fname) or lspconfig_util.find_git_ancestor(
                fname
              )
            end,
            capabilities = {
              offsetEncoding = { "utf-16" },
            },
            cmd = {
              "clangd",
              "--background-index",
              "--clang-tidy",
              "--header-insertion=iwyu",
              "--completion-style=detailed",
              "--function-arg-placeholders",
              "--fallback-style=llvm",
            },
            init_options = {
              usePlaceholders = true,
              completeUnimported = true,
              clangdFileStatus = true,
            },
          },
          cssls = {},
          dockerls = {},
          gopls = {
            settings = {
              gopls = {
                gofumpt = true,
                codelenses = {
                  gc_details = false,
                  generate = true,
                  regenerate_cgo = true,
                  run_govulncheck = true,
                  test = true,
                  tidy = true,
                  upgrade_dependency = true,
                  vendor = true,
                },
                hints = {
                  assignVariableTypes = true,
                  compositeLiteralFields = true,
                  compositeLiteralTypes = true,
                  constantValues = true,
                  functionTypeParameters = true,
                  parameterNames = true,
                  rangeVariableTypes = true,
                },
                analyses = {
                  fieldalignment = true,
                  nilness = true,
                  unusedparams = true,
                  unusedwrite = true,
                  useany = true,
                },
                usePlaceholders = true,
                completeUnimported = true,
                staticcheck = true,
                directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
                semanticTokens = true,
              },
            },
          },
          html = {},
          jsonls = {
            -- Lazy-load schemastore when needed
            on_new_config = function(new_config)
              new_config.settings.json.schemas = new_config.settings.json.schemas or {}
              vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
            end,
            settings = {
              json = {
                format = {
                  enable = true,
                },
                validate = { enable = true },
              },
            },
          },
          lua_ls = {
            settings = {
              Lua = {
                workspace = {
                  checkThirdParty = false,
                },
                codeLens = {
                  enable = true,
                },
                completion = {
                  callSnippet = "Replace",
                },
                doc = {
                  privateName = { "^_" },
                },
                hint = {
                  enable = true,
                  setType = false,
                  paramType = true,
                  paramName = "Disable",
                  semicolon = "Disable",
                  arrayIndex = "Disable",
                },
              },
            },
          },
          pyright = {},
          ruff = {
            cmd_env = { RUFF_TRACE = "messages" },
            init_options = {
              settings = {
                logLevel = "error",
              },
            },
            keys = {
              {
                "<leader>co",
                utils.lsp.action["source.organizeImports"],
                desc = "Organize Imports",
              },
            },
          },
          rust_analyzer = {},
          terraformls = {},
          vtsls = {
            settings = {
              complete_function_calls = true,
              vtsls = {
                enableMoveToFileCodeAction = true,
                autoUseWorkspaceTsdk = true,
                experimental = {
                  maxInlayHintLength = 30,
                  completion = {
                    enableServerSideFuzzyMatch = true,
                  },
                },
              },
              typescript = {
                updateImportsOnFileMove = { enabled = "always" },
                suggest = {
                  completeFunctionCalls = true,
                },
                inlayHints = {
                  enumMemberValues = { enabled = true },
                  functionLikeReturnTypes = { enabled = true },
                  parameterNames = { enabled = "literals" },
                  parameterTypes = { enabled = true },
                  propertyDeclarationTypes = { enabled = true },
                  variableTypes = { enabled = false },
                },
              },
            },
            keys = {
              {
                "gD",
                function()
                  local params = vim.lsp.util.make_position_params()

                  utils.lsp.execute({
                    command = "typescript.goToSourceDefinition",
                    arguments = { params.textDocument.uri, params.position },
                    open = true,
                  })
                end,
                desc = "Goto Source Definition",
              },
              {
                "gR",
                function()
                  utils.lsp.execute({
                    command = "typescript.findAllFileReferences",
                    arguments = { vim.uri_from_bufnr(0) },
                    open = true,
                  })
                end,
                desc = "File References",
              },
              {
                "<leader>co",
                utils.lsp.action["source.organizeImports"],
                desc = "Organize Imports",
              },
              {
                "<leader>cM",
                utils.lsp.action["source.addMissingImports.ts"],
                desc = "Add missing imports",
              },
              {
                "<leader>cu",
                utils.lsp.action["source.removeUnused.ts"],
                desc = "Remove unused imports",
              },
              {
                "<leader>cD",
                utils.lsp.action["source.fixAll.ts"],
                desc = "Fix all diagnostics",
              },
              {
                "<leader>cV",
                function()
                  utils.lsp.execute({ command = "typescript.selectTypeScriptVersion" })
                end,
                desc = "Select TS workspace version",
              },
            },
          },
          yamlls = {
            capabilities = {
              textDocument = {
                foldingRange = {
                  dynamicRegistration = false,
                  lineFoldingOnly = true,
                },
              },
            },
            -- Lazy-load schemastore when needed
            on_new_config = function(new_config)
              new_config.settings.yaml.schemas = vim.tbl_deep_extend(
                "force",
                new_config.settings.yaml.schemas or {},
                require("schemastore").yaml.schemas()
              )
            end,
            settings = {
              redhat = { telemetry = { enabled = false } },
              yaml = {
                keyOrdering = false,
                format = {
                  enable = true,
                },
                validate = true,
                schemaStore = {
                  -- Must disable built-in schemaStore support to use
                  -- schemas from SchemaStore.nvim plugin
                  enable = false,
                  -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                  url = "",
                },
              },
            },
          },
        },
        setup = {
          gopls = function()
            -- HACK: workaround for gopls not supporting semanticTokensProvider
            -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
            utils.lsp.on_attach(function(client)
              if not client.server_capabilities.semanticTokensProvider then
                local semantic = client.config.capabilities.textDocument.semanticTokens

                client.server_capabilities.semanticTokensProvider = {
                  full = true,
                  legend = {
                    tokenTypes = semantic.tokenTypes,
                    tokenModifiers = semantic.tokenModifiers,
                  },
                  range = true,
                }
              end
            end, "gopls")
            -- end HACK
          end,
          ruff = function()
            utils.lsp.on_attach(function(client, _)
              -- Disable hover in favor of Pyright
              client.server_capabilities.hoverProvider = false
            end, "ruff")
          end,
          vtsls = function(_, opts)
            utils.lsp.on_attach(function(client)
              client.commands["_typescript.moveToFileRefactoring"] = function(command)
                local action, uri, range = unpack(command.arguments)

                local function move(newf)
                  client.request("workspace/executeCommand", {
                    command = command.command,
                    arguments = { action, uri, range, newf },
                  })
                end

                local fname = vim.uri_to_fname(uri)

                client.request("workspace/executeCommand", {
                  command = "typescript.tsserverRequest",
                  arguments = {
                    "getMoveToRefactoringFileSuggestions",
                    {
                      file = fname,
                      startLine = range.start.line + 1,
                      startOffset = range.start.character + 1,
                      endLine = range["end"].line + 1,
                      endOffset = range["end"].character + 1,
                    },
                  },
                }, function(_, result)
                  local files = result.body.files

                  table.insert(files, 1, "Enter new path...")

                  vim.ui.select(files, {
                    prompt = "Select move destination:",
                    format_item = function(f)
                      return vim.fn.fnamemodify(f, ":~:.")
                    end,
                  }, function(f)
                    if f and f:find("^Enter new path") then
                      vim.ui.input({
                        prompt = "Enter move destination:",
                        default = vim.fn.fnamemodify(fname, ":h") .. "/",
                        completion = "file",
                      }, function(newf)
                        return newf and move(newf)
                      end)
                    elseif f then
                      move(f)
                    end
                  end)
                end)
              end
            end, "vtsls")

            opts.settings.javascript =
              vim.tbl_deep_extend("force", {}, opts.settings.typescript, opts.settings.javascript or {})
          end,
          yamlls = function()
            utils.lsp.on_attach(function(client, _)
              client.server_capabilities.documentFormattingProvider = true
            end, "yamlls")
          end,
        },
      }
    end,
    config = function(_, opts)
      local lspconfig = require("lspconfig")
      local snacks = require("snacks")
      local utils = require("core.utils")

      local keymaps = {
        {
          "<leader>cl",
          function()
            snacks.picker.lsp_config()
          end,
          desc = "Lsp Info",
        },
        { "gd", vim.lsp.buf.definition, desc = "Goto Definition", has = "definition" },
        { "gr", vim.lsp.buf.references, desc = "References", nowait = true },
        { "gI", vim.lsp.buf.implementation, desc = "Goto Implementation" },
        { "gy", vim.lsp.buf.type_definition, desc = "Goto T[y]pe Definition" },
        { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
        {
          "K",
          function()
            return vim.lsp.buf.hover()
          end,
          desc = "Hover",
        },
        {
          "gK",
          function()
            return vim.lsp.buf.signature_help()
          end,
          desc = "Signature Help",
          has = "signatureHelp",
        },
        {
          "<c-k>",
          function()
            return vim.lsp.buf.signature_help()
          end,
          mode = "i",
          desc = "Signature Help",
          has = "signatureHelp",
        },
        { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
        { "<leader>cc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v" }, has = "codeLens" },
        {
          "<leader>cC",
          vim.lsp.codelens.refresh,
          desc = "Refresh & Display Codelens",
          mode = { "n" },
          has = "codeLens",
        },
        {
          "<leader>cR",
          function()
            snacks.rename.rename_file()
          end,
          desc = "Rename File",
          mode = { "n" },
          has = { "workspace/didRenameFiles", "workspace/willRenameFiles" },
        },
        { "<leader>cr", vim.lsp.buf.rename, desc = "Rename", has = "rename" },
        { "<leader>cA", utils.lsp.action.source, desc = "Source Action", has = "codeAction" },
        {
          "]]",
          function()
            snacks.words.jump(vim.v.count1)
          end,
          has = "documentHighlight",
          desc = "Next Reference",
          cond = function()
            return snacks.words.is_enabled()
          end,
        },
        {
          "[[",
          function()
            snacks.words.jump(-vim.v.count1)
          end,
          has = "documentHighlight",
          desc = "Prev Reference",
          cond = function()
            return snacks.words.is_enabled()
          end,
        },
        {
          "<a-n>",
          function()
            snacks.words.jump(vim.v.count1, true)
          end,
          has = "documentHighlight",
          desc = "Next Reference",
          cond = function()
            return snacks.words.is_enabled()
          end,
        },
        {
          "<a-p>",
          function()
            snacks.words.jump(-vim.v.count1, true)
          end,
          has = "documentHighlight",
          desc = "Prev Reference",
          cond = function()
            return snacks.words.is_enabled()
          end,
        },
      }

      -- Rounded borders for LspInfo
      require("lspconfig.ui.windows").default_options.border = "rounded"

      utils.lsp.on_attach(function(client, buffer)
        utils.lsp.keymaps.on_attach(keymaps, client, buffer)
      end)

      utils.lsp.setup()

      utils.lsp.on_dynamic_capability(function(client, buffer)
        utils.lsp.keymaps.on_attach(keymaps, client, buffer)
      end)

      -- Diagnostic signs
      if type(opts.diagnostics.signs) ~= "boolean" then
        for severity, icon in pairs(opts.diagnostics.signs.text) do
          local name = vim.diagnostic.severity[severity]:lower():gsub("^%l", string.upper)

          name = "DiagnosticSign" .. name

          vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
        end
      end

      -- Inlay hints
      if opts.inlay_hints.enabled then
        utils.lsp.on_supports_method("textDocument/inlayHint", function(client, buffer)
          if vim.api.nvim_buf_is_valid(buffer) and vim.bo[buffer].buftype == "" then
            vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
          end
        end)
      end

      -- Code lens
      if opts.codelens.enabled and vim.lsp.codelens then
        utils.lsp.on_supports_method("textDocument/codeLens", function(client, buffer)
          vim.lsp.codelens.refresh()

          vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
            buffer = buffer,
            callback = vim.lsp.codelens.refresh,
          })
        end)
      end

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      local servers = opts.servers
      local has_blink, blink = pcall(require, "blink.cmp")

      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_blink and blink.get_lsp_capabilities() or {},
        opts.capabilities or {}
      )

      for server in pairs(opts.servers) do
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})

        if server_opts.enabled == false then
          goto continue
        end

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        end

        lspconfig[server].setup(server_opts)

        ::continue::
      end
    end,
  },
}
