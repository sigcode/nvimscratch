local map = vim.keymap.set

map("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle Neo-tree" })

map("n", "<leader>f", "<cmd>FzfLua files<cr>", { desc = "Find files" })
map("n", "<leader>g", "<cmd>FzfLua live_grep<cr>", { desc = "Live grep" })
map("n", "<leader>b", "<cmd>FzfLua buffers<cr>", { desc = "Buffers" })
map("n", "<leader>/", "<cmd>FzfLua grep_curbuf<cr>", { desc = "Grep current buffer" })
map("n", "<leader>r", "<cmd>FzfLua resume<cr>", { desc = "Resume last picker" })

map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr>", { desc = "Save" })
map("n", "<leader>sv", "<cmd>source $MYVIMRC<cr>", { desc = "Reload config" })
map("n", "<leader>su", "<cmd>lua vim.pack.update()<cr>", { desc = "Update plugins" })

map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")


map("n", "<Esc>", "<cmd>nohlsearch<cr>")

map("v", "<", "<gv")
map("v", ">", ">gv")

map({ "n", "v", "o" }, "ö", "[", { remap = true, desc = "[ (German layout)" })
map({ "n", "v", "o" }, "ä", "]", { remap = true, desc = "] (German layout)" })
map({ "n", "v", "o" }, "Ö", "{", { remap = true, desc = "{ (German layout)" })
map({ "n", "v", "o" }, "Ä", "}", { remap = true, desc = "} (German layout)" })

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
map("n", "<leader>x", function()
  local cur = vim.api.nvim_get_current_buf()
  local listed = vim.fn.getbufinfo({ buflisted = 1 })
  if #listed > 1 then vim.cmd("BufferLineCyclePrev") end
  pcall(vim.cmd, "bdelete " .. cur)
end, { desc = "Close buffer" })

map("n", "<leader>X", "<cmd>BufferLinePick<cr>",      { desc = "Pick buffer (jump by letter)" })
map("n", "<leader>C", "<cmd>BufferLinePickClose<cr>", { desc = "Pick buffer to close" })
