return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
        -- LSP Support
        { 'neovim/nvim-lspconfig' },       -- Required
        { 'williamboman/mason.nvim',
            build = ":MasonUpdate"
        },     -- Optional
        { 'williamboman/mason-lspconfig.nvim' }, -- Optional

        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },   -- Required
        { 'hrsh7th/cmp-nvim-lsp' }, -- Required
        { 'hrsh7th/cmp-buffer' }, -- Optional
        { 'hrsh7th/cmp-path' },   -- Optional
        { 'saadparwaiz1/cmp_luasnip' }, -- Optional
        { 'hrsh7th/cmp-nvim-lua' }, -- Optional

        -- Snippets
        { 'L3MON4D3/LuaSnip',
	  version = "v2.*",
	  build = "make install_jsregexp" },       -- Required
        { 'rafamadriz/friendly-snippets' }, -- Optional

        -- Testing neodev.nvim
        { 'folke/neodev.nvim' },
        { 'simrat39/rust-tools.nvim' },
        { 'p00f/clangd_extensions.nvim' },
    },
    config = function()
        require('neodev').setup({
          library = { plugins = { "nvim-dap-ui" }, types = true },
        })
        local lsp = require('lsp-zero').preset({
            float_border = 'rounded',
            call_servers = 'local',
            configure_diagnostics = true,
            setup_servers_on_start = true,
            set_lsp_keymaps = {
                preserve_mappings = false,
                omit = {},
            },
            manage_nvim_cmp = {
                set_sources = 'recommended',
                set_basic_mappings = true,
                set_extra_mappings = true,
                use_luasnip = true,
                set_format = true,
                documentation_window = true,
            },
        })

        lsp.on_attach(function(client, bufnr)
            lsp.default_keymaps({buffer = bufnr})
        end)

        require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

        lsp.skip_server_setup({'rust_analyzer'})

        lsp.configure('lua_ls',{
            on_attach = function(_, _)
            end,
            settings = {
                Lua ={
                    completion ={
                        callSnippet = "Replace"
                    },
                    diagnostics = {
                        globals = { 'vim' }
                    }
                }
            }
        })

        lsp.set_sign_icons({
            error = '✘',
            warn = '▲',
            hint = '⚑',
            info = '»'
        })

        lsp.nvim_workspace()
        lsp.setup()

        local rust_tools = require('rust-tools')

        rust_tools.setup({
            server = {
                on_attach = function (_, bufnr)
                    -- Hover Actions
                    vim.keymap.set('n', '<C-space>', rust_tools.hover_actions.hover_actions, {buffer = bufnr})
                    -- Code Action groups
                    vim.keymap.set("n", "<Leader>a", rust_tools.code_action_group.code_action_group, { buffer = bufnr })
                end,
            },
        })

        local clangd = require('clangd_extensions')

        clangd.setup({})

        vim.diagnostic.config({
            virtual_text = true,
            signs = true,
            update_in_insert = true,
            underline = true,
            severity_sort = true,
            float = {
                focusable = false,
                style = 'minimal',
                border = 'rounded',
                source = 'always',
                header = '',
                prefix = '',
            },
        })

    end
}
