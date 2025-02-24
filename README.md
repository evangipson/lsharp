# L#
A language written in lua that resembles C#.

Here is a sample of a very simple L# file:

```csharp
using System.Console;

Console.WriteLine("this is a message from L#!");
```

## Run
- Install lua
- Download the repo
- From the repo root, run the example L# file with `lua ./init.lua ./examples/simple.ls [-d|--debug]`
    - The `-d` or `--debug` flag will turn debug mode on and show compiler information.

## Architecture
The compiler will read the L# file, break it up into understandable lexemes, parse those lexemes into statements, then invoke those statements.

It will also raise errors to the caller if errors do occur.