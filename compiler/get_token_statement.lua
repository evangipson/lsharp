local LSharpState = require('models.lsharp_state')
local token_list = require('compiler.tokens_list')
local Statement = require('models.statement')

---Gets a type from the `tokens`.
---@param tokens string[] A collection of words, keywords, and operators.
---@return string|nil
local function get_token_type_from_tokens(tokens)
    for statement_type, statement in pairs(token_list) do
        for _, lexeme in ipairs(statement) do
            for _, token in ipairs(tokens) do
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
---@param source_line_number number The line number in the L# source code that this statement originates from.
---@param source_file_path string The L# source file that this statement originates from.
---@return Statement|nil
local function get_token_statement(tokens, source_line_number, source_file_path)
    local legal_token_type = get_token_type_from_tokens(tokens)
    for token_index, token in ipairs(tokens) do
        if legal_token_type == 'declarations' then
            local _, grab_context = next(tokens, token_index)
            if grab_context and token == 'grab' then
                    local declaration_expression = function()
                        LSharpState:add_stackframe('grab ' .. grab_context, source_line_number, source_file_path)
                        LSharpState:execute_instruction(grab_context ..' = require("library.' .. grab_context .. '")')
                    end
                    return Statement:new(source_line_number, source_file_path, 'declaration', token, grab_context, declaration_expression)
            elseif grab_context and token == 'contract' then
                local declaration_expression = function()
                    LSharpState:add_stackframe(grab_context .. ' contract created', source_line_number, source_file_path)
                    LSharpState:execute_instruction(grab_context .. ' = {}')
                end
                return Statement:new(source_line_number, source_file_path, 'declaration', token, grab_context, declaration_expression)
            end
        elseif legal_token_type == 'keywords' then
            local _, grab_context = next(tokens, token_index)
            if grab_context and token == 'return' then
                local keyword_expression = function()
                    local return_type, return_value = LSharpState:get_variable(grab_context)
                    if return_type and return_value then
                        -- handle statements like `return some_var`
                        LSharpState:add_stackframe('return ' .. grab_context, source_line_number, source_file_path)
                        LSharpState:execute_instruction('return ' .. return_value)
                        LSharpState:add_variable(return_type, grab_context, return_value)
                    else
                        -- handle statements like `return 2 * 2`
                    end
                end
                return Statement:new(source_line_number, source_file_path, 'keyword', token, grab_context, keyword_expression)
            end
        elseif legal_token_type == 'types' then
            local grab_context_index, grab_context = next(tokens, token_index)
            if grab_context then
                local operator_index, operator = next(tokens, grab_context_index)
                local _, value = next(tokens, operator_index)
                if operator == '=' and value then
                    local type_expression = function()
                        local stackframe = 'set ' .. token .. ' ' .. grab_context .. ' to ' .. value
                        LSharpState:add_stackframe(stackframe, source_line_number, source_file_path)
                        LSharpState:add_variable(token, grab_context, value)
                    end
                    return Statement:new(source_line_number, source_file_path, 'type', 'set variable', token .. ' ' .. grab_context, type_expression)
                end
            end
        end
    end
    -- if legal_token_type == 'operators' then
    -- if legal_token_type == 'context_indicators' then
    -- if legal_token_type == 'collection_indicators' then
    -- if legal_token_type == 'expression_indicators' then
    -- if legal_token_type == 'string_indicators' then
    -- if legal_token_type == 'template_literals' then
    -- if legal_token_type == 'comments' then
end

return get_token_statement