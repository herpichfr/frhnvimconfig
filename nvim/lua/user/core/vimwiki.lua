return {
    {
        'vimwiki/vimwiki',
        config = function()
        vim.g.vimwiki_list = {
            path = '~/Dropbox/vimwiki/',
            syntax = 'markdown',
            ext = '.md',
        }
        vim.g.vimwiki_global_ext = 0
        vim.g.vimwiki_hl_headers = 1
        vim.g.vimwiki_hl_cb_checked = 1
        vim.g.vimwiki_hl_cb_enabled = 1
        vim.g.vimwiki_hl_cb_disabled = 1
        end,
    },
}
