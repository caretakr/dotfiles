--
-- Automatic commands config
--

--
-- Remove underline from context
--

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = false })
		vim.api.nvim_set_hl(0, "TreesitterContextLineNumberBottom", { underline = false })
	end,
})
