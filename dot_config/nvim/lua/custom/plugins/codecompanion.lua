return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'hrsh7th/nvim-cmp', -- Optional: For using slash commands and variables in the chat buffer
    'nvim-telescope/telescope.nvim', -- Optional: For using slash commands
    { 'echasnovski/mini.nvim', version = false },
    { 'stevearc/dressing.nvim', opts = {} }, -- Optional: Improves `vim.ui.select`
  },
  config = true,
  setup = {
    display = {
      diff = {
        provider = 'mini_pick',
      },
    },
  },
}
