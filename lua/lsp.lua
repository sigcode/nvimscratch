vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local map = vim.keymap.set
    local function opts(desc) return { buffer = ev.buf, desc = desc } end

    map("n", "gd",         vim.lsp.buf.definition,    opts("Go to definition"))
    map("n", "gD",         vim.lsp.buf.declaration,   opts("Go to declaration"))
    map("n", "gr",         vim.lsp.buf.references,    opts("References"))
    map("n", "gi",         vim.lsp.buf.implementation,opts("Go to implementation"))
    map("n", "K",          vim.lsp.buf.hover,         opts("Hover docs"))
    map("n", "<leader>ca", vim.lsp.buf.code_action,   opts("Code action"))
    map("n", "<leader>rn", vim.lsp.buf.rename,        opts("Rename symbol"))
    map("n", "<leader>d",  vim.diagnostic.open_float, opts("Show diagnostic float"))
  end,
})

local servers = {
  intelephense = {
    settings = {
      intelephense = {
        files = { maxSize = 5000000 },
      },
    },
  },
  ts_ls = {},
  eslint = {},
  html = {},
  cssls = {},
  jsonls = {},
  tailwindcss = {},
  emmet_language_server = {
    filetypes = {
      "html", "css", "scss",
      "javascriptreact", "typescriptreact",
    },
  },
}

for name, config in pairs(servers) do
  vim.lsp.config(name, config)
  vim.lsp.enable(name)
end
