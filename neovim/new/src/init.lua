vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

-- Proper functions
local new_cmd = vim.api.nvim_create_user_command
new_cmd("CPI",function ()
  vim.cmd([[0r $CPDIR/home/artrivas/cp/template.cpp]])
end,{})

vim.api.nvim_set_keymap('', '<F8>', ":write <bar> vsplit <bar> term g++ -std=c++20 -Wall -Wextra -fsanitize=address,undefined % -o %:p:h/%:t:r.out && ./%:r.out<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap('', '<F9>', ":write <bar> vsplit <bar> term g++ -std=c++20 -Wall -Wextra -fsanitize=address,undefined % -o %:p:h/%:t:r.out && ./%:r.out < input.txt<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap('', '<F5>', ":%y+ <CR>", { noremap = true, silent = true })
