return {

    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    main = "ibl",
    version = "*",

    config = function()
require("ibl").setup()
    end,
}
