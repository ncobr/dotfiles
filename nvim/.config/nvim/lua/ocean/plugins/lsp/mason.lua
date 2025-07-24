return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        local mason_ok, mason = pcall(require, "mason")
        local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")

        if not mason_ok or not mason_lspconfig_ok then
            return
        end

        -- 🔹 Configuración de mason.nvim
        mason.setup({
            ui = {
                icons = {
                    package_installed = "✔",
                    package_pending = "➜",
                    package_uninstalled = "✘",
                },
            },
        })

        -- 🔹 Configuración de mason-lspconfig
        mason_lspconfig.setup({
            ensure_installed = { -- Lista de servidores que deseas instalar automáticamente
                "lua_ls",
                "pyright",
                "html",
                "cssls",
                "jsonls",
                "bashls",
                "gopls",
                "clangd",
            },
            automatic_installation = true, -- Instala automáticamente servidores no configurados
        })
    end,
}

