---A debug function that will print the `statements`.
---@param statements Statement[][] A collection of lists of [`Statements`](../models/statement.lua) to print debug information for.
local function print_statements(statements)
    -- Don't print anything if the program is not run in debug mode.
    if Debug == false then
        return
    end

    print('\nin run_program with the following '..#statements..' statement(s):')
    for k, v in pairs(statements) do
        for i, x in pairs(v) do
            for z, y in pairs(x) do
                local y_value = y
                if type(y) == 'function' then
                    y_value = type(y)
                end
                print(k..'['..i..']['..z..']: ' .. y_value)
            end
        end
    end
    print()
end

return print_statements