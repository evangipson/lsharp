-- A map of L# token types and keywords for each token type.
local tokens_list = {
    declarations = { 'using', 'class', 'record' },
    loops = { 'for', 'foreach', 'while' },
    keywords = { 'return', 'continue', 'break', 'new', 'this' },
    access_modifiers = { 'private', 'public', 'internal', 'static', 'readonly', 'required' },
    types = { 'var', 'list', 'array', 'object', 'dynamic', 'int', 'string', 'float', 'double', 'decimal', 'boolean' },
    operators = { '=', '==', '/', '%', '*', '+', '-' },
    comments = { '//', '///' }
}

return tokens_list