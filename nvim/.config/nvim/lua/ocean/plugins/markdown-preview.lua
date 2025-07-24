return {
    "iamcco/markdown-preview.nvim",

    build = "cd app && npm install",
    init = function()
        vim.g.mkdp_filetypes = { "markdown", "vimwiki" }
    end,
    ft = { "markdown", "vimwiki" },
}

