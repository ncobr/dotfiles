return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = { "windwp/nvim-ts-autotag" },

  config = function()
    local treesitter = require("nvim-treesitter.configs")

    treesitter.setup({
      highlight = { enable = true },
      indent = { enable = true }, -- Habilita indentación automática basada en Treesitter
      autotag = { enable = true }, -- Cierra automáticamente etiquetas HTML/JSX

      ensure_installed = {
        "json", "javascript", "typescript", "markdown", "markdown_inline",
        "bash", "lua", "vim", "vimdoc", "gitignore", "c", "cpp", "python"
      },

      sync_install = false, -- Evita bloqueos al instalar parsers
      auto_install = true,  -- Instala automáticamente parsers cuando sea necesario

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    })
  end,
}

