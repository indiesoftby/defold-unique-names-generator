--- Module for generating random numbers as strings
-- @module numbers

--- Generates a random number as a string
-- @param config Table with optional configuration parameters
-- @param config.min Minimum value for the random number (default: 1)
-- @param config.max Maximum value for the random number (default: 999)
-- @param config.length If specified, generates a number with this many digits
-- @return Table containing a single string representation of the generated number
return function(config)
    config = config or {}
    local min = config.min or 1
    local max = config.max or 999

    if config.length then
        local length = 10 ^ config.length
        min = length / 10
        max = length - 1
    end

    return function(random)
        return tostring(math.floor(random() * (max - min) + min))
    end
end