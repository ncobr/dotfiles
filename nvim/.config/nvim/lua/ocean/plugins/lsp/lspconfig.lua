return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
        { "folke/neodev.nvim",                   opts = {} },
    },
    config = function()
        local lspconfig = require("lspconfig")
        local mason_lspconfig = require("mason-lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        local keymap = vim.keymap

        -- 🔹 Configuración de diagnósticos
        vim.diagnostic.config({
            underline = false,
            virtual_text = false,
            update_in_insert = false,
            severity_sort = true,
            float = { border = "rounded" },
            signs = true,
        })

        -- 🔹 Iconos de diagnóstico personalizados
        local signs = { Error = "", Warn = "", Hint = "󰠠", Info = "" }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        -- 🔹 Manejo de capacidades para autocompletado
        local capabilities = cmp_nvim_lsp.default_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true

        -- 🔹 Keymaps para LSP
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                local opts = { buffer = ev.buf, silent = true }

                keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)
                keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
                keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
                keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
                keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
                keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
                keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
                keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
                keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
                keymap.set("n", "K", vim.lsp.buf.hover, opts)
                keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
            end,
        })

        -- 🔹 Configuración para servidores instalados con Mason
        mason_lspconfig.setup({
            ensure_installed = {
                "bashls",
                "clangd",
                "cssls",
                "gopls",
                "html",
                "jsonls",
                "lua_ls",
                "pyright",
            },
            handlers = {
                -- Configuración por defecto
                function(server_name)
                    lspconfig[server_name].setup({
                        capabilities = capabilities,
                    })
                end,

                -- Configuración específica para Lua
                ["lua_ls"] = function()
                    lspconfig["lua_ls"].setup({
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim" },
                                },
                                workspace = {
                                    library = vim.api.nvim_get_runtime_file("", true),
                                    checkThirdParty = false,
                                },
                                completion = {
                                    callSnippet = "Replace",
                                },
                            },
                        },
                    })
                end,

                -- Configuración específica para Clangd
                ["clangd"] = function()
                    lspconfig.clangd.setup({
                        capabilities = capabilities,
                        on_attach = function(client, bufnr)
                            client.server_capabilities.documentFormattingProvider = true
                            vim.api.nvim_buf_set_option(bufnr, "shiftwidth", 4) -- Indentación de 4 espacios
                            vim.api.nvim_buf_set_option(bufnr, "tabstop", 4)    -- Configura tabulaciones en 4 espacios
                        end,
                        settings = {
                            ["clangd"] = {
                                fallbackFlags = { "--style={IndentWidth: 4}" },
                            },
                        },
                    })
                end,
            },
        })
    end,
}