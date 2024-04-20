return {
   {
      'nvim-telescope/telescope.nvim',
      tag = '0.1.6',
      dependencies = {
	 'nvim-lua/plenary.nvim',
	 'nvim-tree/nvim-web-devicons',
	 {'nvim-telescope/telescope-fzf-native.nvim',
	    build = 'make',
	    config = function()
	       require('telescope').load_extension('fzf')
	    end,
	 },
      },
      keys = {
	 {
	    "<leader>ff",
	    function() require('telescope.builtin').find_files({}) end,
	    desc = "Find File",
	 },
	 {
	    "<leader>fg",
	    function() require('telescope.builtin').live_grep({}) end,
	    desc = "Live Grepo (RipGrep)",
	 },
	 {
	    "<leader>fb",
	    function() require('telescope.builtin').buffers({}) end,
	    desc = "Buffers",
	 },
	 {
	    "<leader>fh",
	    function() require('telescope.builtin').help_tags({}) end,
	    desc = "Help Tags",
	 },
	 {
	    "<leader>fn",
	    function() require('telescope.builtin').find_files({ cwd = vim.fn.stdpath 'config' }) end,
	    desc = "[S]earch [N]eovim files",
	 },
      },
      config =function ()
      	local telescope = require('telescope').setup{}
	 telescope.load_extension('fzf')
      end,
   },
}
