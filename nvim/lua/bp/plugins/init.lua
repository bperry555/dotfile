return {
    {'mbbill/undotree',
        keys = {
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
        },
    },
    'tpope/vim-fugitive',
    { 'nvim-tree/nvim-web-devicons', event = "VeryLazy" },
    {'lervag/vimtex'},
}

