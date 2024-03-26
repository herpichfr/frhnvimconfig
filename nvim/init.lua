for _, source in ipairs {
  "astronvim.bootstrap",
  "astronvim.options",
  "astronvim.lazy",
  "astronvim.autocmds",
  "astronvim.mappings",
} do
  local status_ok, fault = pcall(require, source)
  if not status_ok then vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. fault) end
end

if astronvim.default_colorscheme then
  if not pcall(vim.cmd.colorscheme, astronvim.default_colorscheme) then
    require("astronvim.utils").notify(
      "Error setting up colorscheme: " .. astronvim.default_colorscheme,
      vim.log.levels.ERROR
    )
  end
end

require("nvim-treesitter.configs").setup({
  ensure_installed = { "markdown", "markdown_inline", ... },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = { "markdown" },
  },
})

require("user.core.vimwiki")

require("astronvim.utils").conditional_func(astronvim.user_opts("polish", nil, false), true)
require("user.core.options")
require("user.core.keymaps")
-- default config
-- require("bigfile").setup {
--   filesize = 2, -- size of the file in MiB, the plugin round file sizes to the closest MiB
--   -- pattern = { "*" }, -- autocmd pattern or function see <### Overriding the detection of big files>
--   features = { -- features to disable
--     "indent_blankline",
--     "illuminate",
--     "lsp",
--     "treesitter",
--     "syntax",
--     "matchparen",
--     "vimopts",
--     "filetype",
--   },
--   pattern = function(bufnr, filesize_mib)
--   -- you can't use `nvim_buf_line_count` because this runs on BufReadPre
--     local file_contents = vim.fn.readfile(vim.api.nvim_buf_get_name(bufnr))
--     local file_length = #file_contents
--     local filetype = vim.filetype.match({ buf = bufnr })
--     if file_length > 5000 and filetype == "sh" then
--       return true
--     end
--   end
-- }
vim.cmd[[
    let g:ale_linters = {'python': ['flake8'],}
    let g:pylsp_settings = {'pylsp.plugins.pylsp_mypy.enabled': v:true}
    let g:codeium_no_map_tab = v:true
    let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki/'}]
                      " \ 'syntax': 'markdown', 'ext': 'md'}]
]]
