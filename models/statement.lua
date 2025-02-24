-- A model filled with compiler information and an `expression` that will be executed by the L# compiler.
---@class Statement
---@field type string The type of a `Statement`.
---@field action string The action of a `Statement`.
---@field name string The name of a `Statement`, for internal compiler use.
---@field expression function|nil The invokable behavior of a `Statement`, defaults to `nil`.
local Statement = {
    type = '',
    action = '',
    name = '',
    expression = nil,
    ---Creates and returns a new `Statement`.
    ---@param self Statement
    ---@param type string The type of the new `Statement`.
    ---@param action string The action of the new `Statement`.
    ---@param name string The name of the new `Statement`.
    ---@param expression function The `function` that defines the behavior of the new `Statement`.
    ---@return Statement
    new = function(self, type, action, name, expression)
        return setmetatable({
            type = type,
            action = action,
            name = name,
            expression = expression
        }, { __index = self })
    end
}

return Statement