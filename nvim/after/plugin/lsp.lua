local lsp = require('lsp-zero').preset({
  name = 'minimal',
  set_lsp_keymaps = true,
  manage_nvim_cmp = true,
  suggest_lsp_servers = false,
})

lsp.ensure_installed({
  'tsserver',
  'rust_analyzer',
  'eslint',
  'pyright',
  'svelte',


})
-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

lsp.on_attach(function (client, bufnr)
	local opts = {buffer = bufnr, remap = false}
end)

lsp.setup()
