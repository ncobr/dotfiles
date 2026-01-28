return {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
        "nvim-telescope/telescope.nvim",
    },
    opts = {
        workspaces = {
            {
                name = "202502-Courses",
                path = "/home/nicolas/202502/",
            },
        },

        -- Optional, for templates (see below)
        templates = {
            folder = "templates",
            date_format = "%Y-%m-%d",
            time_format = "%H:%M",
        },

        -- How to interpret links
        follow_url_func = function(url)
            -- Open PDFs with Zathura, otherwise use the default browser
            if url:match "%.pdf$" then
                vim.fn.jobstart({ "zathura", url }, { detach = true })
            else
                vim.fn.jobstart({ "xdg-open", url }, { detach = true })
            end
        end,

        -- For finding notes
        note_id_func = function(title)
            -- Create note IDs in a way that is compatible with your existing files
            return title
        end,

        -- Completion support
        completion = {
            nvim_cmp = true,
            min_chars = 2,
        },

        -- Optional, configure keymappings
        mappings = {
            -- Overrides the 'gf' mapping to work on markdown/wiki links.
            ["gf"] = {
                action = function()
                    return require("obsidian").util.gf_passthrough()
                end,
                opts = { noremap = false, expr = true, buffer = true },
            },
        },
    },
}
