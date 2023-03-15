---
title: "Gren 0.2.1: Testing, testing"
published: "2023-03-15"
---

The original plan was to not do another release until Gren 0.3 this summer but, while this is still the goal, we've implemented enough functionality to warrant a new release today. The theme for Gren 0.3 is "Testing and Debugging", and Gren 0.2.1 delivers on the first half of this theme.

## Local dependencies

With Gren 0.2 and earlier, you could only depend on packages which had a semver-formatted tag on github. For users of a package this works pretty well. For developers of a package, there isn't any easy way to test the package in a project _prior_ to publishing the tag.

Gren 0.2.1 adds support for local dependencies. Local dependencies are packages that reside on your local disk. Here's how you define a local dependency:

```json
{
  "type": "application",
  "platform": "node",
  "source-directories": [
    "src"
  ],
  "gren-version": "0.2.1",
  "dependencies": {
    "direct": {
      "gren-lang/node": "1.2.0",
      "gren-lang/core": "local:..",
      "gren-lang/test": "1.0.0",
      "gren-lang/test-runner-node": "1.0.0"
    },
    "indirect": {
    }
  }
}
```

The above `gren.json` is taken from the `test` folder of [gren-lang/core](https://github.com/gren-lang/core). As you can see, `gren-lang/core` is here defined as local dependency where the package is defined to reside in the parent folder.

Local dependencies has several limitations. The compiler will refuse to compile dependencies which themselves have local dependencies, and `gren package validate` will fail if a local dependency is defined./a
Gren will also refuse to compile local dependencies which contain kernel code, that isn't also part of a git commit signed by Gren's lead developer.

## An official test framework

Gren now has two packages allowing you to test your implementation. 

[gren-lang/test](https://packages.gren-lang.org/package/gren-lang/test) is a port of [elm-exploration/test](https://package.elm-lang.org/packages/elm-explorations/test/latest), and is a package for defining tests.

[gren-lang/test-runner-node](https://packages.gren-lang.org/package/gren-lang/test-runner-node) allows you to define a Node.JS application that runs your defined tests.

A minimal test program looks like the following:

```gren
module Main exposing (main)

import Expect
import Test exposing (Test, describe, test)
import Test.Runner.Node exposing (Program, run)

main =
    run <|
        describe "Tests"
            [ test "Always true" <| \_ ->
                Expect.pass
            ]
```

To run it, you need to do the following:

```sh
gren compile src/Main.gren --output run_tests
node run_tests
```

In order to write tests for your package, you can define a test application that imports your package as a local dependency.

You can see an example of this in [gren-lang/core](https://github.com/gren-lang/core/tree/e78cc321fc7521b87c0a60c04f5d911a9442db99/tests)'s test suite.

## What's next

The next release will arrive this summer, and focus on code generation improvements for easier debugging and better performance. Hopefully, this release will also include support for generating source maps so that you can debug Gren code instead of the generated JavaScript.

That's it for now. Head over to the [install page](/install) to get started.
