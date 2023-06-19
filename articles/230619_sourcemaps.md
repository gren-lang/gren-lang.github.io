---
title: "Gren 0.3.0: Source maps"
published: "2023-06-19"
---

JavaScript developers have always had access to a powerful debugger for finding bugs in their applications. Since Gren compiles to JavaScript, it's also possible to use the same tool for debugging Gren applications. The experience isn't great, however, as you're forced to debug the JavaScript that the compiler spits out instead of the actual code you wrote.

Until today, that is.

Gren 0.3.0 is now released, and with it comes the option of outputting source maps.

Source maps is a JSON data structure that the JavaScript runtime can read in order to understand the relation between the currently running code, and the source code it orignated from. When source maps are available, you can actually debug Gren code in the JavaScript debugger.

All you have to do is to pass the `--sourcemaps` flag to the compiler:

```sh
gren make src/Main.gren --sourcemaps
```

To see how source maps improves Gren's debugging experience, you can watch [Robin's demo](https://youtu.be/Fly0y4lFgDc?t=515) of this feature on youtube.

## What's next?

With the release of Gren 0.3, focus now turns to the 0.4 release in December. The main feature for that release will be Parametric Modules, which you can learn more about in this [Github issue](https://github.com/gren-lang/compiler/issues/81) or in this [video presentation](https://youtu.be/Fly0y4lFgDc?t=1099).

That's all for now. Head over to the [install page](/install) to get started.
