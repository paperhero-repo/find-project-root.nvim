local M = {}

local default_config = {
	markers = {
		".git",
		"go.mod", -- golang
		"pubspec.yaml", -- dart
		"package.json", -- node
		"svelte.config.js", -- svelte
		"Cargo.toml", -- rust
		"build.gradle", -- Java
	},
}

function detect_project_root(config)
	-- 현재 버퍼의 파일 경로 기반으로 시작 위치 결정
	local current_buf_path = vim.api.nvim_buf_get_name(0)
	local start_path = current_buf_path ~= "" and vim.fn.fnamemodify(current_buf_path, ":p:h") or vim.fn.getcwd()

	local function find_root(path)
		local parent = vim.fn.fnamemodify(path, ":h")
		if parent == path then
			return nil
		end

		for _, marker in ipairs(config.markers) do
			local check_path = vim.fn.glob(path .. "/" .. marker)
			if check_path ~= "" then
				return path
			end
		end

		return find_root(parent)
	end

	return find_root(start_path) or start_path
end

function M.setup(user_configs)
	config = vim.tbl_deep_extend("keep", user_configs or {}, default_config)

	vim.api.nvim_create_user_command("FindProjectRoot", function()
		local root = detect_project_root(config)
		vim.cmd("cd " .. vim.fn.fnameescape(root)) -- 공백 추가
		print("Changed directory to: " .. root) -- 오타 수정
	end, {})
end

return M
