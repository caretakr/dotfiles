--
-- Search config
--

return {
  {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
    keys = function()
      local grug_far = require("grug-far")

      return {
        {
          "<leader>sr",
          function()
            local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")

            grug_far.open({
              transient = true,
              prefills = {
                filesFilter = ext and ext ~= "" and "*." .. ext or nil,
              },
            })
          end,
          desc = "Search and replace",
          mode = { "n", "v" },
        },
      }
    end,
    opts = {
      headerMaxWidth = 80,
    },
  },
}
