local u = require("config.utils")

-- const myString = "hello ${}" ->
-- const myString = `hello ${}`
local change_template_string_quotes = function()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    row = row - 1

    local quote_start, quote_end
    u.gfind(vim.api.nvim_get_current_line(), "[\"']", function(pos)
        if not quote_start then
            -- start at first quote
            quote_start = pos
        elseif pos < col then
            -- move start if quote is closer to col
            if (pos - col) > (quote_start - col) then
                quote_start = pos
            end
        elseif not quote_end then
            -- first quote after col is end
            quote_end = pos
        end
    end)

    -- if found, replace quotes with backticks
    if quote_start and quote_end then
        vim.api.nvim_buf_set_text(0, row, quote_start - 1, row, quote_start, { "`" })
        vim.api.nvim_buf_set_text(0, row, quote_end - 1, row, quote_end, { "`" })
    end

    -- input and move cursor into pair
    u.input("${}", "n")
    u.input("<Left>")
end

local ts_utils_settings = {
    -- debug = true,
    import_all_scan_buffers = 100,
    update_imports_on_move = true,
    -- filter out dumb module warning
    filter_out_diagnostics_by_code = { 80001 },
}

local M = {}
M.setup = function(on_attach, capabilities)
    local lspconfig = require("lspconfig")
    local ts_utils = require("nvim-lsp-ts-utils")

    lspconfig["tsserver"].setup({
        root_dir = lspconfig.util.root_pattern("package.json"),
        init_options = ts_utils.init_options,
        on_attach = function(client, bufnr)
            on_attach(client, bufnr)

            ts_utils.setup(ts_utils_settings)
            ts_utils.setup_client(client)

            u.buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
            u.buf_map(bufnr, "n", "gI", ":TSLspRenameFile<CR>")
            u.buf_map(bufnr, "n", "go", ":TSLspImportAll<CR>")
            u.buf_map(bufnr, "i", "${", change_template_string_quotes, { nowait = true })
        end,
        flags = {
            debounce_text_changes = 150,
        },
        capabilities = capabilities,
    })
end

return M
