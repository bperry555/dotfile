return {
-- 	{ "L3MON4D3/LuaSnip",
-- 		 version = "2.*",
-- 		build = "make install_jsregexp",
-- 	},-- Required
   -- LSP Support
   {"neovim/nvim-lspconfig",
   	dependencies = {
		"williamboman/mason.nvim",
      		"williamboman/mason-lspconfig.nvim" ,
        	-- Autocompletion
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
         	"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
	-- For vsnip users.
  		-- "hrsh7th/cmp-vsnip",
  		-- "hrsh7th/vim-vsnip",

	-- For luasnip users.
        -- Snippets
         	-- "L3MON4D3/LuaSnip",
		-- "saadparwaiz1/cmp_luasnip",
        	--{ "rafamadriz/friendly-snippets" }, -- Optional

	-- For ultisnips users.
	  	-- "SirVer/ultisnips",
		-- "quangnguyen30192/cmp-nvim-ultisnips",

	-- For snippy users.
	  	-- "dcampos/nvim-snippy",
		-- "dcampos/cmp-snippy",
		"j-hui/fidget.nvim",
	},
   },
   config = function ()
	local cmp_lsp = require("cmp_nvim_lsp")
	local capabilities = vim.tbl_deep_extend("force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities())

	require("fidget").setup({})
      require("mason").setup()
      require("mason-lspconfig").setup({
	      ensure_installed = { "lua_la", "rust_analyzer", "clangd", "pyright", "tsserver"},
	      handlers = {
		function (server_name) -- default handler (optional)
			require("lspconfig")[server_name].setup {
				capabilities = capabilities
			}
		end,
	--	["rust_analyzer"] = function ()
	--		require("rust-tools").setup {}
	--	end,
		["lua_ls"] = function ()
		    local lspconfig = require("lspconfig")
		    lspconfig.lua_ls.setup {
			capabilities = capabilities,
		       settings = {
			  Lua = {
			     diagnostics = {
			        globals = { "vim" }
			     }
			  }
		       }
		   }
		end,
	      },
     })
	local luasnip = require("luasnip")
	local cmp = require("cmp")
		cmp.setup({
			snippet = {
				expand = function (args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
				['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
				-- C-b (back) C-f (forward) for snippet placeholder navigation.
				['<C-Space>'] = cmp.mapping.complete(),
				['<CR>'] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				}),
				['<Tab>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
					end, { 'i', 's' }),
				['<S-Tab>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
					end, { 'i', 's' }),
				}),
			sources = cmp.config.sources({
				{ name = 'nvim_lsp' },
				{ name = 'luasnip' },
			}, {
				{ name = "buffer" },
			})
		})
	end,

        { 'folke/neodev.nvim' ,
		config = function()
        		require('neodev').setup({
          			library = { plugins = { "nvim-dap-ui" }, types = true },
        		})
		end,
	},

       -- lsp.set_sign_icons({
       --     error = '✘',
       --     warn = '▲',
       --     hint = '⚑',
       --     info = '»'
       -- })
}
