return {

    {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        -- or                              , branch = '0.1.x',
        dependencies = {
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = function()
                    return vim.fn.executable "make" == 1
                end,
            },
        },
    },
    "projekt0n/github-nvim-theme",

    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2"
    }
}
