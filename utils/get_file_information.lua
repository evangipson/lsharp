---Gets the path, filename, and extension from a relative or absolute file path as 3 values.
---@param path string The relative or absolute path to a file.
---@return string, string, string - The file's path, filename, and extension.
local function get_file_information(path)
    return string.match(path, "^(.-)([^\\/]-)(%.[^\\/%.]-)%.?$")
end

return get_file_information