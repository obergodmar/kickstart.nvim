local opts = {
  size = 1.5 * 1024 * 1024, -- 1.5MB
  setup = function(ctx)
    vim.schedule(function()
      vim.bo[ctx.buf].syntax = ctx.ft
    end)
  end,
}

vim.filetype.add({
  pattern = {
    ['.*'] = {
      function(path, buf)
        return vim.bo[buf]
            and vim.bo[buf].filetype ~= 'bigfile'
            and path
            and vim.fn.getfsize(path) > opts.size
            and 'bigfile'
          or nil
      end,
    },
  },
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = vim.api.nvim_create_augroup('bigfile', { clear = true }),
  pattern = 'bigfile',
  callback = function(ev)
    vim.api.nvim_buf_call(ev.buf, function()
      opts.setup({
        buf = ev.buf,
        ft = vim.filetype.match({ buf = ev.buf }) or '',
      })
    end)
  end,
})
