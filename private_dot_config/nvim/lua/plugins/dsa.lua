local config_dir = vim.fn.stdpath("config")

return {
    dir = config_dir,
    name = "dsa",

    cmd = {"OpenTestBuffer", "RunCpp"},

    config = function()
        local dsa = require("dsa")

        vim.api.nvim_create_user_command("OpenTestBuffer", dsa.open_test_buffer,
                                         {})

        vim.api.nvim_create_user_command("RunCpp", dsa.run_cpp_program, {})
    end
}
