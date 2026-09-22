vim.pack.add({
  { src = "https://github.com/catppuccin/nvim",                  name = "catppuccin" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/MunifTanjim/nui.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/nvim-neo-tree/neo-tree.nvim" },
  { src = "https://github.com/ibhagwan/fzf-lua" },
  { src = "https://github.com/saghen/blink.cmp",                 version = vim.version.range("1.*") },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/sindrets/diffview.nvim" },
  { src = "https://github.com/akinsho/bufferline.nvim" },
  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/akinsho/toggleterm.nvim" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/goolord/alpha-nvim" },
  { src = "https://github.com/echasnovski/mini.pairs" },
})

require("catppuccin").setup({
  flavour = "mocha",
  integrations = {
    neotree = true,
    treesitter = true,
    blink_cmp = true,
    fzf = true,
    native_lsp = { enabled = true },
  },
})
vim.cmd.colorscheme("catppuccin-mocha")

require("nvim-treesitter").install({
  "lua", "vim", "vimdoc", "bash",
  "javascript", "typescript", "tsx",
  "php", "php_only", "phpdoc",
  "html", "css", "scss",
  "json", "yaml",
  "markdown", "markdown_inline",
  "regex", "diff", "gitcommit",
})

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})

require("nvim-web-devicons").setup({})

require("neo-tree").setup({
  close_if_last_window = true,
  filesystem = {
    follow_current_file = { enabled = true },
    use_libuv_file_watcher = true,
    filtered_items = {
      visible = false,
      hide_dotfiles = false,
      hide_gitignored = true,
    },
  },
  window = { width = 32 },
  default_component_configs = {
    indent = { with_markers = true },
    git_status = {
      symbols = {
        added    = "+",
        modified = "~",
        deleted  = "-",
        renamed  = "→",
        untracked = "?",
        ignored   = "·",
        unstaged  = "○",
        staged    = "●",
        conflict  = "!",
      },
    },
  },
})

require("fzf-lua").setup({
  "default",
  files = { formatter = "path.filename_first" },
})

require("bufferline").setup({
  options = {
    mode = "buffers",
    diagnostics = "nvim_lsp",
    show_buffer_close_icons = true,
    show_close_icon = false,
    separator_style = "slant",
    offsets = {
      { filetype = "neo-tree", text = "Files", separator = true, text_align = "left" },
    },
  },
})

require("which-key").setup({
  preset = "modern",
  delay = 300,
  icons = { mappings = false },
})

require("which-key").add({
  { "<leader>h",  group = "git/hunks" },
  { "<leader>gg", desc = "Lazygit" },
  { "<C-l>",      desc = "AI: Accept suggestion" },
  { "<C-j>",      desc = "AI: Accept next word" },
  { "<C-t>",      desc = "Toggle terminal (float)" },
  { "<leader>ca", desc = "Code action" },
  { "<leader>rn", desc = "Rename symbol" },
  { "<leader>d",  desc = "Show diagnostic float" },
  { "gd",         desc = "Go to definition" },
  { "gD",         desc = "Go to declaration" },
  { "gr",         desc = "References" },
  { "gi",         desc = "Go to implementation" },
  { "K",          desc = "Hover docs" },
  { "ö", desc = "[ prev (prefix)" },
  { "ä", desc = "] next (prefix)" },
  { "öc", desc = "Prev git hunk" },
  { "äc", desc = "Next git hunk" },
  { "öd", desc = "Prev diagnostic" },
  { "äd", desc = "Next diagnostic" },
})

require("gitsigns").setup({
  signs = {
    add          = { text = "▎" },
    change       = { text = "▎" },
    delete       = { text = "" },
    topdelete    = { text = "" },
    changedelete = { text = "▎" },
    untracked    = { text = "▎" },
  },
})

local gs = require("gitsigns")
local function nmap(lhs, rhs, desc)
  vim.keymap.set("n", lhs, rhs, { desc = desc })
end

nmap("]c", function() gs.nav_hunk("next") end, "Next git hunk")
nmap("[c", function() gs.nav_hunk("prev") end, "Prev git hunk")

