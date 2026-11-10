-- Project finder: lists immediate subdirs of your project roots and opens the
-- picked one as the new cwd. Backs the dashboard's "Find Project" button.
local M = {}

-- Where you keep projects. Missing dirs are skipped, so edit freely.
M.roots = {
  "~/development",
  "~/personalProjects",
  "~/University",
  "~/CascadeProjects",
  "~/configs",
}

local function scan()
  local dirs = {}
  for _, root in ipairs(M.roots) do
    local path = vim.fn.expand(root)
    if vim.fn.isdirectory(path) == 1 then
      -- depth 1 = the project folders themselves, not their contents
      local out = vim.fn.systemlist({ "fd", "--type", "d", "--max-depth", "1", "--absolute-path", ".", path })
      for _, d in ipairs(out) do
        table.insert(dirs, (d:gsub("/$", "")))
      end
    end
  end
  return dirs
end

-- cd into a dir and show its tree. Session for this cwd auto-saves on exit
-- (auto-session), so next launch "Restore Session" brings the layout back.
function M.open(dir)
  vim.cmd.tcd(dir)
  vim.cmd("Neotree focus")
  vim.notify("Project: " .. vim.fn.fnamemodify(dir, ":t") .. "  (" .. dir .. ")")
end

function M.config()
  M.open(vim.fn.stdpath("config"))
end

function M.pick()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  pickers.new({}, {
    prompt_title = "Find Project",
    finder = finders.new_table({
      results = scan(),
      entry_maker = function(e)
        return { value = e, display = vim.fn.fnamemodify(e, ":t") .. "   " .. e, ordinal = e }
      end,
    }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(bufnr)
      actions.select_default:replace(function()
        actions.close(bufnr)
        local sel = action_state.get_selected_entry()
        if sel then
          M.open(sel.value)
        end
      end)
      return true
    end,
  }):find()
end

return M