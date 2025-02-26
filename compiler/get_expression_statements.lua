local LSharpState = require('models.lsharp_state')
local Statement = require('models.statement')
local table_insert = table.insert

--- Gets a collection of executable [`Statements`](../models/statement.lua) for the `expression_list`.
---@param expression_list string[] A list of expressions to be invoked by the compiler.
---@param source_line_number number The line number in the L# source code that this statement originates from.
---@param source_file_path string The L# source file that this statement originates from.
---@return Statement[]
local function get_expression_statements(expression_list, source_line_number, source_file_path)
    local statements = {}
    for _, expression in pairs(expression_list) do
        local statement_name = expression:gsub('[(]+.*[)]+', '')
        local expression_statement = function()
            LSharpState:add_stackframe('expression "' .. statement_name .. '"', source_line_number, source_file_path)
            LSharpState:execute_instruction(expression)
        end
        local statement = Statement:new(source_line_number, source_file_path, 'expression', 'function', statement_name, expression_statement)
        table_insert(statements, statement)
    end
    return statements
end

return get_expression_statements