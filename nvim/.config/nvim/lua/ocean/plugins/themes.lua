return {
    {
        "zaldih/themery.nvim",
        lazy = false,
        priority = 1000,
        dependencies = {
            { "catppuccin/nvim",              name = "catppuccin" },
            { "rose-pine/neovim",             name = "rose-pine" },
            { "ellisonleao/gruvbox.nvim",     name = "gruvbox" },
            { "sainnhe/everforest",           name = "everforest" },
            { "Mofiqul/vscode.nvim",          name = "vscode" },
            { "ntk148v/komau.vim",            name = "komau" },
            { "alexxGmZ/e-ink.nvim",          name = "e-ink" },
            { "zenbones-theme/zenbones.nvim", dependencies = "rktjmp/lush.nvim", name = "zenbones" },
            { "projekt0n/github-nvim-theme",  name = "github-nvim-theme" },
            { "wtfox/jellybeans.nvim",        name = "jellybeans" },
        },
        config = function()
            require("themery").setup({
                themes = {
                    -- Listado con hooks para setup correcto
                    {
                        name = "Catppuccin",
                        colorscheme = "catppuccin",
                        before = "vim.o.background = 'dark'",
                        after = "require('catppuccin').setup{ flavour = 'mocha' }",
                    },
                    {
                        name = "Rose Pine",
                        colorscheme = "rose-pine",
                        before = "vim.o.background = 'dark'",
                        after = "require('rose-pine').setup()",
                    },
                    {
                        name = "Gruvbox",
                        colorscheme = "gruvbox",
                        before = "vim.o.background = 'dark'",
                        after = "require('gruvbox').setup()",
                    },
                    {
                        name = "Everforest",
                        colorscheme = "everforest",
                        before = "vim.o.background = 'dark'",
                    },
                    {
                        name = "VSCode",
                        colorscheme = "vscode",
                        before = "vim.o.background = 'dark'",
                    },
                    {
                        name = "Komau",
                        colorscheme = "komau",
                        before = "vim.o.background = 'dark'",
                    },
                    {
                        name = "E‑Ink",
                        colorscheme = "e‑ink",
                        before = "vim.o.background = 'dark'",
                    },
                    {
                        name = "Zennbones",
                        colorscheme = "zenbones",
                        before = "vim.o.background = 'dark'",
                        after = [[
                            vim.g.zenbones_lightness = "dim"
                            vim.g.zenbones_darken_comments = 10
                            vim.g.zenbones_lighten_comments = 10
                            vim.g.zenbones_italic_comments = true
                        ]],
                    },
                    {
                        name = "GitHub",
                        colorscheme = "github_dark",
                        before = "vim.o.background = 'dark'",
                    },
                    {
                        name = "Jellybeans",
                        colorscheme = "jellybeans",
                        before = "vim.o.background = 'dark'",
                    },
                },
                livePreview = true,
            })
        end,
    }
}
