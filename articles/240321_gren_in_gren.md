---
title: "Gren-in-Gren, and other developments"
published: "2024-03-21"
---

The first few lines of a new Gren compiler is being written this week. The goal is to better support upcomming features of the language, as well as being
easier to maintain and debug. The hope is also that it will be easier for the community to contribute, as the new compiler is being written in Gren itself.

The goal is to rewrite the compiler incrementally and release each new piece of the compiler as it is ready. You can still expect new features every six months,
and the first version of the compiler that contains Gren code will be Gren 0.4, scheduled for June.

For more details on Gren-in-Gren, check out the youtube video below.

[![Robin and Justin demoing new functionality](https://img.youtube.com/vi/t6TVmM_664o/0.jpg)](https://www.youtube.com/watch?v=t6TVmM_664o)

## HttpClient for node based applications

In addition to Gren-in-Gren, the video also demos the new HttpClient API in [gren-lang/node](https://packages.gren-lang.org/package/gren-lang/node/version/3.2.0/overview). This means that you can now create HTTP servers and make HTTP requests
when writing Gren applications that target the node platform.

As if that wasn't enough, Justin Blake also demos the new [Prettynice web framework](https://github.com/blaix/prettynice) for Gren, that makes it easy to write a Gren-based backend with Gren-based components
on the frontend.

## Improved core packages

Gren's core packages (`gren-lang/core`, `gren-lang/node` and `gren-lang/browser`) have all been updated. Besides the already mentioned HttpClient API for node, the `gren-lang/web-storage` package has been consolidated
with `gren-lang/browser`, and several bugs have been squashed. The documentation has also been updated to be easier to read.

Here's a few notable bugs that have been fixed:

* We correctly refer to the _Elm_ architecture in our documentation. This was incorrectly renamed to the Gren architecture in the initial days of the project.
* The time-travelling debugger failed to show up in browser applications.
* The time-travelling debugger overlay now has a class attached, so you can easily hide or move it using css.
* `Bytes` now work with `==`
* `Regex.fromString ""` now returns `Nothing`
* `logBase 10` is now more precise. Notably, `logBase 10 1000` now returns 3, as you'd expect.
* The `String` API now makes no attempt to concatenate UTF-16 surrogate pairs. Gren strings are now plain old JavaScript strings. This should improve performance, and fix a few bugs, at the cost of not being more like JavaScript.
