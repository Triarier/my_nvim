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

-- add for c++ exams hr and cppr as cpp filetype
vim.filetype.add({
  extension = {
    hr = "cpp",
    cppr = "cpp",
  },
})

require'nvim-treesitter'.install { 'python','cpp' ,'lua','javascript','html','css','json','yaml','markdown','ruby' }
require('lualine').setup({options={them="gruvbox"}})
