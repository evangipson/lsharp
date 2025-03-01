local get_file_content = require('utils.get_file_content')
local get_lexemes = require('compiler.get_lexemes')
local parse_lexemes = require('compiler.parse_lexemes')
local run_lsharp = require('compiler.run_lsharp')

-- Set the `Debug` flag to true if `-d` or `--debug` is provided after the file path.
Debug = (arg[2] == "-d" or arg[2] == "--debug" or false)

-- Make sure there is a filepath provided, otherwise throw an error.
assert(arg[1], 'You must provide an L# source file must as an argument.')
assert(arg[1]:find('^%S+%.ls$'), 'Please provide an L# file (.ls) when compiling an L# program.')

-- Begin compiling the file into executable instructions, then run those instructions.
local file_content = get_file_content(arg[1])
local lexemes = get_lexemes(file_content)
local statements = parse_lexemes(lexemes, arg[1])
run_lsharp(statements)