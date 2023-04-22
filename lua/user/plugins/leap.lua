return {
	"ggandor/leap.nvim",
	keys = {
		{ "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
		{ "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
		{ "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
	},
	config = function(_, opts)
		local leap = require("leap")
		for k, v in pairs(opts) do
			leap.opts[k] = v
		end
		leap.add_default_mappings(true)
		vim.keymap.del({ "x", "o" }, "x")
		vim.keymap.del({ "x", "o" }, "X")
		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = function()
				require("leap").init_highlight(true)
			end,
		})
		-- The below settings make Leap's highlighting closer to what you've been
		-- used to in Lightspeed.

		vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" }) -- or some grey
		vim.api.nvim_set_hl(0, "LeapMatch", {
			-- For light themes, set to 'black' or similar.
			fg = "white",
			bold = true,
			nocombine = true,
		})
		-- Of course, specify some nicer shades instead of the default "red" and "blue".
		vim.api.nvim_set_hl(0, "LeapLabelPrimary", {
			fg = "red",
			bold = true,
			nocombine = true,
		})
		vim.api.nvim_set_hl(0, "LeapLabelSecondary", {
			fg = "blue",
			bold = true,
			nocombine = true,
		})
		-- Try it without this setting first, you might find you don't even miss it.
		require("leap").opts.highlight_unlabeled_phase_one_targets = true
	end,
}
