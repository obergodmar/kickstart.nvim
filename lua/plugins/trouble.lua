return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local nmap = function(keys, func, desc, custom)
      if not custom then
        func = "<cmd>TroubleToggle " .. func .. "<cr>"
      end

      vim.keymap.set("n", keys, func, { desc = desc })
    end

    require("trouble").setup({
      padding = false,
      action_keys = {
        close = "q",
        cancel = "<esc>",
        refresh = "r",
        jump_close = { "<cr>", "<tab>" },
        open_split = { "<c-x>" },
        open_vsplit = { "<c-v>" },
        open_tab = { "<c-t>" },
        jump = { "o" },
        toggle_mode = "m",
        switch_severity = "s",
        toggle_preview = "P",
        hover = "K",
        preview = "p",
        close_folds = { "zM", "zm" },
        open_folds = { "zR", "zr" },
        toggle_fold = { "zA", "za" },
        previous = "k",
        next = "j",
      },
    })

    nmap("gr", "lsp_references", "[G]oto [R]eferences")
    nmap("gd", "lsp_definitions", "[G]oto [D]efinitions")
    nmap("<leader>D", "lsp_type_definitions", "Type [D]efinitions")
    nmap("<leader>sd", "document_diagnostics", "[S]earch [D]iagnostics")
    nmap("<leader>sD", "workspace_diagnostics", "[S]earch [D]iagnostics")
    nmap("<leader>st", "<cmd>TodoTrouble<CR>", "[S]earch [T]ODO", true)
    nmap("<leader>sq", "quickfix", "[S]how [Q]uick List")
  end,
}
