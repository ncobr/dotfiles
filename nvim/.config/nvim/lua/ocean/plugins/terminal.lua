return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        local toggleterm = require("toggleterm")

        toggleterm.setup({
            size = 20,
            open_mapping = [[<c-\>]],
            hide_numbers = true,
            shade_filetypes = {},
            shade_terminals = true,
            shading_factor = 2,
            start_in_insert = true,
            insert_mappings = true,
            persist_size = true,
            direction = "float",
            close_on_exit = true,
            shell = vim.o.shell,
            float_opts = {
                border = "curved",
                winblend = 0, -- Ajuste para mejorar transparencia
                highlights = {
                    border = "Normal",
                    background = "Normal",
                },
            },
        })

        vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

        local Terminal = require("toggleterm.terminal").Terminal
        local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
        function _LAZYGIT_TOGGLE() lazygit:toggle() end

        local node = Terminal:new({ cmd = "node", hidden = true })
        function _NODE_TOGGLE() node:toggle() end

        local python = Terminal:new({ cmd = "python3", hidden = true })
        function _PYTHON_TOGGLE() python:toggle() end
    end,
}

