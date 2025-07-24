return {
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
    dependencies = {
        "hrsh7th/nvim-cmp",
    },
    config = function()
        local autopairs_ok, autopairs = pcall(require, "nvim-autopairs")
        if not autopairs_ok then
            return
        end

        autopairs.setup {
            check_ts = true,
            ts_config = {
                lua = { "string", "source" },
                javascript = { "string", "template_string" },
                java = false,
            },
            disable_filetype = { "TelescopePrompt", "spectre_panel" },

            fast_wrap = {
                map = "<M-e>",
                chars = { "{", "[", "(", '"', "'" },
                pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
                offset = 0,
                end_key = "$",
                keys = "qwertyuiopzxcvbnmasdfghjkl",
                check_comma = true,
                highlight = "PmenuSel",
                highlight_grey = "LineNr",
            },
        }


        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        local cmp_ok, cmp = pcall(require, "cmp")
        if cmp_ok then
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end
    end
}