nmap("<leader>hd", function()
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.api.nvim_buf_get_name(buf):match("^gitsigns://") then
      vim.api.nvim_win_close(win, false)
      return
    end
  end
  gs.diffthis()
end, "Toggle diff against HEAD")
nmap("<leader>hp", gs.preview_hunk,       "Preview hunk")
nmap("<leader>hb", function() gs.blame_line({ full = true }) end, "Blame line")
nmap("<leader>hB", gs.toggle_current_line_blame, "Toggle inline blame")
nmap("<leader>hr", gs.reset_hunk,         "Reset hunk")
nmap("<leader>hs", gs.stage_hunk,         "Stage hunk")

nmap("<leader>hv", "<cmd>DiffviewOpen<cr>",            "Diffview: review all changes")
nmap("<leader>hV", "<cmd>DiffviewClose<cr>",           "Diffview: close")
nmap("<leader>hH", "<cmd>DiffviewFileHistory %<cr>",   "Diffview: history of current file")
nmap("<leader>hL", "<cmd>DiffviewFileHistory<cr>",     "Diffview: history of project")

require("blink.cmp").setup({
  keymap = { preset = "default" },
  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 200 },
    list = { selection = { preselect = false, auto_insert = true } },
  },
  signature = { enabled = true },
  sources = {
    default = { "lsp", "path", "buffer" },
  },
})

local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
  "                                                     ",
  "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
  "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
  "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
  "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
  "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
  "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
  "                                                     ",
}

dashboard.section.buttons.val = {
  dashboard.button("f", "  Find file",     "<cmd>FzfLua files<cr>"),
  dashboard.button("r", "  Recent files",  "<cmd>FzfLua oldfiles<cr>"),
  dashboard.button("g", "  Live grep",     "<cmd>FzfLua live_grep<cr>"),
  dashboard.button("e", "  New file",      "<cmd>enew<cr>"),
  dashboard.button("q", "  Quit",          "<cmd>qa<cr>"),
}

dashboard.section.footer.val = ""
dashboard.opts.layout[1].val = 6

alpha.setup(dashboard.config)

-- Dashboard nicht in der Bufferline anzeigen
vim.api.nvim_create_autocmd("FileType", {
  pattern = "alpha",
  callback = function()
    vim.opt_local.showtabline = 0
    vim.api.nvim_create_autocmd("BufUnload", {
      buffer = 0,
      callback = function() vim.opt.showtabline = 2 end,
    })
  end,
})

require("lualine").setup({
  options = {
    theme = "auto",
    globalstatus = true,
    section_separators   = { left = "", right = "" },
    component_separators = { left = "│", right = "│" },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { { "filename", path = 1 } },
    lualine_x = { "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
})

require("toggleterm").setup({
  open_mapping = [[<C-t>]],
  direction = "float",
  float_opts = {
    border = "curved",
    width = function() return math.floor(vim.o.columns * 0.88) end,
    height = function() return math.floor(vim.o.lines * 0.85) end,
  },
  shade_terminals = false,
  start_in_insert = true,
  persist_mode = true,
  close_on_exit = false,
  on_open = function(term)
    vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { buffer = term.bufnr, desc = "Terminal normal mode" })
  end,
})

local lazygit = require("toggleterm.terminal").Terminal:new({
  cmd = "lazygit",
  direction = "float",
  float_opts = {
    border = "curved",
    width  = function() return math.floor(vim.o.columns * 0.95) end,
    height = function() return math.floor(vim.o.lines * 0.92) end,
  },
  hidden = true,
  on_open = function(term)
    -- q / Esc schließt lazygit direkt (kein Normal-Mode nötig)
    vim.keymap.set("t", "q",     [[<cmd>close<cr>]], { buffer = term.bufnr, silent = true })
  end,
})

vim.keymap.set("n", "<leader>gg", function() lazygit:toggle() end, { desc = "Lazygit" })

require("mini.pairs").setup()
