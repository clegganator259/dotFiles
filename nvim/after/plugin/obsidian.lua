require("obsidian").setup({
	workspaces = {
		{
			name = "personal",
			path = "~/vaults/personal",
		},
	},
	notes_subdir = "notes",
	new_note_subdir = "notes",
	conceallevel = 1,
	mappings = {
		["<cr>"] = {
			action = function()
				return require("obsidian").util.smart_action()
			end,
			opts = { buffer = true, expr = true },
		},
	},
	-- Optional, customize how note IDs are generated given an optional title.
	---@param title string|?
	---@return string
	note_id_func = function(title)
		-- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
		-- In this case a note with the title 'My new note' will be given an ID that looks
		-- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
		local suffix = ""
		if title ~= nil then
			-- If title is given, transform it into valid file name.
			suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
		else
			-- If title is nil, just add 4 random uppercase letters to the suffix.
			for _ = 1, 4 do
				suffix = suffix .. string.char(math.random(65, 90))
			end
		end
		return tostring(os.time()) .. "-" .. suffix
	end,
	daily_notes = {
		-- Optional, if you keep daily notes in a separate directory.
		folder = "notes/dailies",
		-- Optional, if you want to change the date format for the ID of daily notes.
		date_format = "%Y-%m-%d",
		default_tags = { "daily-notes" },
	},
})
vim.keymap.set("n", "<leader>os", ":ObsidianQuickSwitch<CR>", { silent = true, desc = "Open obsidian note list" })
vim.keymap.set("n", "<leader>on", ":ObsidianNew<CR>", { silent = true, desc = "Open a new obsidian note" })
vim.keymap.set("n", "<leader>otd", ":ObsidianToday<CR>", { silent = true, desc = "Open the obsidian today tab" })
vim.keymap.set("n", "<leader>otm", ":ObsidianTomorrow<CR>", { silent = true, desc = "Open the obsidian tomorrow tab" })
