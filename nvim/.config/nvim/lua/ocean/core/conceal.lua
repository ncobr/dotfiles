vim.api.nvim_create_autocmd("FileType", {
    pattern = {"markdown", "vimwiki"},
    callback = function()
        vim.opt.conceallevel = 2
    end
})