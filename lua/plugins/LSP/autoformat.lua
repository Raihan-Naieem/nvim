return {

  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = function()
      -- Prettier resolves `--plugin` relative to the project cwd, so a bare
      -- package name only works in projects that installed the plugin. Keep a
      -- copy outside Mason (which wipes extra packages on update) and pass an
      -- absolute path instead.
      -- Update: cd ~/.local/share/nvim/prettier-tailwind && npm update
      local tailwind_plugin = vim.fn.stdpath 'data' .. '/prettier-tailwind/node_modules/prettier-plugin-tailwindcss/dist/index.mjs'
      -- NOTE: `prepend_args` must live under `formatters`, not in
      -- `formatters_by_ft`, otherwise conform silently ignores it.
      local prettier = {}
      if vim.uv.fs_stat(tailwind_plugin) then
        prettier.prepend_args = { '--plugin', tailwind_plugin }
      end

      return {
        notify_on_error = false,
        format_on_save = function(bufnr)
          local disable_filetypes = { c = true, cpp = true }
          if disable_filetypes[vim.bo[bufnr].filetype] then
            return nil
          else
            return {
              timeout_ms = 500,
              lsp_format = 'fallback',
            }
          end
        end,
        formatters = {
          prettier = prettier,
        },
        formatters_by_ft = {
          lua = { 'stylua' },
          python = { 'ruff', 'isort', 'black', stop_after_first = true },

          javascript = { 'prettier' },
          javascriptreact = { 'prettier' },
          typescript = { 'prettier' },
          typescriptreact = { 'prettier' },

          html = { 'prettier' },
          css = { 'prettier' },
          json = { 'prettier' },
        },
      }
    end,
  },
}
