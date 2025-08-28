return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		---Add a space b/w comment and the line
		padding = true,

		---Whether the cursor should stay at its position
		sticky = true,

		---Lines to be ignored while (un)comment
		ignore = nil,

		---LHS of operator-pending mappings in NORMAL and VISUAL mode
		opleader = {
			---Line-comment keymap
			line = "gc",
			---Block-comment keymap
			block = "gb",
		},
	},
}
