--- Unique Names Generator
-- @module names_generator
-- @license MIT

local M = {}

--- Verify configuration
-- @param config Config
local function verify(config)
    if not config.dictionaries or #config.dictionaries == 0 then
        error("Cannot find any dictionary. Please provide at least one, or leave the 'dictionary' field empty in the config table.")
    end

    if not config.random then
        error("Random function is not provided.")
    end
end

--- Format word based on style
-- @param word string
-- @param style string|nil
-- @return string
local function format_word(word, style)
    if style == "lower_case" then
        return string.lower(word)
    elseif style == "capital" then
        return string.upper(string.sub(word, 1, 1)) .. string.lower(string.sub(word, 2))
    elseif style == "upper_case" then
        return string.upper(word)
    end
    return word
end

--- Generate unique name
-- @param config Config
-- @return string
function M.generate(config)
    verify(config)

    local result = {}
    local words_number = #config.dictionaries

    for i = 1, words_number do
        local dict = config.dictionaries[i]
        local word
        if type(dict) == "function" then
            word = dict(config.random)
        else
            local rnd_float = config.random()
            local rnd_index = math.floor(rnd_float * #dict) + 1
            word = dict[rnd_index]
        end

        if word then
            table.insert(result, format_word(word, config.style))
        end
    end

    return table.concat(result, config.separator or "_")
end

--- Create a new unique names generator instance.
-- @tparam config table Configuration options
-- @tparam config.dictionaries table Array of dictionaries to use for name generation
-- @tparam[opt=_] config.separator string Separator to use between words
-- @tparam[opt=""] config.style string Style of generated words ("lower_case", "upper_case", or "capital")
-- @tparam[opt=math.random] config.random function Random function to use
-- @treturn table A table with the `generate` function to create unique names
function M.new(config)
    local new_config = {
        dictionaries = config.dictionaries,
        separator = config.separator,
        style = config.style,
        random = config.random or math.random
    }

    return {
        generate = function()
            return M.generate(new_config)
        end
    }
end

return M
