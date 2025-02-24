# Standard Library

## General
The standard library is intended to be the minimum set of types and members required by a conforming L# implementation. As such, it contains only those members that are explicitly required by the L# language specification.

## Standard Library Types
<pre>
<code style='color: #737373'>/* declaring and assigning the text type */</code>
<code style='color: #75b7fd'>text</code> <code style='color: #bbd500'>phrase</code> = "Hello, world!"

<code style='color: #737373'>/* declaring and assigning a collection of text types */</code>
<code style='color: #75b7fd'>texts</code> <code style='color: #bbd500'>phrases</code> = [ "Hello", "world!" ]

<code style='color: #737373'>/* declaring and assigning the number type */</code>
<code style='color: #75b7fd'>number</code> <code style='color: #bbd500'>temperature</code> = 98.4

<code style='color: #737373'>/* declaring and assigning a collection of number types */</code>
<code style='color: #75b7fd'>numbers</code> <code style='color: #bbd500'>temperatures</code> = [ 97, 98.4, 100.001 ]

<code style='color: #737373'>/* declaring and assigning the bit type */</code>
<code style='color: #75b7fd'>bit</code> <code style='color: #bbd500'>zero</code> = <code style='color: #ff8a00'>off</code>

<code style='color: #737373'>/* declaring and assigning a collection of bit types */</code>
<code style='color: #75b7fd'>bits</code> <code style='color: #bbd500'>mask</code> = [ <code style='color: #ff8a00'>off</code>, <code style='color: #ff8a00'>on</code>, <code style='color: #ff8a00'>off</code>, <code style='color: #ff8a00'>off</code>, <code style='color: #ff8a00'>on</code>, <code style='color: #ff8a00'>off</code> ]

<code style='color: #737373'>/* defining a contract for a user type without implementation */</code>
<code style='color: #75b7fd'>contract</code> <code style='color: #bbd500'>shape</code>
    <code style='color: #75b7fd'>text</code> <code style='color: #bbd500'>id</code>
    <code style='color: #75b7fd'>number</code> <code style='color: #bbd500'>width</code>
    <code style='color: #75b7fd'>number</code> <code style='color: #bbd500'>height</code>
    <code style='color: #75b7fd'>number</code> <code style='color: #ffe600'>area</code>()

<code style='color: #737373'>/* defining an implementation of a contract */</code>
<code style='color: #75b7fd'>shape</code> <code style='color: #bbd500'>square</code>
    <code style='color: #737373'>/* defining what happens when assigning to a user type */</code>
    <code style='color: #ffe600'>square</code>(<code style='color: #75b7fd'>number</code> <code style='color: #ff7B9c'>a</code>, <code style='color: #75b7fd'>number</code> <code style='color: #ff7B9c'>b</code>)
        <code style='color: #bbd500'>width</code> = <code style='color: #ff7B9c'>a</code>
        <code style='color: #bbd500'>height</code> = <code style='color: #ff7B9c'>b</code>
        <code style='color: #bbd500'>id</code> = "Square with `<code style='color: #ff7B9c'>a</code>` width and `<code style='color: #ff7B9c'>b</code>` height"

    <code style='color: #737373'>/* defining an implementation of a function from the contract */</code>
    <code style='color: #75b7fd'>number</code> <code style='color: #ffe600'>area</code>()
        <code style='color: #ff8a00'>return</code> <code style='color: #bbd500'>width</code> * <code style='color: #bbd500'>height</code>
</pre>