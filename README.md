# L#
L# ("L Sharp") is a programming language initially written in lua. It has a few goals in mind:

- L# is intended to be easy-to-write, easy-to-read, immutable by default, general-purpose, extensible, platform-agnostic programming language
- The language is intended to interoperate with other systems and languages
- The language does not allow code that would violate any memory safety; memory should not be a concern of the programmer
- The language does not enforce any specific architecture or structure (with spaces, folders, groupings of files, or brackets), rather, the programmer decides and implements how they see fit
- L# applications are intended to be economical with regard to memory and processing, the language is intended to compete directly on performance and size with C or assembly language

If you're curious, you can read more about it in the [L# language spec](spec) included in this repo.

## Syntax

Here is a sample of some [simple L# source code](./examples/simple.ls):

```lsharp
/* grab the io library for it's logging functions */
grab io

/* A normal logging function */
io.log('A normal call to io.log from L#.')

/* Full suite of named log functions */
io.debug('A normal call to io.debug from L#.')
io.information('A normal call to io.information from L#.')
io.warning('A normal call to io.warning from L#.')
io.error('A normal call to io.error from L#.')

/* Full suite of log functions with severity specified */
io.log('A call to io.log with "debug" severity from L#.', 1)
io.log('A call to io.log with "information" severity from L#.', 2)
io.log('A call to io.log with "warning" severity from L#.', 3)
io.log('A call to io.log with "error" severity from L#.', 4)

/* declaring and assiging the number type */
number temperature = 98.4

/* logging the number that was assigned */
io.information('Temperature set: `temperature`')
```

It will produce output that looks like this:

![A screenshot of console output of a simple L# program.](assets/simple-file-console-output.png)

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