return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
    cmd = "Trouble",
    opts = {
        -- Configuración global de Trouble
        auto_open = false,  -- No abrir automáticamente
        auto_close = true,  -- Cerrar automáticamente si está vacío
        position = "right", -- Posición horizontal
        width = 40,         -- Ancho de la ventana

    },
    keys = {
        { "<leader>xw", "<cmd>Trouble diagnostics toggle<CR>",              desc = "Workspace diagnostics" },
        { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Document diagnostics" },
        { "<leader>xq", "<cmd>Trouble quickfix toggle<CR>",                 desc = "Quickfix list" },
        { "<leader>xl", "<cmd>Trouble loclist toggle<CR>",                  desc = "Location list" },
        { "<leader>xt", "<cmd>Trouble todo toggle<CR>",                     desc = "Todos list" },
    },
}
