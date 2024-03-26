return {
    'LunarVim/bigfile.nvim',
    event = 'BufRead',
    opts = {
        filesize = 2,
    },
    config = function (_, opts)
        require('bigfile').setup(opts)
    end
}
