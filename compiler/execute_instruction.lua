---Executes the provided `instruction`, and returns the result. Raises an `error` to the caller if there is a compiler or execution error.
---@param instruction string A string representation of an instruction for the L# compiler.
---@return unknown
local function execute_instruction(instruction)
    local func, err = load(instruction)
    if func then
        local ok, result = pcall(func)
        if ok then
            return result
        else
            error('L# error: ' .. result, 2)
        end
    else
        error('L# compiler error: ' .. err, 2)
    end
end

return execute_instruction