local Lexeme = require('models.lexeme')
local table_insert = table.insert

---Gets a collection of [Lexemes](../models/lexeme.lua) (tokens and/or expressions) from the provided `text`.
---@param text string One or many lines of text, usually provided from an L# file.
---@return Lexeme[]
local function get_lexemes(text)
    local lexemes = {}

    local line_count = 1
    for line in text:gmatch("[^\n\r;]+") do
        local expressions = {}
        for expression in line:gmatch('%S+[(]+.*[)]+') do
            table_insert(expressions, expression)
            line = line:gsub('%S+[(]+.*[)]+', '')
        end

        local tokens = {}
        for word in line:gmatch("%S+") do
            table_insert(tokens, word)
        end

        local lexeme = Lexeme:new_lexeme(tokens, expressions)
        table_insert(lexemes, lexeme)

        line_count = line_count + 1
    end

    return lexemes
end

return get_lexemes