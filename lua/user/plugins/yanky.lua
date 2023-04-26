return {
	"gbprod/yanky.nvim",
	opts = {
		ring = {
			history_length = 100,
			storage = "shada",
			sync_with_numbered_registers = true,
			cancel_event = "update",
		},
		system_clipboard = {
			sync_with_ring = true,
		},
	},
	keys = {
		{ "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" } },
		{ "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" } },
		{ "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" } },
		{ "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" } },
		{ "<c-n>", "<Plug>(YankyCycleForward)", mode = { "n" } },
		{ "<c-p>", "<Plug>(YankyCycleBackward)", mode = { "n" } },
	},
}
