-- The L# System.Console library.
local Console = {}

-- Prints the `message` to the console. Raises an `error` to
-- the caller when provided an invalid `message`.
Console.WriteLine = function(message)
    if message == nil then
        error('Argument provided to Console.WriteLine was null.', 2)
    elseif type(message) ~= 'string' then
        error('Argument provided to Console.WriteLine must be a string.', 2)
    end

    print(message)
end

return Console