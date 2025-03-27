return {
	{
		"andweeb/presence.nvim", -- Give discord ritch presence information.
		config = function()
			require("presence").setup({
				main_image = "/home/alex/.local/share/rofi_game_launcher/nvim.png",
				enable_line_number = false,
			})
		end,
	},
}
