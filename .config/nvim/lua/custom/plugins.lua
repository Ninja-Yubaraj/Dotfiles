return function(use)

-- Some Nice Plugins --
 -- use({
 --   "folke/which-key.nvim",
 --     config = function()
 --       require("which-key").setup({})
 --     end
 -- })

-- Color Scheme --
  -- use { 'AlphaTechnolog/pywal.nvim', as = 'pywal' }
  use { "catppuccin/nvim", as = "catppuccin" }

-- Discord --
  -- use { 'andweeb/presence.nvim' }

-- Markdown and Pandoc --
--   use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })

end
