return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
       'nvim-treesitter/nvim-treesitter-textobjects' },
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdateSync" },
    config = function ()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            highlight = { enable = true },
            indent = { enable = true },
            ensure_installed = { "c", "lua", "vim", "help", "html", "css", "javascript", "typescript", "python", "rust", "latex" },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "gnn",
                    node_incremental = "grn",
                    scope_incremental = "grc",
                    node_decremental = "grm",
                },
            },
            textobjects = {
              select = {
                enable = true,
                lookahead = true,
                keymaps = {
                  ["af"] = { query = "@function.outer", desc = "Around Function" },
                  ["if"] = { query = "@function.inner", desc = "Inner Function" },
                  ["ac"] = { query = "@class.outer", desc = "Around Class" },
                  ["ic"] = { query = "@class.inner", desc = "Inner Class" },
                  ["al"] = { query = "@loop.outer", desc = "Around Loop" },
                  ["il"] = { query = "@loop.inner", desc = "Inner Loop" },
                },
                selection_modes = {
                    ['@parameter.outer'] = 'v',
                    ['@function.outer'] = 'V',
                    ['@class.outer'] = '<c-v>',
                },
                include_surrounding_whitespace = false,
              },
              lsp_interop = {
                enable = true,
                border = 'none',
                floating_preview_opts = {},
                peek_definition_code = {
                    ["<leader>df"] = "@function.outer",
                    ["<leader>dF"] = "@class.outer",
                },
            },
        move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        ["]m"] = { query = "@function.outer", desc = "Function Start Next" },
                    },
                    goto_next_end = {},
                    goto_previous_start = {},
                    goto_previous_end = {},
                    goto_next = {},
                    goto_previous = {}
                }
          },
    })
    end,
}
-- Add Keybinds
-- Add Treesitter Text Objects
