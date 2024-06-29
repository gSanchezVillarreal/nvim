local lsp = require('lsp-zero').preset({})

lsp.preset("recomended")

lsp.ensure_installed({
	'tsserver',
	'eslint',
	'rust_analyzer',
	'lua_ls',
	'pyright'
	})

lsp.configure('lua_ls', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})
lsp.set_preferences({
	suggest_lsp_servers = false,
	sign_icons = {
		error = 'E',
		warn = 'W',
		hint = 'H',
		info = 'I'
	}
})

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
require('lspconfig').html.setup({
    opts = {
        settings = {
            html = {
                format = {
                    templating = true,
                    wrapLineLength = 120,
                    wrapAttributes = "auto",
                },
                hover = {
                    documentation = true,
                    references = true,
                },
                suggest = {
                    html5 = true
                }
            }
        },
    },
    filetypes = { "htmldjango","html","templ" }
})

require('lspconfig').htmx.setup({
    filetypes = { "htmldjango","html","templ", "javascriptreact", "typescriptreact" }
})
require('lspconfig').cssls.setup({})
require('lspconfig').tailwindcss.setup({
    cmd = { "tailwindcss-language-server", "--stdio" },
    filetypes = {"htmldjango", "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
    root_dir = require'lspconfig'.util.root_pattern("theme/static_src/tailwind.config.js","tailwind.config.js", "tailwind.config.cjs", "tailwind.config.ts", "tailwind.config.tsx", "tailwind.config.json", "tailwind.config.yaml", "tailwind.config.yml", "tailwind.config.json5"),
})
require('lspconfig').rust_analyzer.setup({})
require('lspconfig').omnisharp.setup({})
require('lspconfig').clangd.setup({})
require('lspconfig').pyright.setup({
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "off"
      }
    }
  }
})
require('lspconfig').gdscript.setup({
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
})
lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup()
local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_action = require('lsp-zero').cmp_action()

require('luasnip.loaders.from_vscode').lazy_load()
cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end
    },
    mapping = {
    -- `Enter` key to confirm completion
    ['<C-y>'] = cmp.mapping.confirm({select = true}),
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    -- Ctrl+Space to trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete(),
    -- Navigate between snippet placeholder
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
    },
    sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip'},
    })
})
vim.diagnostic.config({
	virtual_text = true
})
