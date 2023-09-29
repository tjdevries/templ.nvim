-- Register the language
vim.filetype.add {
  extension = {
    templ = "templ"
  }
}

-- Make sure we have a tree-sitter grammar for the language
local treesitter_parser_config = require "nvim-treesitter.parsers".get_parser_configs()
treesitter_parser_config.templ = treesitter_parser_config.templ or {
  install_info = {
    url = "https://github.com/vrischmann/tree-sitter-templ.git",
    files = { "src/parser.c", "src/scanner.c" },
    branch = "master",
  },
}

vim.treesitter.language.register('templ', 'templ')

-- Register the LSP as a config
local configs = require 'lspconfig.configs'
if not configs.templ then
  configs.templ = {
    default_config = {
      cmd = { "templ", "lsp" },
      filetypes = { 'templ' },
      root_dir = require "lspconfig.util".root_pattern("go.mod", ".git"),
      settings = {},
    },
  }
end
