return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline", -- 🔹 Autocompletado en línea de comandos
        "hrsh7th/cmp-nvim-lsp",
        {
            "L3MON4D3/LuaSnip",
            version = "v2.*",
            build = "make install_jsregexp",
        },
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
        "onsails/lspkind.nvim",
        "Exafunction/codeium.nvim", -- 🔹 Integración de Codeium
        "hrsh7th/cmp-emoji",
        "hrsh7th/cmp-nvim-lua",
    },

    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local lspkind = require("lspkind")

        -- Cargar snippets desde VSCode
        require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })

        -- Configuración de nvim-cmp
        local sources = {
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "buffer" },
            { name = "path" },
            { name = "emoji" },
            { name = "nvim_lua" },
        }

        if pcall(require, "codeium") then
            table.insert(sources, { name = "codeium" })
        end

        cmp.setup({
            preselect = "item",
            completion = {
                completeopt = "menu,menuone,preview,noselect",
            },

            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },

            mapping = cmp.mapping.preset.insert({
                ["<C-k>"] = cmp.mapping.select_prev_item(),
                ["<C-j>"] = cmp.mapping.select_next_item(),
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),

                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),

            sources = sources,

window = {
  completion = cmp.config.window.bordered({
    border = "rounded",
    winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
  }),
  documentation = cmp.config.window.bordered({
    border = "rounded",
    winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
  }),
},

            formatting = {
                format = lspkind.cmp_format({
                    maxwidth = 50,
                    ellipsis_char = "...",
                }),
            },
        })

        -- 🔹 Autocompletado en búsqueda (`/` y `?`)
        cmp.setup.cmdline({ "/", "?" }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" },
            },
        })

        -- 🔹 Autocompletado en la línea de comandos (`:`)
        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "path" },    -- Autocompletado de rutas
            }, {
                { name = "cmdline" }, -- Autocompletado de comandos de Neovim
            }),
        })
    end,
}

