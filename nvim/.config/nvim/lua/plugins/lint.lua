return {
  'mfussenegger/nvim-lint',
  event = { 'BufWritePost', 'BufReadPost' },
  config = function()
    local lint = require 'lint'

    lint.linters_by_ft = {
      javascript = { 'eslint_d' },
      typescript = { 'eslint_d' },
      javascriptreact = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
    }

    local augroup = vim.api.nvim_create_augroup('LintAutogroup', { clear = true })

    vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
      group = augroup,
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}

