local get_expression_statements = require('compiler.get_expression_statements')
local get_token_statement = require('compiler.get_token_statement')
local print_lexemes = require('debug.print_lexemes')
local table_insert = table.insert

---Parses the `lexeme` then returns one or many [`Statements`](../models/statement.lua).
---@param lexeme Lexeme The [Lexemes](../models/lexeme.lua) to parse.
---@param source_file_path string The L# source file that this statement originates from.
---@return Statement[]
local function parse_lexeme(lexeme, source_file_path)
    local statements = {}

    local token_statement = get_token_statement(lexeme.tokens, lexeme.line_number, source_file_path)
    if token_statement then
        table_insert(statements, token_statement)
    end

    local expression_statements = get_expression_statements(lexeme.expressions, lexeme.line_number, source_file_path)
    for _, expression in ipairs(expression_statements) do
        table_insert(statements, expression)
    end

    return statements
end

---Parses the [Lexemes](../models/lexeme.lua) and returns a collection of lists of executable [`Statements`](../models/statement.lua).
---@param lexemes Lexeme[] A collection of [Lexemes](../models/lexeme.lua) to parse.
---@param source_file_path string The L# source file that this statement originates from.
---@return Statement[][]
local function parse_lexemes(lexemes, source_file_path)
    print_lexemes(lexemes)
    local statements_list = {}
    for _, lexeme in ipairs(lexemes) do
        local statements = parse_lexeme(lexeme, source_file_path)
        table_insert(statements_list, statements)
    end
    return statements_list
end

return parse_lexemes