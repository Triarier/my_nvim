return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      -- list of servers for mason to install
      ensure_installed = {
        "lua_ls",
        "pylsp",
      },
    },
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = {
        },
      },
      "neovim/nvim-lspconfig",
    },
  }
  -- {
  --   "WhoIsSethDaniel/mason-tool-installer.nvim",
  --   opts = {
  --     ensure_installed = {
  --       "prettier", -- prettier formatter
  --       "stylua", -- lua formatter
  --       "isort", -- python formatter
  --       "black", -- python formatter
  --       "pylint",
  --       "eslint_d",
  --     },
  --   },
  --   dependencies = {
  --     "williamboman/mason.nvim",
  --   },
  -- },
}
