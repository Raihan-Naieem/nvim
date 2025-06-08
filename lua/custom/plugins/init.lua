-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

return {

  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'

      harpoon:setup()

      -- Add current file to Harpoon list
      vim.keymap.set('n', '<M-a>', function()
        harpoon:list():add()
      end, { desc = 'Harpoon: Add current file' })

      -- Toggle Harpoon quick menu
      vim.keymap.set('n', '<M-e>', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = 'Harpoon: Toggle quick menu' })

      -- Quick navigation to files
      vim.keymap.set('n', '<M-1>', function()
        harpoon:list():select(1)
      end, { desc = 'Harpoon: Go to file 1' })

      vim.keymap.set('n', '<M-2>', function()
        harpoon:list():select(2)
      end, { desc = 'Harpoon: Go to file 2' })

      vim.keymap.set('n', '<M-3>', function()
        harpoon:list():select(3)
      end, { desc = 'Harpoon: Go to file 3' })

      vim.keymap.set('n', '<M-4>', function()
        harpoon:list():select(4)
      end, { desc = 'Harpoon: Go to file 4' })

      -- Remove files from Harpoon by index
      vim.keymap.set('n', '<M-d>1', function()
        harpoon:list():remove(1)
      end, { desc = 'Harpoon: Remove file 1' })

      vim.keymap.set('n', '<M-d>2', function()
        harpoon:list():remove(2)
      end, { desc = 'Harpoon: Remove file 2' })

      vim.keymap.set('n', '<M-d>3', function()
        harpoon:list():remove(3)
      end, { desc = 'Harpoon: Remove file 3' })

      vim.keymap.set('n', '<M-d>4', function()
        harpoon:list():remove(4)
      end, { desc = 'Harpoon: Remove file 4' })
    end,
  },
}
