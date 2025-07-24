return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-fzf-native.nvim",
        "nvim-tree/nvim-web-devicons",
        "nvim-telescope/telescope-file-browser.nvim",
    },

    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")
        local fb_actions = require("telescope._extensions.file_browser.actions")

        -- Configuración de Telescope
        telescope.setup({
            defaults = {
                path_display = { "absolute" },
                find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                        ["<Esc>"] = actions.close,
                        ["<C-u>"] = actions.preview_scrolling_up,
                        ["<C-d>"] = actions.preview_scrolling_down,
                    },
                },
            },
            extensions = {
                file_browser = {
                    hijack_netrw = true,
                    hidden = true, -- 🔹 Mostrar archivos y carpetas ocultas
                    respect_gitignore = false,
                    mappings = {
                        ["i"] = {
                            ["<CR>"] = function(prompt_bufnr)
                                local selection = action_state.get_selected_entry()
                                if not selection or not selection.path then return end -- 🔹 Evita errores

                                local is_dir = vim.fn.isdirectory(selection.path) == 1
                                actions.close(prompt_bufnr) -- 🔹 Cerrar Telescope antes de abrir

                                if is_dir then
                                    -- 🔹 Si es un directorio, abrir en la misma ventana con opción de regresar
                                    require("telescope").extensions.file_browser.file_browser({
                                        cwd = selection.path,
                                        respect_gitignore = false,
                                        hidden = true,
                                        grouped = true,
                                    })
                                else
                                    -- 🔹 Si es un archivo, abrirlo en una nueva pestaña
                                    vim.cmd("tabedit " .. selection.path)
                                end
                            end,
                            ["<C-n>"] = fb_actions.create,
                            ["<C-r>"] = fb_actions.rename,
                            ["<C-d>"] = fb_actions.remove,
                            ["<C-y>"] = fb_actions.copy,
                            ["<C-x>"] = fb_actions.move,
                        },
                        ["n"] = {
                            ["n"] = fb_actions.create,
                            ["r"] = fb_actions.rename,
                            ["d"] = fb_actions.remove,
                            ["y"] = fb_actions.copy,
                            ["x"] = fb_actions.move,
                        },
                    },
                },
            },
        })

        -- Cargar las extensiones
        telescope.load_extension("file_browser")

        -- Mapeos de teclas para abrir Telescope
        local keymap = vim.keymap
        keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Fuzzy find files in cwd" })
        keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Fuzzy find recent files" })
        keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<CR>", { desc = "Find string in cwd" })
        keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<CR>", { desc = "Find string under cursor in cwd" })
        keymap.set("n", "<leader>fb", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>",
            { desc = "Open file browser" })
    end,
}