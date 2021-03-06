---
title: "Hello, world!"
description: "Learn how to setup the easiest project known to man: \"Hello, world!\""
---

Getting a simple program to compile is a good way to verify that you've got everything setup correctly. Let's try to write a Gren program that outputs "Hello, world!" when opened up in browser.

If you haven't already, make sure you've [installed Gren](/install).

When you've setup the compiler correctly, it's time to initialize our project. We're going to assume that you've got a bash terminal setup.

#### Gren.json

Start by creating a `hello_world` directory, and `cd` into it.

Every Gren project contains a `gren.json` file. This file contains all the information that the compiler needs to compile your program. You can create such a file by running `gren init`.

```sh
robin@bekk-mac-2715 ~/W/g/tmp> gren init
Hello! Gren projects always start with an gren.json file. I can create them!

Would you like me to create an gren.json file now? [Y/n]: 
Updating gren-lang/browser... Ok!
Updating gren-lang/core... Ok!
Updating gren-lang/html... Ok!
Updating gren-lang/json... Ok!
Updating gren-lang/time... Ok!
Updating gren-lang/url... Ok!
Updating gren-lang/virtual-dom... Ok!
Okay, I created it.
```

The compiler will create a `gren.json` file for you that lists a few dependencies required to compile a simple browser based application. These dependencies are then downloaded, which explains the output you see above.

The `gren.json` file should look something like the following:

```json
{
    "type": "application",
    "source-directories": [
        "src"
    ],
    "gren-version": "0.1.0",
    "dependencies": {
        "direct": {
            "gren-lang/browser": "1.0.0",
            "gren-lang/core": "1.0.0",
            "gren-lang/html": "1.0.0"
        },
        "indirect": {
            "gren-lang/json": "1.0.0",
            "gren-lang/time": "1.0.0",
            "gren-lang/url": "1.0.0",
            "gren-lang/virtual-dom": "1.0.0"
        }
    },
    "test-dependencies": {
        "direct": {},
        "indirect": {}
    }
}
```

Let's explain this property by property:

* `type`: this tells the compiler that we're attempting to compile a Gren application, as opposed to a package. Packages have slightly different `gren.json` files. You can see an example if you run `gren init --package`.
* `source-directories`: This lists every sub-folder that the compiler should look for Gren source files in. This is usually fine as is.
* `gren-version`: Which version of the compiler is this application compatible with. If you're using an unsupported compiler, it will not compile.
* `dependencies`: Lists the packages required for you application to function. Direct dependencies are those which you application make direct use of, while indirect dependencies are usually required by your direct dependencies.
* `test-dependencies`: Unused for now, as Gren hasn't gotten a test framework yet.

Your `gren.json` should be good enough for what we're about to do, so let's write some actual code.

#### Writing your program

Create a `src/Main.gren` file and fill it with the following content:

```gren
module Main exposing (main)

import Html exposing (Html)

main : Html a
main =
  Html.text "Hello, world!"
```

We create a new module, called `Main` and expose the `main` constant from it.

Then, we import the `Html` module (from the `gren-lang/html` package listed in our dependencies) and expose the `Html` type to our module.

Our `main` constant represents a `Html` value, which in this particular case is just the text `Hello, world!`.

Compile this using `gren make src/Main.gren`. This will produce a `index.html` file which, when opened, displays `Hello, world!`.

