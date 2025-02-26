local LSharpState = require('models.lsharp_state')
local print_statements = require('debug.print_statements')

---Runs an L# program by invoking the `statements`.
---@param statements Statement[][] A collection of lists of [`Statements`](../models/statement.lua) to be invoked.
local function run_lsharp(statements)
    print_statements(statements)

    -- Reset the state of the L# state machine before running the program
    LSharpState:reset()

    -- Execute all the statements that have been parsed
    for _, statements_list in pairs(statements) do
        for _, statement in pairs(statements_list) do
            if type(statement.expression) == 'function' then
                statement.expression()
            end
        end
    end
end

return run_lsharp