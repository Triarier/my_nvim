vim.g.mapleader = " "
require("solo.set")
require("solo.remap")
require("solo.lazy")
require("solo.lsp")
require("solo.keymaps")

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "ruff", "jedi_language_server" }
})

local harpoon = require('harpoon')
harpoon:setup({})

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local finder = function()
        local paths = {}
        for _, item in ipairs(harpoon_files.items) do
            table.insert(paths, item.value)
        end

        return require("telescope.finders").new_table({
            results = paths,
        })
    end
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = finder(),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
            map("i", "<C-d>", function()
                local state = require("telescope.actions.state")
                local selected_entry = state.get_selected_entry()
                local current_picker = state.get_current_picker(prompt_bufnr)

                table.remove(harpoon_files.items, selected_entry.index)
                current_picker:refresh(finder())
            end)
            return true
        end,
    }):find()
end

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>d", function() harpoon:list():remove() end)
vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end,
    { desc = "Open harpoon window" })
vim.keymap.set('n', '<C-h>', '<Cmd>Neotree toggle<CR>')

require("copilot").setup({
  suggestion = { enabled = false },
  panel = { enabled = true },
  --copilot_model = 'bla',
})
require'nvim-treesitter'.install { 'python','cpp' }

--   panel = {
--     enabled = true,
--     auto_refresh = true,
--     keymap = {
--       jump_prev = "[[",
--       jump_next = "]]",
--       accept = "<CR>",
--       refresh = "gr",
--       open = "<M-CR>"
--     },
--     layout = {
--       position = "bottom", -- | top | left | right | bottom |
--       ratio = 0.4
--     },
--   },
--   suggestion = {
--     enabled = true,
--     auto_trigger = true,
--     hide_during_completion = true,
--     debounce = 75,
--     trigger_on_accept = true,
--     keymap = {
--       accept = "<M-l>",
--       accept_word = false,
--       accept_line = false,
--       next = "<M-]>",
--       prev = "<M-[>",
--       dismiss = "<C-]>",
--     },
--   },
--   nes = {
--     enabled = false, -- requires copilot-lsp as a dependency
--     auto_trigger = false,
--     keymap = {
--       accept_and_goto = false,
--       accept = false,
--       dismiss = false,
--     },
--   },
--   auth_provider_url = nil, -- URL to authentication provider, if not "https://github.com/"
--   logger = {
--     file = vim.fn.stdpath("log") .. "/copilot-lua.log",
--     file_log_level = vim.log.levels.OFF,
--     print_log_level = vim.log.levels.WARN,
--     trace_lsp = "off", -- "off" | "messages" | "verbose"
--     trace_lsp_progress = false,
--     log_lsp_messages = false,
--   },
--   copilot_node_command = 'node', -- Node.js version must be > 22
--   workspace_folders = {},
--   copilot_model = "",
--   disable_limit_reached_message = false,  -- Set to `true` to suppress completion limit reached popup
--   root_dir = function()
--     return vim.fs.dirname(vim.fs.find(".git", { upward = true })[1])
--   end,
--   should_attach = function(_, _)
--     if not vim.bo.buflisted then
--       -- logger.debug("not attaching, buffer is not 'buflisted'")
--       return false
--     end
-- 
--     if vim.bo.buftype ~= "" then
--       -- logger.debug("not attaching, buffer 'buftype' is " .. vim.bo.buftype)
--       return false
--     end
-- 
--     return true
--   end,
--   server = {
--     type = "nodejs", -- "nodejs" | "binary"
--     custom_server_filepath = nil,
--   },
--   server_opts_overrides = {},
-- })
require('lualine').setup({options={them="gruvbox"}})
