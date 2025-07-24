return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    keys = {
        { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Toggle NeoTree" },
    },
    config = function()
        require("nvim-tree").setup()
    end,
}
