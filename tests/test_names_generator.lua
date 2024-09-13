local names_generator = require("unique_names_generator.names_generator")

return function()
    describe("names_generator", function()
        it("should exist", function()
            -- Arrange
            local config = {
                dictionaries = {{}, {}, {}},
                separator = "_",
            }

            -- Act
            local instance = names_generator.new(config)

            -- Assert
            assert_not_nil(instance)
        end)

        it("should have a generate function", function()
            -- Arrange
            local config = {
                dictionaries = {{}, {}, {}},
                separator = "_",
            }

            -- Act
            local instance = names_generator.new(config)

            -- Assert
            assert_type(instance.generate, "function")
        end)

        it("generate: should return nothing", function()
            -- Arrange
            local config = {
                dictionaries = {{}, {}, {}},
                separator = "-",
            }

            -- Act
            local instance = names_generator.new(config)
            local response = instance.generate()

            -- Assert
            assert_equal("", response)
        end)

        it("generate: should return a string", function()
            -- Arrange
            local config = {
                dictionaries = {{}, {}, {}},
                separator = "_",
            }

            -- Act
            local instance = names_generator.new(config)
            local response = instance.generate()

            -- Assert
            assert_type(response, "string")
        end)

        it("generate: should generate a random name", function()
            -- Arrange
            local config = {
                dictionaries = {{"a"}, {"b"}, {"c"}},
                separator = "-"
            }
            local expected = "a-b-c"

            -- Act
            local instance = names_generator.new(config)
            local response = instance.generate()

            -- Assert
            assert_equal(expected, response)
        end)

        it("generate: should generate a random name given only 2 dictionaries", function()
            -- Arrange
            local config = {
                dictionaries = {{"a"}, {"b"}},
                separator = "-"
            }
            local expected = "a-b"

            -- Act
            local instance = names_generator.new(config)
            local response = instance.generate()

            -- Assert
            assert_equal(expected, response)
        end)

        it("generate: should generate a random name given only 1 dictionary", function()
            -- Arrange
            local config = {
                dictionaries = {{"a"}},
                separator = "-"
            }
            local expected = "a"

            -- Act
            local instance = names_generator.new(config)
            local response = instance.generate()

            -- Assert
            assert_equal(expected, response)
        end)

        it("generate: should accept a custom separator character", function()
            -- Arrange
            local config = {
                dictionaries = {{"a"}, {"b"}, {"c"}},
                separator = "_",
            }
            local expected = "a_b_c"

            -- Act
            local instance = names_generator.new(config)
            local response = instance.generate()

            -- Assert
            assert_equal(expected, response)
        end)

        it("should generate random combinations", function()
            -- Arrange
            local adjectives = {"Adjective1", "Adjective2", "Adjective3"}
            local colors = {"Color1", "Color2", "Color3"}
            local subjects = {"Animal1", "Animal2", "Animal3"}
            local config = {
                dictionaries = {adjectives, colors, subjects},
                separator = "-",
            }

            -- Act
            local instance = names_generator.new(config)
            local response = instance.generate()

            -- Assert
            assert_match("^Adjective[123]%-Color[123]%-Animal[123]$", response)
        end)

        describe("style", function()
            it("should return a lower case formatted name when style is set to 'lower_case'", function()
                -- Arrange
                local config = {
                    dictionaries = {{"TEST"}, {"default"}, {"style"}},
                    separator = "_",
                    style = "lower_case"
                }

                local expected_name = "test_default_style"

                -- Act
                local instance = names_generator.new(config)
                local result = instance.generate()

                -- Assert
                assert_equal(expected_name, result)
            end)

            it("should return a capitalized formatted name when style is set to 'capital'", function()
                -- Arrange
                local config = {
                    dictionaries = {{"test"}, {"default"}, {"style"}},
                    separator = "_",
                    style = "capital"
                }

                local expected_name = "Test_Default_Style"

                -- Act
                local instance = names_generator.new(config)
                local result = instance.generate()

                -- Assert
                assert_equal(expected_name, result)
            end)

            it("should return an upper case formatted name when style is set to 'upper_case'", function()
                -- Arrange
                local config = {
                    dictionaries = {{"test"}, {"default"}, {"style"}},
                    separator = "_",
                    style = "upper_case"
                }

                local expected_name = "TEST_DEFAULT_STYLE"

                -- Act
                local instance = names_generator.new(config)
                local result = instance.generate()

                -- Assert
                assert_equal(expected_name, result)
            end)

            it("should not throw any error when the word in the dictionary is empty and a formatted style is provided", function()
                -- Arrange
                local config = {
                    dictionaries = {{}, {}, {}},
                    separator = "_",
                    style = "lower_case"
                }

                local expected_name = ""

                -- Act
                local instance = names_generator.new(config)
                local result = instance.generate()

                -- Assert
                assert_equal(expected_name, result)
            end)
        end)
    end)
end