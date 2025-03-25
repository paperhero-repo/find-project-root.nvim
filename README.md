# find-project-root.nvim
A Neovim plugin to intelligently detect project root directories and change working directory automatically.

## Features
- Customizable marker patterns for project root detection
- Default support for:
    - `.git`
    - Language-specific configs (Go, Dart, Node.js, Svelte, Rust, Java)
    - Simple `:FindProjectRoot` command integration
    - Automatic working directory management
## Installation
### Using Packer
```lua
use {
    'paperhero-repo/find-project-root',
    config = fucntion()
        require("find-project-root").setup()
    end
}
```

### Using Lazy

```lua
{
    'paperhero-repo/find-project-root',
    config = fucntion()
        require("find-project-root").setup({
            markers = {
                -- your custom markers
            }
        })
    end
}
```

## Configuration
```lua
require('find-project-root').setup({
  markers = {
    ".git",
    "pyproject.toml",    -- Python
    "CMakeLists.txt",    -- C/C++
    "mix.exs",           -- Elixir
    -- Add your custom markers
  }
})
```

## Usage
### Basic Command
```vim
:FindProjectRoot
```
### Craete shortcut mapping 
```lua
vim.keymap.set('n', '<leader>pr', '<cmd>FindProjectRoot<CR>', { desc = 'Find Project Root' })
```

## License

MIT


