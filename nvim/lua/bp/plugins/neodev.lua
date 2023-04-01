return {
    "folke/neodev.nvim",
    config = function ()
        require('neodev').setup({
            library = {
                plugins = {
                    'vnim-dap-ui'
                },
                types = true },
            })
        end
}
