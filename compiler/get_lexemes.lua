local Lexeme = require('models.lexeme')
local table_insert = table.insert

---Gets a collection of [Lexemes](../models/lexeme.lua) (tokens and/or expressions) from the provided `text`.
---@param text string One or many lines of text, usually provided from an L# file.
---@return Lexeme[]
local function get_lexemes(text)
    local lexemes = {}

    local line_count = 1
    for line in text:gmatch("[^\n]*") do
        local expressions = {}
        for expression in line:gmatch('%S+[(]+.*[)]+') do
            table_insert(expressions, expression)
            line = line:gsub('%S+[(]+.*[)]+', '')
        end

        local comments = {}
        for comment in line:gmatch('[/*]+(.+)[*/]+') do
            table_insert(comments, comment)
            line = line:gsub('[/*]+(.+)[*/]+', '')
        end

        local tokens = {}
        for word in line:gmatch("%S+") do
            table_insert(tokens, word)
        end

        local lexeme = Lexeme:new_lexeme(tokens, expressions, line_count)
        table_insert(lexemes, lexeme)

        line_count = line_count + 1
    end

    return lexemes
end

return get_lexemes