local home = vim.fn.expand("~")
local network_dir = home .. "/work/network"
local cwd = vim.fn.getcwd()

local function get_worktree_dir()
  -- If we're at the bare repo root, there's no worktree
  if cwd == network_dir then
    return nil
  end

  local relative_path = string.sub(cwd, #network_dir + 2)
  local worktree_name = string.match(relative_path, "^([^/]+)")

  if not worktree_name then
    return nil
  end

  return network_dir .. "/" .. worktree_name
end

local worktree_dir = get_worktree_dir()

-- Only set project config if we're in a worktree
if worktree_dir then
  _G.project_config = {
    worktree_dir = worktree_dir,
    go_build_tags = "-tags=e2e,integration,client_performance",
    golangci_config = worktree_dir .. "/.golangci.yml",
    ensure_go_work = true,
  }
end
