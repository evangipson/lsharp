---A debug function that will print debug information for the `lexemes`.
---@param lexemes Lexeme[] A collection of [Lexemes](../models/lexeme.lua) to print debug information for.
local function print_lexemes(lexemes)
    -- Don't print anything if the program is not run in debug mode.
    if Debug == false then
        return
    end

    print()
    for k, token in pairs(lexemes) do
        print('line '..k..':')
        if #token.tokens > 0 then print('\t'..'tokens: ' .. table.unpack(token.tokens)) end
        if #token.expressions > 0 then print('\t'..'expressions: ' .. table.unpack(token.expressions)) end
    end
end

return print_lexemes