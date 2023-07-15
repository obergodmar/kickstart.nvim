return {
  "nvim-pack/nvim-spectre",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("spectre").setup({})

    local nmap = function(keys, func, desc, mode)
      if desc then
        desc = "Spectre: " .. desc
      end

      vim.keymap.set(mode or "n", keys, func, { desc = desc })
    end

    nmap("<leader>S", '<cmd>lua require("spectre").open()<CR>', "Open")
    nmap("<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', "[S]earch current [W]ord")
    nmap("<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', "[S]earch current [W]ord", "v")
    nmap(
      "<leader>sp",
      '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
      "[S]earch on current file"
    )
  end,
}
