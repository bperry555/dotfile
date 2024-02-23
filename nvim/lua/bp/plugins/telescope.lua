return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.2',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
        },
       keys = {
            {
            "<leader>ff",
                function () require('telescope.builtin').find_files({}) end,
                desc = "Find File",
            },
            {
            "<leader>fg",
                function () require('telescope.builtin').live_grep({}) end,
                desc = "Live Grepo (RipGrep)",
            },
            {
            "<leader>fb",
                function () require('telescope.builtin').buffers({}) end,
                desc = "Buffers",
            },
            {
            "<leader>fh",
                function () require('telescope.builtin').help_tags({}) end,
                desc = "Help Tags",
            },
        },
    },
    {
        "telescope.nvim",
        dependencies = {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            config = function ()
                require('telescope').load_extension('fzf')
            end,
        },
    },
}
