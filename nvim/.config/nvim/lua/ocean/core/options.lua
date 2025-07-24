vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- visualisstion and cursor
opt.wrap = false
opt.cursorline = true
opt.cursorlineopt = "number" -- Resaltar solo el número de línea

opt.ignorecase = true
opt.smartcase = true

-- visualisstion
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.scrolloff = 10
opt.hlsearch = false
opt.incsearch = true

-- buffer amd file
opt.hidden = true    -- Permite cambiar de buffer sin guardar
opt.autoread = true  -- Recargar archivo si cambia externamente
opt.updatetime = 200 -- Reduce el tiempo para eventos como LSP y Git

-- mice
opt.mouse = "a"
-- opt.pumblend = 20

-- windows and splits
opt.splitright = true
opt.splitbelow = true

-- autocomplete
opt.completeopt = { "menuone", "noselect" }
opt.pumheight = 10 -- Maximum number of entries in a popup

-- backspace
opt.backspace = "indent,eol,start"

-- invisible chars
opt.fillchars = { eob = " " } -- Eliminar ~ en líneas vacías

-- better completeopt
opt.wildmode = "longest:full,full"
opt.wildignore = { "*.o", "*.obj", "*.bin", "*.exe", "*.jpg", "*.png", "*.gif", "*.zip", "*.tar.gz" }

-- performance
opt.lazyredraw = true
opt.shortmess:append("c")
opt.formatoptions:remove({ "c", "r", "o" })

vim.cmd([[
  highlight Pmenu guibg=NONE guifg=NONE
  highlight PmenuSel guibg=#3B4252 guifg=#E5E9F0 gui=bold
  highlight FloatBorder guibg=#1E1E2E guifg=#3B4252
]])

-- Hide statusline
vim.opt.laststatus = 0

vim.api.nvim_set_hl(0, "StatusLine", { link = "Normal" })
vim.api.nvim_set_hl(0, "StatusLineNC", { link = "Normal" })

vim.opt.statusline = "%{repeat('─',winwidth('.'))}"
vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")
vim.o.conceallevel = 2
vim.o.concealcursor = "nc"
