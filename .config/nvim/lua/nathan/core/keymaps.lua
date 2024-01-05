vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness
local api = vim.api
local opts = { noremap = true, silent = true }

---------------------
-- General Keymaps
---------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>")

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- write file
keymap.set("n", "<leader>w", ":w<CR>")
keymap.set("n", "<leader>wq", ":wq!<CR>")

-- quit file
keymap.set("n", "<leader>qq", ":q<CR>")

-- replace work with last yanked item
keymap.set("n", "<leader>wp", 'viwp:viw"0p')

-- nvim-tree create new file in current directory
api.fs = {
  create = function()
    local input = vim.fn.input("New file name: ")
    if input == "" then
      print("File name cannot be empty")
      return
    end
    local path = vim.fn.expand("%:p:h") .. "/" .. input
    if vim.fn.filereadable(path) == 1 then
      print("File already exists")
      return
    end
    vim.cmd("edit " .. path)
  end,
}

-- create new file in current directory
keymap.set("n", "<leader>nn", api.fs.create)
-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>") -- increment
keymap.set("n", "<leader>-", "<C-x>") -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>st", "<C-w>s:terminal<CR>")

keymap.set("n", "<leader>h", ":wincmd h<CR>", { noremap = true })
keymap.set("n", "<leader>l", ":wincmd l<CR>", { noremap = true })

keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") --  go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") --  go to previous tab

-- Find a function using :tag
keymap.set("n", "<leader>tf", ":tag<space>")

----------------------
-- Plugin Keybinds
----------------------

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle split window maximization

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>") -- toggle file explorer
keymap.set("n", "<leader>ee", ":NvimTreeFocus<CR>") -- focus on file explorer
keymap.set("n", "<leader>er", ":NvimTreeRefresh<CR>") -- refresh file explorer
keymap.set("n", "<leader>en", ":NvimTreeFindFile<CR>") -- find file in file explorer

-- telescope
keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
keymap.set("n", "<leader>f", function()
  require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end, { desc = "[/] Fuzzily search in current buffer" })

keymap.set("n", "<leader>p", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
keymap.set("n", "<M-p>", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
keymap.set("n", "<leader>ssh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })

-- telescope git commands
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]

-- restart lsp server (not on youtube nvim video)
keymap.set("n", "<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary
