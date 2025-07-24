return {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = function()
        require("dressing").setup({
            input = {
                -- Configura la apariencia de las ventanas flotantes para entradas
                enabled = true,
                title_pos = "left",
                default_prompt = "➤ ",
                border = "rounded", -- Bordes redondeados
                win_options = {
                    winblend = 10,  -- Transparencia del fondo
                    wrap = false,   -- Evita que el texto se ajuste
                },
                -- Ajusta el tamaño de la ventana de entrada
                prefer_width = 40,
                max_width = { 140, 0.9 }, -- 140 columnas o 90% del ancho
                min_width = { 20, 0.2 },  -- 20 columnas o 20% del ancho
                -- Mapeos personalizados en la ventana de entrada
                mappings = {
                    n = {
                        ["q"] = "Close", -- Salir con `q`
                    },
                    i = {
                        ["<C-c>"] = "Close", -- Salir con Ctrl+C
                        ["<C-u>"] = "Clear", -- Limpiar entrada con Ctrl+U
                    },
                },
            },
            select = {
                -- Configura la apariencia de las ventanas flotantes para selección
                enabled = true,
                backend = { "telescope", "fzf", "builtin" }, -- Prioridad de backends
                telescope = nil,                             -- Usa la configuración predeterminada de Telescope
                fzf = {
                    window = {
                        width = 0.9,
                        height = 0.6,
                    },
                },
                builtin = {
                    border = "rounded", -- Bordes redondeados
                    win_options = {
                        winblend = 10,  -- Transparencia del fondo
                    },
                    width = 0.9,        -- 90% del ancho
                    max_height = 0.7,   -- 70% de la altura
                },
            },
        })
    end,
}
