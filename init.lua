vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.shell = 'pwsh'
vim.opt.shellcmdflag = '-NoLogo -Command'
vim.opt.shellquote = '"'
vim.opt.shellxquote = ''
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'no'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 10
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
vim.keymap.set('n', 'd', '"_d', { noremap = true })
vim.keymap.set('n', 'H', '^', { noremap = true })
vim.keymap.set('n', 'xx', 'yydd')
vim.keymap.set('n', '<C-k>', ':move .-2<CR>==', { noremap = true, silent = true })
vim.keymap.set('n', '<C-j>', ':move .+1<CR>==', { noremap = true, silent = true })
vim.keymap.set('n', 'gl', '<C-O>', { noremap = true, silent = true })
vim.keymap.set('n', 't', '<cmd>ToggleTerm direction=vertical size=40<CR>')
vim.keymap.set('n', 'fi', '<cmd>NvimTreeToggle<CR>')
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.diagnostic.config { virtual_text = false }
vim.keymap.set('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
-- packages
vim.pack.add{
  { src = 'https://github.com/neovim/nvim-lspconfig' },
}
vim.lsp.enable("roslyn_ls")
vim.lsp.config("roslyn_ls", {
	filetypes = {"cs", "razor"},
	settings = {
		["csharp|background_analysis"] = {
			dotnet_analyzer_diagnostics_scope = "openFiles",
			dotnet_compiler_diagnostics_scope = "openFiles",
		}
	}
})
-- theme
vim.pack.add {
	{ src = 'https://github.com/TheAjaykrishnanR/sublime-material-theme.nvim' }
}
require("sublime-material").setup({
  style = "dark",
})
vim.cmd.colorscheme("sublime-material")

-- autocomplete
-- Configure native popup menu behavior
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Enable omnifunc automatically when an LSP attaches to a buffer
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.bo[args.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
  end,
})

-- Auto-trigger the completion menu while typing letters or triggers (e.g., '.', ':')
vim.api.nvim_create_autocmd("InsertCharPre", {
  callback = function()
    local char = vim.v.char
    -- Trigger on alphanumeric chars, underscores, or common dot notation
    if char:match("[%w_%.%:%->]") and vim.fn.pumvisible() == 0 and vim.bo.omnifunc ~= "" then
      vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes("<C-x><C-o>", true, false, true),
        "n",
        true
      )
    end
  end,
})
-- gd to lsp definition
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local opts = { buffer = event.buf }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  end,
})
