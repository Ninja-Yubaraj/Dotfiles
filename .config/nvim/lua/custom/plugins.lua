return function(use)

-- Which Key
 -- use({
 --   "folke/which-key.nvim",
 --     config = function()
 --       require("which-key").setup({})
 --     end
 -- })

-- Color Scheme --
  -- use { 'AlphaTechnolog/pywal.nvim', as = 'pywal' }
  use { "catppuccin/nvim", as = "catppuccin" }

-- Discord Presence
  -- use { 'andweeb/presence.nvim' }

-- Markdown and Pandoc --
--   use({
--     "iamcco/markdown-preview.nvim",
--     run = function() vim.fn["mkdp#util#install"]() end,
-- })
end
