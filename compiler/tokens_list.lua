-- A map of L# token types and keywords for each token type.
local tokens_list = {
    declarations = { 'grab', 'contract' },
    keywords = { 'return' },
    types = { 'text', 'texts', 'number', 'numbers', 'bit', 'bits' },
    operators = { '=', '/', '%', '*', '+', '-', 'is', 'not' },
    context_indicators = { '|' },
    collection_indicators = { '[', ']' },
    expression_indicators = { '(', ')' },
    string_indicators = { '\'' },
    template_literals = { '`' },
    comments = { '/*', '*/' }
}

return tokens_list