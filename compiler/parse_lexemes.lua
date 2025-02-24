local get_expression_statements = require('compiler.get_expression_statements')
local get_token_statement = require('compiler.get_token_statement')
local print_lexemes = require('debug.print_lexemes')
local table_insert = table.insert

---Parses the `lexeme` then returns one or many [`Statements`](../models/statement.lua).
---@param lexeme Lexeme
---@return Statement[]
local function parse_lexeme(lexeme)
    local statements = {}
    for token_type, tokens in pairs(lexeme) do
        if token_type == 'tokens' then
            local token_statement = get_token_statement(tokens)
            table_insert(statements, token_statement)
        elseif token_type == 'expressions' then
            local expression_statements = get_expression_statements(tokens)
            for _, expression in ipairs(expression_statements) do
                table_insert(statements, expression)
            end
        end
    end
    return statements
end

---Parses the [Lexemes](../models/lexeme.lua) and returns a collection of lists of executable [`Statements`](../models/statement.lua).
---@param lexemes Lexeme[] A collection of [Lexemes](../models/lexeme.lua) to parse.
---@return Statement[][]
local function parse_lexemes(lexemes)
    print_lexemes(lexemes)
    local statements_list = {}
    for _, token in ipairs(lexemes) do
        local statements = parse_lexeme(token)
        table_insert(statements_list, statements)
    end
    return statements_list
end

return parse_lexemes