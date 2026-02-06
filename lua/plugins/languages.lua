return {
  -- Go
  {
    "fatih/vim-go",
    ft = { "go" },
    run = ":GoUpdateBinaries",
  },

  -- Rust
  {
    "simrat39/rust-tools.nvim",
    ft = { "rust" },
    config = function()
      require("rust-tools").setup({
        server = {
          settings = {
            ["rust-analyzer"] = {
              cargo = { allFeatures = true },
              checkOnSave = { command = "clippy" },
            },
          },
        },
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("lspconfig").vls.setup({
        filetypes = { "vue" },
      })

      require("lspconfig").tailwindcss.setup({
        filetypes = { "vue", "html", "javascript", "typescript", "javascriptreact", "typescriptreact" },
        root_dir = require("lspconfig.util").root_pattern(
          "tailwind.config.js",
          "tailwind.config.ts",
          "postcss.config.js",
          "postcss.config.ts",
          "package.json",
          ".git"
        ),
        settings = {
          tailwindCSS = {
            experimental = {
              classRegex = {
                -- For Vue <template> classes
                'class="([^"]*)"',
                -- For Vue SFC style blocks
                "class:\\s*=\\s*[\"\\'][^\"']*[\"\\']",
              },
            },
          },
        },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "go", "rust", "vue", "javascript", "typescript", "css", "html" },
        highlight = { enable = true },
      })
    end,
  },
}
