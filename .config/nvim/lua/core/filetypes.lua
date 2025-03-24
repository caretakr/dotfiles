--
-- Filetypes config
--
--
vim.filetype.add({
  pattern = {
    ["*.component.html"] = "html.angular",
  },
})

vim.filetype.add({
  pattern = {
    [".*/.github/workflows/.*%.ya?ml"] = "yaml.action",
    [".*/.github/actions/.*%.ya?ml"] = "yaml.action",
  },
})

vim.filetype.add({
  pattern = {
    [".*/defaults/.*%.ya?ml"] = "yaml.ansible",
    [".*/host_vars/.*%.ya?ml"] = "yaml.ansible",
    [".*/group_vars/.*%.ya?ml"] = "yaml.ansible",
    [".*/group_vars/.*/.*%.ya?ml"] = "yaml.ansible",
    [".*/playbook.*%.ya?ml"] = "yaml.ansible",
    [".*/playbooks/.*%.ya?ml"] = "yaml.ansible",
    [".*/roles/.*/tasks/.*%.ya?ml"] = "yaml.ansible",
    [".*/roles/.*/handlers/.*%.ya?ml"] = "yaml.ansible",
    [".*/tasks/.*%.ya?ml"] = "yaml.ansible",
    [".*/molecule/.*%.ya?ml"] = "yaml.ansible",
  },
})
