return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    dependencies = {
        -- LSP Support
        { 'neovim/nvim-lspconfig' },       -- Required
        { 'williamboman/mason.nvim' },     -- Optional
        { 'williamboman/mason-lspconfig.nvim' }, -- Optional

        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },   -- Required
        { 'hrsh7th/cmp-nvim-lsp' }, -- Required
        { 'hrsh7th/cmp-buffer' }, -- Optional
        { 'hrsh7th/cmp-path' },   -- Optional
        { 'saadparwaiz1/cmp_luasnip' }, -- Optional
        { 'hrsh7th/cmp-nvim-lua' }, -- Optional

        -- Snippets
        { 'L3MON4D3/LuaSnip' },       -- Required
        { 'rafamadriz/friendly-snippets' }, -- Optional

        -- Testing neodev.nvim
        { 'folke/neodev.nvim' },
    },
    config = function()
        require('neodev').setup({})
        local lsp = require('lsp-zero').preset({
            name = 'recommended',
            set_lsp_keymaps = true,
            manage_nvim_cmp = true,
            suggest_lsp_servers = true,
        })

        lsp.skip_server_setup({'rust_analyzer'})

        lsp.configure('lua_ls',{
            on_attach = function(client, bufnr)
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
