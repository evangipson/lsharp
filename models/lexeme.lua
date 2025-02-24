-- A model for a lexeme, which is one or many words, that will be compiled into a ['Statement'](statement.lua).
---@class Lexeme
---@field tokens table|nil A collection of tokens (commonly keywords, variables, or operators), defaults to `nil`.
---@field expressions table|nil A collection of expressions that are not transformed before the compiler runs them, defaults to `nil`.
local Lexeme = {
    tokens = nil,
    expressions = nil,
    ---Creates a new `Lexeme` with the provided `tokens` and `expressions`.
    ---@param self Lexeme
    ---@param tokens table A collection of keywords, variables, or operators.
    ---@param expressions table A collection of expressions which aren't transformed before being invoked.
    ---@return Lexeme
    new_lexeme = function(self, tokens, expressions)
        return setmetatable({
            tokens = tokens,
            expressions = expressions
        }, { __index = self })
    end
}

return Lexeme