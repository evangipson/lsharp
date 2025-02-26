-- A model for a lexeme, which is one or many words, that will be compiled into a ['Statement'](statement.lua).
---@class Lexeme
---@field tokens table|nil A collection of tokens (commonly keywords, variables, or operators), defaults to `nil`.
---@field expressions table|nil A collection of expressions that are not transformed before the compiler runs them, defaults to `nil`.
---@field line_number number The line number the `Lexeme` was written on in the L# source code.
local Lexeme = {
    tokens = nil,
    expressions = nil,
    line_number = 0,
    ---Creates a new `Lexeme` with the provided `tokens` and `expressions`.
    ---@param self Lexeme
    ---@param tokens table A collection of keywords, variables, or operators.
    ---@param expressions table A collection of expressions which aren't transformed before being invoked.
    ---@param line_number number The line number the `Lexeme` was written on in the L# source code.
    ---@return Lexeme
    new_lexeme = function(self, tokens, expressions, line_number)
        return setmetatable({
            tokens = tokens,
            expressions = expressions,
            line_number = line_number
        }, { __index = self })
    end
}

return Lexeme