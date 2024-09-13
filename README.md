# Unique Names Generator for Defold

This module provides a simple way to generate unique names in your Defold games. It includes a collection of dictionaries for different types of words, such as adjectives, animals, names, colors, and numbers.

## Installation

To use this library in your Defold project, add the following URL to your `game.project` dependencies:

    https://github.com/indiesoftby/defold-unique-names-generator/archive/main.zip

## Usage

```lua
local names_generator = require("unique_names_generator.names_generator")

local adjectives = require("unique_names_generator.dictionaries.adjectives")
local animals = require("unique_names_generator.dictionaries.animals")
local colors = require("unique_names_generator.dictionaries.colors")
local numbers = require("unique_names_generator.dictionaries.numbers")

function init(self)
    -- Using default dictionaries:
    local generator = names_generator.new({
        dictionaries = {
            colors,
            adjectives,
            animals,
            numbers({ min = 100, max = 999 })
        },
        style = "capital",
        separator = ""
    })

    -- Generate 3 names:
    print(generator.generate())
    print(generator.generate())
    print(generator.generate())

    -- Using your own dictionaries:
    local config = {
        dictionaries = {
            {"stylish", "awesome", "fantastic"},
            {"boy", "girl", "cat"},
        },
        separator = "_",
        style = "lower_case",
        random = math.random -- you can pass your own random function if you want
    }

    local generator2 = names_generator.new(config)
    print(generator2.generate())
end
```

## API Reference

### `names_generator.new(config)`

Creates a new `generator` instance.

**Parameters:**
- `config` (table): Configuration options for the generator.
  - `dictionaries` (table): Array of dictionaries to use for name generation.
  - `separator` (string, optional): Separator to use between words. Default: "_"
  - `style` (string, optional): Style of generated words ("lower_case", "upper_case", or "capital"). Default: ""
  - `random` (function, optional): Random function to use. Default: `math.random`

**Returns:**
- `table`: A table with the `generate` function to create unique names.

### `generator:generate()`

Generates a unique name.

**Returns:**
- `string`: A generated unique name.

## License

This library is released under the MIT License. See [LICENSE](LICENSE.md) for details.

It's based on the [unique-names-generator](https://github.com/andreasonny83/unique-names-generator) JavaScript library.
