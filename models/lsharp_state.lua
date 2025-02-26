-- A stateful context that is a series of snapshots of information for an L# program.
---@class LSharpState
---@field contracts table A collection of contracts for the current program.
---@field usertypes table A collection of user-defined types for the current program.
---@field variables table A collection of variables for the current program.
---@field stack table A collection of callers and their results during program execution.
local LSharpState = {
    contracts = {},
    usertypes = {},
    variables = {},
    stack = {
        next = '',
        previous = '',
        frames = { count = 0 }
    },
    ---Resets the `LSharpState` by clearing out all values.
    ---@param self LSharpState
    reset = function(self)
        self.contracts = {}
        self.usertypes = {}
        self.variables = {}
        self.stack = {
            next = '',
            previous = '',
            frames = { count = 0 }
        }
    end,
    ---Adds a variable into the `LSharpState` variables collection.
    ---@param self LSharpState
    ---@param variable_type string
    ---@param variable_name string
    ---@param variable_value unknown
    add_variable = function(self, variable_type, variable_name, variable_value)
        self.variables[variable_name] = {
            type = variable_type,
            value = variable_value,
        }
    end,
    ---Gets a variable from the `LSharpState` variables collection.
    ---@param self any
    ---@param variable_name any
    ---@return string|nil, unknown
    get_variable = function(self, variable_name)
        if self.variables[variable_name] == nil then
            return nil, nil
        end
        local type = self.variables[variable_name].type
        local value = self.variables[variable_name].value
        return type, value
    end,
    ---Adds a stack frame into the `LSharpState` stack.
    ---@param self LSharpState
    ---@param caller_name string
    ---@param line_number number
    ---@param file_path string
    add_stackframe = function(self, caller_name, line_number, file_path)
        self.stack.previous = tostring(self.stack.next)
        self.stack.next = tostring(caller_name)
        self.stack.frames.count = self.stack.frames.count + 1
        self.stack.frames[self.stack.next] = {
            line_number = line_number,
            file_path = file_path,
            variables = self.variables
        }
    end,
    ---Gets the current stack frame's file name and line number.
    ---@param self LSharpState
    get_current_frame_file_and_line = function(self)
        return self.stack.frames[self.stack.next].file_path .. ':' ..
            self.stack.frames[self.stack.next].line_number
    end,
    ---Gets a runtime error message based on the stack.
    ---@param self LSharpState
    get_runtime_error = function(self)
        local error_message = '\n\27[31mL# runtime error:\27[0m ' ..
            self.stack.frames[self.stack.next].file_path .. ' ' ..
            '(line ' .. self.stack.frames[self.stack.next].line_number .. ')\n' ..
            'message: ' .. self.stack.next .. ' encountered an error\n' ..
            'stack frames: ' .. self.stack.frames.count .. '\n'

        local frame_has_variables = false
        for _ in pairs(self.stack.frames[self.stack.next].variables) do
            frame_has_variables = true
            break
        end
        if frame_has_variables then
            error_message = error_message .. '\ncurrent frame:'
            for k, v in pairs(self.stack.frames[self.stack.next].variables) do
                error_message = error_message ..
                    '\n\t' .. k .. ' = ' .. (type(v) == 'table' and 'collection' or tostring(v))
            end
            error_message = error_message .. '\n'
        end

        return error_message
    end,
    ---Executes the provided `instruction`, and returns the result. Raises an `error` to the caller if there is a compiler or execution error.
    ---@param self LSharpState
    ---@param instruction string A string representation of an instruction for the L# compiler.
    ---@return unknown
    execute_instruction = function(self, instruction)
        local func, err = load(instruction)
        if func then
            local ok, result = pcall(func)
            if ok then
                return result
            end
            print(self:get_runtime_error())
            os.exit(-1)
        end
        error('\n\n' .. 'L# compiler error: ' .. err .. '\n', 3)
    end
}

return LSharpState