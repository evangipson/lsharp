local LSharpState = require('models.lsharp_state')

-- The L# io library.
local io = {}

local color_end = '\27[0m'
local colors = {
    error = '\27[31m',
    warning = '\27[33m',
    information = '\27[32m',
    debug = '\27[36m'
}

---Raises an `error` to the caller when provided an invalid `message`, otherwise returns the `message`.
---@param message string The message that is intended to be logged.
---@return string The message, after making sure it's valid.
local validate_message = function(message)
    if message == nil then
        error('Argument provided to io.lib was null.', 2)
    elseif type(message) ~= 'string' then
        error('Argument provided to io.lib must be a string.', 2)
    end

    return message
end

---Logs an error `message`. Raises an `error` to the caller when provided an invalid `message`.
---@param message string The error message.
io.error = function(message)
    print(colors.error .. '[error]: ' .. color_end .. ' ' ..
        LSharpState:get_current_frame_file_and_line() .. '\n  ' .. validate_message(message))
end

---Logs a warning `message`. Raises an `error` to the caller when provided an invalid `message`.
---@param message string The warning message.
io.warning = function(message)
    print(colors.warning .. '[warn]: ' .. color_end .. ' ' ..
        LSharpState:get_current_frame_file_and_line() .. '\n  ' .. validate_message(message))
end

---Logs an informational `message`. Raises an `error` to the caller when provided an invalid `message`.
---@param message string The informational messsage.
io.information = function(message)
    print(colors.information .. '[info]: ' .. color_end .. ' ' ..
        LSharpState:get_current_frame_file_and_line() .. '\n  ' .. validate_message(message))
end

---Logs a debug `message`. Raises an `error` to the caller when provided an invalid `message`.
---@param message string The debug messsage.
io.debug = function(message)
    print(colors.debug .. '[debug]: ' .. color_end .. ' ' ..
        LSharpState:get_current_frame_file_and_line() .. '\n  ' .. validate_message(message))
end

---Logs the `message` to the console. Raises an `error` to the caller when provided an invalid `message`.
---@param message string The message to log.
---@param severity number|string Optional severity of the message. 1-4 ('debug'/'information'/'warning'/'error').
io.log = function(message, severity)
    if message == nil then
        error('Argument provided to io.lib was null.', 2)
    elseif type(message) ~= 'string' then
        error('Argument provided to io.lib must be a string.', 2)
    end

    if severity == 4 or severity == 'error' then
        io.error(message)
    elseif severity == 3 or severity == 'warning' then
        io.warning(message)
    elseif severity == 2 or severity == 'information' then
        io.information(message)
    elseif severity == 1 or severity == 'debug' then
        io.debug(message)
    else
        print(message)
    end
end

return io