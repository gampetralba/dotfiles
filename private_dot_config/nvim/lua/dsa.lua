local M = {}

M.open_test_buffer = function()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        local buf_name = vim.fn
                             .fnamemodify(vim.api.nvim_buf_get_name(buf), ":t")
        if buf_name == "TestCaseInput" then
            vim.cmd("vsplit")
            vim.cmd("buffer " .. buf)
            return
        end
    end

    vim.cmd("vsplit")
    vim.cmd("enew")
    vim.bo.buftype = "nofile"
    vim.bo.bufhidden = "hide"
    vim.bo.swapfile = false
    vim.api.nvim_buf_set_name(0, "TestCaseInput")
end

M.open_output_buffer = function()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        local buf_name = vim.fn
                             .fnamemodify(vim.api.nvim_buf_get_name(buf), ":t")
        if buf_name == "TestOutput" then
            vim.cmd("split")
            vim.cmd("buffer " .. buf)
            return buf
        end
    end

    vim.cmd("split")
    vim.cmd("enew")
    vim.bo.buftype = "nofile"
    vim.bo.bufhidden = "hide"
    vim.bo.swapfile = false
    vim.api.nvim_buf_set_name(0, "TestOutput")
    return vim.api.nvim_get_current_buf()
end

M.run_cpp_program = function()
    local input_buf = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(input_buf, 0, -1, false)
    local input_data = table.concat(lines, "\n")
    local input_file = "test_input.txt"
    local f = io.open(input_file, "w")

    if f then
        f:write(input_data)
        f:close()
    end

    local compile_cmd = "g++ main.cpp -o a.out 2> compile_errors.txt"
    os.execute(compile_cmd)
    local output = vim.fn.system("./a.out < " .. input_file)
    local output_buf = M.open_output_buffer()

    vim.api
        .nvim_buf_set_lines(output_buf, 0, -1, false, vim.split(output, "\n"))
end

return M
