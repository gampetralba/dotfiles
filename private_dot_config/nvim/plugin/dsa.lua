local dsa = require('dsa')

-- Define user commands
vim.api.nvim_create_user_command("OpenTestBuffer", dsa.open_test_buffer, {})
vim.api.nvim_create_user_command("RunCpp", dsa.run_cpp_program, {})
