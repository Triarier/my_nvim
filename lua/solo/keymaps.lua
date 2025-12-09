vim.keymap.set("n","<leader>pv","<cmd>Oil<CR>")
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window
vim.keymap.set("n","<leader>cpp","<cmd>Copilot panel toggle<CR>")
vim.keymap.set("n","ä","<cmd>Copilot panel jump_next<CR>")
vim.keymap.set("n","ö","<cmd>Copilot panel jump_prev<CR>")
vim.keymap.set("n","<leader>y","<cmd>Copilot panel accept<CR>")
