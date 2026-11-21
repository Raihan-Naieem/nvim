-- .NET / ASP.NET development via easy-dotnet.nvim.
--
-- Command-only workflow: no keymaps are registered by this config. The plugin
-- still has its own keys inside its UI windows (test runner, debugger, managed
-- terminal) because those are required to navigate them.
--
-- Requires:
--   dotnet tool install -g EasyDotnet
--   `~/.dotnet/tools` on PATH
return {
  {
    'GustavEikaas/easy-dotnet.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'mfussenegger/nvim-dap',
      'folke/snacks.nvim',
    },
    opts = {
      picker = 'snacks',

      -- JSON5 for appsettings/launchSettings/secrets (comments allowed).
      enable_filetypes = true,

      -- Do not add <leader>ar to .csproj/.fsproj buffers.
      csproj_mappings = false,
      fsproj_mappings = false,

      auto_bootstrap_namespace = { enabled = false },

      lsp = {
        enabled = true,
        -- Start Roslyn when a .cs/.razor buffer is opened, not at startup.
        preload_roslyn = false,
      },

      test_runner = {
        -- Suppresses easy-dotnet's C# buffer-local test keymaps and signs.
        neotest_integration = true,
        -- Do not discover tests in the background; use :Dotnet testrunner.
        auto_start_testrunner = false,
      },

      -- NuGet completion inside .csproj files.
      projx_lsp = { enabled = true },

      debugger = { auto_register_dap = true },
    },
  },
}
