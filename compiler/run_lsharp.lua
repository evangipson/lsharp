local print_statements = require('debug.print_statements')

---Runs an L# program by invoking the `statements`.
---@param statements Statement[][] A collection of lists of [`Statements`](../models/statement.lua) to be invoked.
local function run_lsharp(statements)
    print_statements(statements)
    for _, statements_list in pairs(statements) do
        for _, statement in pairs(statements_list) do
            if type(statement.expression) == 'function' then
                statement.expression()
            end
        end
    end
end

return run_lsharp