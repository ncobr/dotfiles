-- Set leader key
vim.g.mapleader = " "

local keymap = vim.keymap.set
local opts = { silent = true, noremap = true }

-- General Keymaps
keymap("n", "<leader>w", function() vim.cmd("w") end, { desc = "Save file" })
keymap("n", "<leader>qa", function() vim.cmd("qa") end, { desc = "Quit all buffers" })

-- Visual mode text movement
keymap("v", "<Up>", ":m '<-2<CR>gv=gv", { desc = "Move text up in visual mode", silent = true })
keymap("v", "<Down>", ":m '>+1<CR>gv=gv", { desc = "Move text down in visual mode", silent = true })

-- Exit insert mode
keymap("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- Clear search highlights
keymap("n", "<leader>nh", function() vim.cmd("nohlsearch") end, { desc = "Clear search highlights" })

-- Increment and decrement numbers
keymap("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- Window management
keymap("n", "<leader>sv", function() vim.cmd("vsplit") end, { desc = "Split window vertically" })
keymap("n", "<leader>sh", function() vim.cmd("split") end, { desc = "Split window horizontally" })
keymap("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap("n", "<leader>sx", function() vim.cmd("close") end, { desc = "Close current split" })

-- Tab management
keymap("n", "<leader>to", function() vim.cmd("tabnew") end, { desc = "Open new tab" })
keymap("n", "<leader>tx", function() vim.cmd("tabclose") end, { desc = "Close current tab" })
keymap("n", "<leader>tn", function() vim.cmd("tabnext") end, { desc = "Go to next tab" })
keymap("n", "<leader>tp", function() vim.cmd("tabprev") end, { desc = "Go to previous tab" })
keymap("n", "<leader>tf", function() vim.cmd("tabnew %") end, { desc = "Open current buffer in new tab" })

-- Window resizing
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +5<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -5<CR>", opts)

-- Window navigation
keymap("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Move to window below" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Move to window above" })

-- Theme switcher
keymap("n", "<leader>th", "<cmd>Themery<CR>", { desc = "Open theme switcher" })


-- Plugin Keymaps

-- ToggleTerm
keymap("n", "<leader>tt", "<cmd>ToggleTerm<CR>", { noremap = true, silent = true, desc = "Open ToggleTerm" })
keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { desc = "Open LazyGit" })
keymap("n", "<leader>nt", "<cmd>lua _NODE_TOGGLE()<CR>", { desc = "Open Node REPL" })
keymap("n", "<leader>np", "<cmd>lua _PYTHON_TOGGLE()<CR>", { desc = "Open Python REPL" })

function _G.set_terminal_keymaps()
    local opts = { noremap = true, buffer = 0 }
    keymap("t", "<esc>", [[<C-\><C-n>]], opts)
    keymap("t", "jk", [[<C-\><C-n>]], opts)
    keymap("t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
    keymap("t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
    keymap("t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
    keymap("t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
end

-- Linting
keymap("n", "<leader>l", function()
  require("lint").try_lint()
  vim.notify("Linting completed for current file!", vim.log.levels.INFO)
end, { desc = "Trigger linting for current file" })

keymap("n", "<leader>la", function()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    require("lint").try_lint(bufnr)
  end
  vim.notify("Linting completed for all open buffers!", vim.log.levels.INFO)
end, { desc = "Trigger linting for all open files" })

-- Writing
keymap("n", "<leader>zp", ":MarkdownPreviewToggle<CR>", { desc = "Toggle Markdown Preview" })
keymap("n", "<leader>zg", ":Glow<CR>", { desc = "Toggle Glow Preview" })
keymap("n", "<leader>zz", ":ZenMode<CR>", { desc = "Toggle Zen Mode" })