-- Autocmds are automatically loaded on the VeryLazy evenosePine
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--

local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end

    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
  nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

  nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
  nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
  nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
  nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
  nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
  nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

  -- See `:help K` for why this keymap
  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

  -- Lesser used LSP functionality
  nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
  nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
  nmap("<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "[W]orkspace [L]ist Folders")

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
    vim.lsp.buf.format()
  end, { desc = "Format current buffer with LSP" })
end

-- local detail = false
-- require("oil").setup({
--   delete_to_trash = true,
--   win_options = {
--     winbar = "%{v:lua.require('oil').get_current_dir()}",
--   },
--   keymaps = {
--     ["gd"] = {
--       desc = "Toggle file detail view",
--       callback = function()
--         detail = not detail
--         if detail then
--           require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
--         else
--           require("oil").set_columns({ "icon" })
--         end
--       end,
--     },
--   },
-- })

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  pyright = {
    python = {
      analysis = {
        extraPaths = {
          "~/repositorios/Reducible/common",
          "~/repositorios/design-bits/utils",
          "~/repositorios/prismsvr/lib",
        },
        typeCheckingMode = "off",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "openFilesOnly",
      },
      pythonPath = "/opt/homebrew/bin/python3.10",
    },
  },
  emmet_ls = {
    filetypes = {
      "html",
      "javascript",
      "typescript",
      "svelte",
      "typescriptreact",
      "javascriptreact",
      "css",
      "sass",
      "scss",
      "less",
    },
  },
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

local augroup = vim.api.nvim_create_augroup("eslint", { clear = true })

-- Define a function to check if an ESLint config file exists in the current directory
local function has_eslint_config()
  local current_directory = vim.fn.getcwd()
  if
    current_directory == "/Users/jesi/Development/repositories/graphext"
    or current_directory == "/Users/jesi/repositorios/graphext-charts"
  then
    return true
  else
    return false
  end
end

vim.api.nvim_create_user_command("Lintfix", "EslintFixAll", {})
vim.api.nvim_create_user_command("NeoFmt", "Neoformat", {})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  group = augroup,
  callback = function()
    if has_eslint_config() then
      print("formatting eslint")
      vim.cmd({ cmd = "EslintFixAll" })
    else
      -- Run your general-purpose formatting command here
      -- For example, to run Prettier:
      print("formatting neoformat")
      vim.cmd("Neoformat")
    end
  end,
})

-- Setup neovim lua configuration
require("neodev").setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require("mason").setup()

-- Ensure the servers above are installed
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
  ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
  function(server_name)
    require("lspconfig")[server_name].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    })
  end,
})

local function harpoon_component()
  local mark_idx = require("harpoon.mark").get_current_index()
  local total_marks = require("harpoon.mark").get_length()
  if mark_idx == nil then
    return ""
  end

  return string.format("󱡅 %d/%d", mark_idx, total_marks)
end

require("lualine").setup({
  sections = {
    lualine_b = {
      { "branch", icon = "" },
      { harpoon_component },
      "filename",
    },
    lualine_c = {},
  },
})

-- nvim-cmp setup
local cmp = require("cmp")
local luasnip = require("luasnip")
local snip = luasnip.snippet
local node = luasnip.snippet_node
local text = luasnip.text_node
local insert = luasnip.insert_node
local func = luasnip.function_node
local choice = luasnip.choice_node
local dynamicn = luasnip.dynamic_node
local date = function()
  return { os.date("%Y-%m-%d") }
end

luasnip.config.setup({})

luasnip.add_snippets(nil, {
  all = {
    snip({
      trig = "date",
      name = "Date",
      dscr = "Date in the form of YYYY-MM-DD",
    }, {
      func(date, {}),
    }),

    snip({
      trig = "pl",
      name = "Play",
      dscr = "Add play to scene",
    }, {
      text("self.play("),
      insert(1, ""),
      text(")"),
    }),

    snip({
      trig = "wi",
      name = "Wait",
      dscr = "Add wait to scene",
    }, {
      text("self.wait(2)"),
    }),

    snip({
      trig = "fi",
      name = "FadeIn",
      dscr = "Add Fade to scene",
    }, {
      text("FadeIn("),
      insert(1, ""),
      text(")"),
    }),
    snip({
      trig = "fo",
      name = "FadeOut",
      dscr = "Add Fade to scene",
    }, {
      text("FadeOut("),
      insert(1, ""),
      text(")"),
    }),
    snip({
      trig = "foc",
      name = "Focus On",
      dscr = "Add a focus on function",
    }, {
      text("focus_on(frame, "),
      insert(1, ""),
      text(")"),
    }),
    snip({
      trig = "res",
      name = "Reset",
      dscr = "Resets the whole scene",
    }, {
      text("self.play(*[FadeOut(mob) for mob in self.mobjects])"),
    }),
    snip({
      trig = "cons",
      name = "Console Log",
      dscr = "Console Log",
    }, {
      text("console.log("),
      insert(1, ""),
      text(")"),
    }),
  },
})

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  mapping = cmp.mapping.preset.insert({
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete({}),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer", keyword_length = 0 },
  },
})
