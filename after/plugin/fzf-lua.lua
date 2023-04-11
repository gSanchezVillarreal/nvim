local fzf = require('fzf-lua')
vim.keymap.set('n', '<leader>pf', fzf.files, {})
vim.keymap.set('n', '<C-p>', fzf.git_files, {})
vim.keymap.set('n', '<leader>pg', fzf.grep_project, {})

