return {
  plugins = {
    {
      "mosajjal/bard-cli",
      name = "bard-cli",
      lazy = false,
      config = function()
        require("bard-cli").setup({
          bardcli_path = "$HOME/.config/nvim/lua/user/plugins/bard-cli",
          bard_cli_config_path = "$HOME/.config/nvim/lua/user/plugins/bard-cli/.bardcli.yaml",
        })
      end,
    },
  },
}
