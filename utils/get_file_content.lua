---Gets all binary content from a file, and returns it.
---@param file_path string The path to an L# file.
---@return string
local function get_file_content(file_path)
    local file = assert(io.open(file_path, "rb"), 'Unable to open "' .. file_path .. '" file.')
    local file_content = file:read("*all")
    file:close()

    return file_content
end

return get_file_content