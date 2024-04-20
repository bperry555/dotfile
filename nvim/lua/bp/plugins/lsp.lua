return {
   -- 	{ "L3MON4D3/LuaSnip",
   -- 		 version = "2.*",
   -- 		build = "make install_jsregexp",
   -- 	},-- Required
   -- LSP Support
   { "neovim/nvim-lspconfig",
      dependencies = {
	 "williamboman/mason.nvim",
	 "williamboman/mason-lspconfig.nvim",
	 -- Status updates for LSP
	 {"j-hui/fidget.nvim", opts = {} },

	 -- Neodev configure Lua LSP for Neovim config, runtime and plugins.
	 -- Used fo completion, annotations and signatures of Neovim API's.
	 {'folke/neodev.nvim', opts = {} },

	 -- Autocompletion
	 {"hrsh7th/nvim-cmp",
	    event = 'InsertEnter',
	    dependencies = {
	       {
		  "L3MON4D3/LuaSnip",
		  build = (function ()
		     if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
			return
		     end
		     return 'make install_jsregexp'
		  end)(),
		  dependencies = {
		     --{ "rafamadriz/friendly-snippets" }, -- Optional
		     --{ "honza/vim-snippets" },
		  },
	       },
	       "saadparwaiz1/cmp_luasnip",
	       "hrsh7th/cmp-nvim-lsp",
	       "hrsh7th/cmp-nvim-lua",
	       "hrsh7th/cmp-buffer",
	       "hrsh7th/cmp-path",
	       "hrsh7th/cmp-cmdline",
	    },
	    config = function ()
	       local cmp = require 'cmp'
	       local luasnip = require 'luasnip'
	       luasnip.config.setup{}

	       cmp.setup {
		  snippet = {
		     expand = function(args)
			luasnip.lsp_expand(args.body)
		     end,
		  },
		  completion = { completeopt = 'menu,munuone,noinsert' },
		  mapping = cmp.mapping.preset.insert {
		     ['<C-n>'] = cmp.mapping.select_next_item(),
		     ['<C-p>'] = cmp.mapping.select_prev_item(),

		     ['<C-b>'] = cmp.mapping.scroll_docs(-4),
		     ['<C-f>'] = cmp.mapping.scroll_docs(4),

		     -- Accept ([y]es) the completion.
		     --  This will auto-import if your LSP supports it.
		     --  This will expand snippets if the LSP sent a snippet.
		     ['<C-y>'] = cmp.mapping.confirm { select = true },

		     -- Manually trigger a completion from nvim-cmp.
		     --  Generally you don't need this, because nvim-cmp will display
		     --  completions whenever it has completion options available.
		     ['<C-Space>'] = cmp.mapping.complete {},

		     -- Think of <c-l> as moving to the right of your snippet expansion.
		     --  So if you have a snippet that's like:
		     --  function $name($args)
		     --    $body
		     --  end
		     --
		     -- <c-l> will move you to the right of each of the expansion locations.
		     -- <c-h> is similar, except moving you backwards.
		     ['<C-l>'] = cmp.mapping(function()
			if luasnip.expand_or_locally_jumpable() then
			   luasnip.expand_or_jump()
			end
		     end, { 'i', 's' }),
		     ['<C-h>'] = cmp.mapping(function()
			if luasnip.locally_jumpable(-1) then
			   luasnip.jump(-1)
			end
		     end, { 'i', 's' }),

		     -- For more advanced luasnip keymaps (e.g. selecting choice nodes, expansion) see:
		     --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
		  },
		  sources = {
		     { name = 'nvim_lsp' },
		     { name = 'luasnip' },
		     { name = 'path' },
		  },
	       }
	    end,
	 },
      },
      config = function ()
	 local cmp_lsp = require("cmp_nvim_lsp")
	 local capabilities = vim.lsp.protocol.make_client_capabilities()
	 capabilities = vim.tbl_deep_extend('force', capabilities, cmp_lsp.default_capabilities())

	 require("mason").setup()
	 require("mason-lspconfig").setup({
	    ensure_installed = {"lua_ls", "rust_analyzer", "clangd", "pyright", "tsserver"},
	    handlers = {
	       function (server_name) -- default handler (optional)
		  require("lspconfig")[server_name].setup {
		     capabilities = capabilities
		  }
	       end,
	       --	["rust_analyzer"] = function ()
	       --		require("rust-tools").setup {}
	       -- end,
	       ["lua_ls"] = function ()
		  local lspconfig = require("lspconfig")
		  lspconfig.lua_ls.setup {
		     capabilities = capabilities,
		     settings = {
			Lua = {
			   runtime = { version = "LuaJIT" },
			   workspace = {
			      checkThirdParty = false,
			   },
			   diagnostics = {
			      globals = { "vim" },
			      disable = { 'missing-fields' }
			   },
			},
		     },
		  }
	       end,
	    },
	 })
      end
   }
}
--	 local luasnip = require("luasnip")
--	 local cmp = require("cmp")
--	 cmp.setup({
--	    snippet = {
--	       expand = function (args)
--		  luasnip.lsp_expand(args.body)
--	       end,
--	    },
--	    mapping = cmp.mapping.preset.insert({
--	       ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
--	       ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
--	       -- C-b (back) C-f (forward) for snippet placeholder navigation.
--	       ['<C-Space>'] = cmp.mapping.complete(),
--	       ['<CR>'] = cmp.mapping.confirm({
--		  behavior = cmp.ConfirmBehavior.Replace,
--		  select = true,
--	       }),
--	       ['<Tab>'] = cmp.mapping(function(fallback)
--		  if cmp.visible() then
--		     cmp.select_next_item()
--		  elseif luasnip.expand_or_jumpable() then
--		     luasnip.expand_or_jump()
--		  else
--		     fallback()
--		  end
--		  end, { 'i', 's' }),
--	       ['<S-Tab>'] = cmp.mapping(function(fallback)
--		  if cmp.visible() then
--		     cmp.select_prev_item()
--		  elseif luasnip.jumpable(-1) then
--		     luasnip.jump(-1)
--		  else
--		     fallback()
--		  end
--		  end, { 'i', 's' }),
--	    }),
--	    sources = cmp.config.sources({
--	       { name = 'nvim_lsp' },
--	       { name = 'luasnip' },
--	       }, {
--		  { name = "buffer" },
--	    })
--	 })
--      end,

   -- lsp.set_sign_icons({
   --     error = '✘',
   --     warn = '▲',
   --     hint = '⚑',
   --     info = '»'
   -- })
