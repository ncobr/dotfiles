local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Crear grupos organizados de autocmds
local bufcheck_group = augroup('BufCheck', { clear = true })
local save_trigger_group = augroup('SaveTrigger', { clear = true })

-- 📌 Formateo automático al guardar (solo si hay un servidor LSP activo)
autocmd('BufWritePost', {
    group = save_trigger_group,
    callback = function()
        local clients = vim.lsp.get_clients({ bufnr = 0 }) -- Obtener clientes LSP activos para el buffer actual
        if #clients > 0 then
            vim.lsp.buf.format({ async = true })
        end
    end,
})


-- 📌 Eliminar espacios en blanco al final antes de guardar (método seguro)
autocmd('BufWritePre', {
    group = save_trigger_group,
    pattern = '*',
    callback = function()
        local save_cursor = vim.api.nvim_win_get_cursor(0) -- Guardar posición del cursor
        vim.cmd([[keeppatterns %s/\s\+$//e]])
        vim.api.nvim_win_set_cursor(0, save_cursor) -- Restaurar posición del cursor
    end,
})

-- 📌 Configuración de terminal: inicia en modo insert y bloquea altura de ventana
autocmd('TermOpen', {
    group = bufcheck_group,
    pattern = '*',
    command = 'startinsert | setlocal winfixheight',
})

-- 📌 Recargar buffer automáticamente si cambia externamente
autocmd({ 'FocusGained', 'BufEnter' }, {
    group = bufcheck_group,
    pattern = '*',
    command = 'checktime',
})

-- 📌 Resaltar automáticamente texto copiado
autocmd('TextYankPost', {
    group = bufcheck_group,
    callback = function()
        vim.hl.on_yank({ higroup = 'IncSearch', timeout = 200 })
    end,
})

-- 📌 Alternar entre número absoluto y relativo según el modo
autocmd('InsertEnter', {
    group = bufcheck_group,
    callback = function()
        vim.opt_local.relativenumber = false
    end,
})
autocmd('InsertLeave', {
    group = bufcheck_group,
    callback = function()
        vim.opt_local.relativenumber = true
    end,
})

-- 📌 Cerrar terminal con `<Esc>`
autocmd('TermOpen', {
    group = bufcheck_group,
    pattern = '*',
    callback = function()
        vim.api.nvim_buf_set_keymap(0, 'n', '<Esc>', '<Cmd>close<CR>', { noremap = true, silent = true })
    end,
})

-- 📌 Desactivar caracteres invisibles al iniciar Neovim
autocmd('VimEnter', {
    callback = function()
        vim.opt.list = false
    end,
})

