require("solo.set")
require("solo.remap")
require("solo.lazy")

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "ruff", "jedi_language_server" }
})

