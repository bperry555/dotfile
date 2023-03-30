return {
    "folke/tokyonight.nvim", -- the other lua colorscheme
    lazy = false,
    priority = 1000,
    config = function()
        require("tokyonight").setup({
            style = "night",
            transparent = false,
            terminal_colors = true,
            styles = {
                comments = { italic = true },
                strings = { italic = true },
            },
            sidebars = { "qf", "help", "aerial", "terminal" },
        })
        -- vim.cmd([[colorscheme tokyonight]])
    end,
}
