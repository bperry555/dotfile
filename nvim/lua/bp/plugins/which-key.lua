return {
 {
    "folke/which-key.nvim",
    lazy = true,
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
  },
    --opts = {
        --plugins = { spelling = true },
        --defaults = {
            --mode = {},
        --},
    --config = function(_, opts)
        --local wk = require("which-key")
        --wk.setup(opts)
        --wk.register(opts.defaults)
    --end,
    --},
}
