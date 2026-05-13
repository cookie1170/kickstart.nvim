-- sets up the language server for diagnostics, code actions, etc

-- the servers here will be automatically added by code below
---@type table<string, vim.lsp.Config>
local servers = {
  rust_analyzer = {
    settings = {
      ['rust-analyzer'] = {
        assist = {
          preferSelf = true, -- prefer `Self` over the type name
        },
        check = {
          command = 'clippy', -- use clippy (more lints)
        },
      },
    },
  }, -- rust

  tombi = {
    settings = {
      tombi = {
        lint = {
          rules = {
            ['tables-out-of-order'] = 'off',
          },
        },
      },
    },
  }, -- toml

  ['json-lsp'] = {},

  ['just-lsp'] = {}, -- just (command runner)

  superhtml = {}, -- HTML

  fish_lsp = {}, -- fish scripts

  stylua = {}, -- used to format lua code

  -- special lua config, as recommended by neovim help docs
  lua_ls = {
    on_init = function(client)
      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then return end
      end

      ---@diagnostic disable-next-line: param-type-mismatch
      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = {
          version = 'LuaJIT',
          path = { 'lua/?.lua', 'lua/?/init.lua' },
        },
        workspace = {
          checkThirdParty = false,
          -- adds nvim runtime files to the library, except for the .config directory (https://github.com/neovim/nvim-lspconfig/issues/3189#issuecomment-3021345989)
          library = vim.tbl_filter(function(d) return not d:match(vim.fn.stdpath 'config' .. '/?a?f?t?e?r?') end, vim.api.nvim_get_runtime_file('', true)),
        },
      })
    end,
    settings = {
      Lua = {},
    },
  },
}

-- status updates for the lsp
vim.pack.add { gh 'j-hui/fidget.nvim' }
require('fidget').setup {}

--  this function gets run when an lsp attaches to a particular buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    -- rename the variable under your cursor
    -- most language servers support renaming across files, etc
    map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

    -- execute a code action, usually your cursor needs to be on top of an error
    -- or a suggestion from your lsp for this to activate
    map('gra', vim.lsp.buf.code_action, '[G]oto code [A]ction', { 'n', 'x' })

    -- WARN: This is not Goto Definition, this is Goto Declaration
    --  For example, in C this would take you to the header
    map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

    -- the following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while
    --    See `:help CursorHold` for information about when this is executed
    --
    -- when you move your cursor, the highlights will be cleared (the second autocommand)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method('textDocument/documentHighlight', event.buf) then
      local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
        end,
      })
    end

    -- the following code creates a keymap to toggle inlay hints in your
    -- code, if the language server you are using supports them
    --
    -- this may be unwanted, since they displace some of your code
    if client and client:supports_method('textDocument/inlayHint', event.buf) then
      map('<leader>th', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end, '[T]oggle inlay [H]ints')
    end
  end,
})

-- ensure the servers and tools above are installed
local ensure_installed = vim.tbl_keys(servers or {})

vim.pack.add {
  gh 'neovim/nvim-lspconfig',
  gh 'mason-org/mason.nvim',
  gh 'mason-org/mason-lspconfig.nvim',
  gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
}

require('mason').setup {}

require('mason-tool-installer').setup { ensure_installed = ensure_installed }

for name, server in pairs(servers) do
  vim.lsp.config(name, server)
  vim.lsp.enable(name)
end
