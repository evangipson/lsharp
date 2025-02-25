# L#
L# ("L Sharp") is a programming language initially written in lua. It has a few goals in mind:

- L# is intended to be easy-to-write, easy-to-read, immutable by default, general-purpose, extensible, platform-agnostic programming language
- The language is intended to interoperate with other systems and languages
- The language does not allow code that would violate any memory safety; memory should not be a concern of the programmer
- The language does not enforce any specific architecture or structure (with spaces, folders, groupings of files, or brackets), rather, the programmer decides and implements how they see fit
- L# applications are intended to be economical with regard to memory and processing, the language is intended to compete directly on performance and size with C or assembly language

If you're curious, you can read more about it in the [L# language spec](spec) included in this repo.

## Syntax

Here is a sample of a very simple L# file:

```lsharp
/* declaring and assigning the text type */
text phrase = "Hello, world!"

/* declaring and assigning a collection of text types */
texts phrases = [ "Hello", "world!" ]

/* declaring and assigning the number type */
number temperature = 98.4

/* declaring and assigning a collection of number types */
numbers temperatures = [ 97, 98.4, 100.001 ]

/* declaring and assigning the bit type */
bit zero = off

/* declaring and assigning a collection of bit types */
bits mask = [ off, on, off, off, on, off ]

/* defining a contract for a user type without implementation */
contract shape
    text id
    number width
    number height
    number area()

/* defining an implementation of a contract */
square is shape
    /* defining what happens when assigning to a user type */
    square(number a, number b)
        width = a
        height = b
        id = 'Square with `a` width and `b` height'

    /* defining an implementation of a function from the contract */
    number area()
        return width * height
```

## Run
- Install lua
- Download the repo
- From the repo root, run the example L# file with `lua ./init.lua ./examples/spec.ls [-d|--debug]`
    - The `-d` or `--debug` flag will turn debug mode on and show compiler information.

## Architecture
The compiler will read the L# file, break it up into understandable lexemes, parse those lexemes into statements, then invoke those statements.

It will also raise errors to the caller if errors do occur.

## Todo
- Finish L# language spec
- Finish L# VSCode extension
- Create an L# compiler binary from the lua compiler code
- Create an L# compiler in L#