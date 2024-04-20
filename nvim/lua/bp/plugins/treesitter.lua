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
            ensure_installed = { "c", "lua", "vim", "vimdoc", "help", "html", "css", "javascript", "typescript", "python", "rust", "latex" },
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
                        ["]f"] = { query = "@function.outer", desc = "Function Start Next" },
                        ["]c"] = { query = "@class.outer", desc = "Class Start Next" },
                        ["]l"] = { query = { "@loop.inner", "@loop.outer" }, desc = "Class Start Next" },
                        ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
                        ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
                    },
                    goto_next_end = {
			["]F"] = "@function.outer",
			["]C"] = "@class.outer",
			},
                    goto_previous_start = {
			["[f"] = "@function.outer",
			["[c"] = "@class.outer",
			},
                    goto_previous_end = {
			["[F"] = "@function.outer",
			["[C"] = "@class.outer",
			},
                    goto_next = {
			["]d"] = "@conditional.outer",
			},
                    goto_previous = {
			["[d"] = "@conditional.outer",
			}
                }
          },
    })
	local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

	-- Repeat movement with ; and ,
	-- ensure ; goes forward and , goes backward regardless of the last direction
	vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
	vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
	
	-- vim way: ; goes to the direction you were moving.
	-- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
	-- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)
	
	-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
	vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
	vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
	vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
	vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)	
    end,
}
