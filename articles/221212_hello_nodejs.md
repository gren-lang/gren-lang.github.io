---
title: "Gren 0.2: Hello, NodeJS"
published: "2022-12-12"
---

Six months after the release of 0.1, a new release is here with a bunch of exciting features. This includes a built-in code formatter and basic support for creating applications that run on NodeJS.

## Platforms

When defining new projects, you now need to specify which platform you're targeting. There are three platforms to choose from: `common`, `browser` and `node`. The latter two decide where the application can run, wheras the `common` platform indicates that your code can run anywhere. In other words, packages targeting the `common` platform can be dependencies of either `browser` and `node` projects.

In practical terms, the platform setting decides which core packages you're allowed to depend on. If you're targeting the `browser` platform, you're _not_ allowed to depend on `gren-lang/node`, directly or indirectly. Likewise, a project targeting the `node` platform is forbidden from depending on `gren-lang/browser`. When targeting the `common` platform, you can depend on neither.

In order to make it easier to setup a project correctly, we've added two flags to the `gren init` command: `--package` and `--platform`. For instance, if you want to create a package project targeting the `node` platform, you can run:

```sh
gren init --package --platform node
```

If you'd rather create a `node` application, then just leave out the `--package` flag.

The long-term goal is to support all built-in NodeJS API's, but currently we only support a small subset. To get a better idea of what's possible you can read the [gren-lang/node documentation](https://packages.gren-lang.org/package/gren-lang/node) or take a look at the [cat example program](https://github.com/gren-lang/example-projects/tree/main/cat).

You might also want to take a look at this [live demo](https://www.youtube.com/watch?v=IGEOvIHDlBI) where Robin implements the unix echo program in Gren.

## Formatting

Aaron VonderHaar, the author of `elm-format`, was working on a formatting tool for Gren before 0.1 was even released. With Gren 0.2, this tool is now ready to use.

To format your project, simply run `gren format`. To validate the formatting of a project, just run `gren format --validate`.

While the formatter should work well enough for most projects, it's not finished. Bugs and less-than-stellar formatting is to be expected in some cases. If you come across any interesting behaviour, please let us know.

## Package consolidation

Several different packages have now been consolidated into fewer, but bigger packages. For example: `gren-lang/virtual-dom`, `gren-lang/html` and `gren-lang/svg` are now merged into `gren-lang/browser`.

The main reason for doing this has to do with project management. It's easier for me to deal with 5 bug trackers than 15, and it takes less time to migrate and publish 5 packages to Gren 0.2, instead of 15.

At the same time, there aren't really any downsides to developers. Fewer packages means less time being spent downloading packages, and since Gren has excellent dead-code elimination, your compiled output isn't getting bigger either.

Everything hasn't been consolidated, though. `gren-lang/url`, `gren-lang/parser` and `gren-lang/web-storage` do still exist and will continue to do so until I'm certain that their API is stable enough to be consolidated into one of the "big three" packages.

Going forward, new functionality is likely to be introduced in standalone packages, then become merged into the right platform package when the API has stabilized.

## Package management

The package manager has improved in almost every way.

It is now significantly faster, gives detailed error messages when you have incompatible dependencies in your project, and has learned a few new tricks to make it easier to manage your dependencies.

There's now a `gren package uninstall` command for removing a dependency from your project, as well as `gren package outdated` for seeing which dependencies are out of date.

## New language features

Gren 0.2 also brings a few new language features. These don't radically change the language in any way, but provide small quality-of-life improvements.

### Record update now works on any expression

In 0.1, record update syntax only worked on variable names, like this:

```gren
originalRecord = { value = "original" }

updatedRecord = { originalRecord | value = "updated" }
```

However, any other expression isn't legal. So you can't do things like this:

```gren
updatedRecord = { OtherModule.originalRecord | value = "updated" }
```

This is one of the only places where we have such limitations. For instance, we don't limit what expressions you can have in `if` expressions or `case` expressions, or even inside literals. So it's confusing when a limitation like this exists.

In 0.2, you can now use record update syntax with _any_ expression. The above snippet will now compile, but so will much more complex expressions.

This change was contributed by Julian Antonielli.

### Import aliases can now contain dots

Exactly what it says on the tin, the following import statement is now legal:

```gren
import Much.Nested.Module.Path as Nested.Path
```

### Named unused constants

When pattern matching or defining functions, you can use `_` to ignore a value. Here's an example:

```gren
length : Array a -> Int
length array =
    Array.foldl (\_ len -> len + 1) 0 array
```

Sometimes, it can be helpful to attach a name to the ignored value, as a reminder for what the value represents. In 0.2, you can do just that:

```gren
length : Array a -> Int
length array =
    Array.foldl (\_value len -> len + 1) 0 array
```

Note: trying to use `_value` will trigger a compilation error.

This feature was contributed by Allan Clark.

### Multi-line strings trims leading whitespace

Gren has dedicated syntax for defining a multi-line string. It looks like this:

```gren
str =
    """
    this
      is a
    string
    """
```

In 0.1, this is equivalent to

```gren
str = "\n    this\n      is a\n    string\n"
```

In 0.2, multi-line strings trims away a common number of leading whitespace on each line, so that the multi-line string compiles to the equivalent of:

```gren
str = "this\n  is a\nstring"
```

## What's next?

The 0.2 release is a big release, but we have no intention of stopping here. The 0.3 release will focus on testing & debugging, and will include features such as an official test framework, source maps for viewing Gren code in a JavaScript debugger and improved code generation.

Since Gren will continue with its six-month release cadence, 0.3 is scheduled for release in June 2023.

That's it for now. Head over to the [install page](/install) to get started.
