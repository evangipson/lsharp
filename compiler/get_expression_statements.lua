local execute_instruction = require('compiler.execute_instruction')
local table_insert = table.insert

--- Gets a collection of executable [`Statements`](../models/statement.lua) for the `expression_list`.
---@param expression_list string[] A list of expressions to be invoked by the compiler.
---@return Statement[]
local function get_expression_statements(expression_list)
    local statements = {}
    for _, expression in pairs(expression_list) do
        local statement = {}
        statement['type'] = 'expression'
        statement['action'] = 'function'
        statement['name'] = expression:gsub('[(]+.*[)]+', '')
        statement['expression'] = function()
            execute_instruction(expression)
        end
        table_insert(statements, statement)
    end
    return statements
end

return get_expression_statements