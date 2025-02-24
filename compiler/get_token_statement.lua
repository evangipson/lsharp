local execute_instruction = require('compiler.execute_instruction')
local token_list = require('compiler.tokens_list')
local Statement = require('models.statement')

---Gets a type from the `tokens`.
---@param tokens string[] A collection of words, keywords, and operators.
---@return string|nil
local function get_token_type_from_tokens(tokens)
    for statement_type, statement in pairs(token_list) do
        for _, lexeme in ipairs(statement) do
            for _, token in pairs(tokens) do
                if token == lexeme then
                    return statement_type
                end
            end
        end
    end
    return nil
end

---Gets an executable [`Statement`](../models/statement.lua) for the `tokens` based on their type.
---@param tokens string[] A collection of words, keywords, and operators.
---@return Statement|nil
local function get_token_statement(tokens)
    local legal_token_type = get_token_type_from_tokens(tokens)
    if legal_token_type == 'declarations' then
        local declaration_expression = function()
            if tokens[1] == 'using' and tokens[2] == 'System.Console' then
                execute_instruction('Console = require("system.console")')
            elseif tokens[1] == 'class' or tokens[1] == 'record' then
                return {}
            end
        end
        return Statement:new('declaration', tokens[1], tokens[2], declaration_expression)
    end
    -- if legal_token_type == 'loops' then
    -- if legal_token_type == 'keywords' then
    -- if legal_token_type == 'access_modifiers' then
    -- if legal_token_type == 'types' then
    -- if legal_token_type == 'operators' then
    -- if legal_token_type == 'comments' then
end

return get_token_statement