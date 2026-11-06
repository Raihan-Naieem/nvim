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
    opts = {
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
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'ruff', 'isort', 'black', stop_after_first = true },

        javascript = { 'prettier', prepend_args = { '--plugin', 'prettier-plugin-tailwindcss' } },
        javascriptreact = { 'prettier', prepend_args = { '--plugin', 'prettier-plugin-tailwindcss' } },
        typescript = { 'prettier', prepend_args = { '--plugin', 'prettier-plugin-tailwindcss' } },
        typescriptreact = { 'prettier', prepend_args = { '--plugin', 'prettier-plugin-tailwindcss' } },

        html = { 'prettier' },
        css = { 'prettier' },
        json = { 'prettier' },
      },
    },
  },
}
