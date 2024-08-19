---
title: "Upcoming language changes"
published: "2024-08-19"
---

Every time Gren gets a bit of attention, as it recently did with the release in June, someone will notice that Gren began its life as a fork of Elm and ask me to put that in plain writing on the website or the compiler's README.md.

The reason I don't want to make that connection more apparent than it already is, is that I don't want to give people the impression that Gren is just Elm with new management, or a more actively developed Elm.

It isn't.

While Gren looks pretty similar to Elm at a surface level, it has diverged enough that porting a project from one to the other is a little painful, and that pain will only grow over time.

While Gren shares the same underlying philosophy as Elm, they are independent languages and will continue to evolve without consideration to how easy it is to port code between them.

At this point you might be thinking: "Evolve? How?"

What follows is a list of changes that I'm certain will be implemented in the next year or two. This list isn't exhaustive,  but gives a good impression of the direction of the language.

If you've got experience with Elm but are new to Gren, it might be a good idea to [read how Gren differs from Elm](https://gren-lang.org/book/appendix/faq/) before continuing.

## New syntax for type aliases

Type aliases are going to become much more common in Gren (more on this later), and for that reason it might be worth reducing the keystrokes required to make them.

The syntax for defining a type alias will change from 

```
type alias Named = { name : String }
```

to

```
Named : { name : String }
```

I first saw this syntax in [Roc](https://www.roc-lang.org/) and it instantly felt like a good idea. Not only is it shorter, but it feels natural since it's exactly how you define the types of functions and values elsewhere.

## Opaque aliases

When defining custom types, you can decide between exposing just the name of the custom type, or the name as well as its constructors. We call the former opaque types. You can refer to the type, but you can't make any assumptions about what the type represents.

We're intending to allow for opaque type aliases. That is, you will be able to expose only the name of an alias, and not what it is an alias of. In the case of records, this means you no longer need to wrap a record in a custom type in order for it to be opaque.

```
module Example exposing
  ( OpaqueRecord
  , ExposedRecord(..)
  )
  
OpaqueRecord : { secret : String }

ExposedRecord : { gossip : String }
```

The downside is that you need to add type annotations to any function that takes in or returns opaque values, otherwise the compiler will infer the literal (non-opaque) type.

## Structural sum types

Currently, you can define sum types like this:

```
type Fruit
  = Apple
  | Banana
```

This type is nominal. You cannot define a function that accepts any type as long as it has an `Apple` constructor, or as long as it is a superset of `Fruit`. Neither can the compiler infer the type based on usage. It must be defined.

This is in contrast to how records work. Records are structural. You can define a function that works on any record as long as it has a specific set of fields. Records can be inferred. You can even define records as extensions of other records.

Gren intends to make sum types structural. As a consequence, we don’t need a specific language construct for defining a sum type. Naming sum types can simply be done with aliases:

```
Fruit : | Apple | Banana
```

Note the leading pipe symbol. It's what separates sum types from other types.

This is a feature that you'll also find in Roc, but I actually [first heard of the idea on the Elm discourse](https://discourse.elm-lang.org/t/idea-extensible-union-types-and-benefits-they-bring-for-real-world-elm-code/6118) back in 2020. Of course, it probably exists in a few other languages as well.

While on the topic of sum types, Gren will further limit them to 0 or 1 arguments. The reasons behind this overlaps with [why tuples where removed](https://youtu.be/Sl9HHo1qDk0?si=wiJjSEMyl0f6HqTn), but there's also a performance argument to be made.

By making all sum type constructors take at most 1 argument, we can implement it as a simple object, which means the JavaScript engine will treat pattern matches on sum types as monomorphic code and optimize it well.

## Parametric modules

To me, the biggest shortcoming of Elm (besides lacking first-class support for a server/terminal environment) is that you cannot easily store any given type as the key in a `Dict` or as an item in a `Set`. These types only accept things that are `comparable`, and that is a category you're not allowed to expand.

There are ways to work around this, sure, but considering how useful these data structures are it's a shame that you need to put in extra work in order to make full use of them.

Another thing that is a shame is that you're bound to `comparable`. Need the performance of a hash map? You now need to create a layer of abstraction for each type you'd like to store, or you would have to store the hash function in the instance of the data structure. If you choose the latter, running `==` on anything containing your hash map will crash at runtime.

In a statically typed language as strict as Elm, useful data structures like `Dict` and `Set` shouldn't nudge you towards primitive types.

Gren will at some point remove `appendable`, `comparable`, `number` and reflection-based functions like `==`. Instead, Gren will offer parametric modules.

Parametric modules allows you generate new modules at compile time. If you want a `Dict` that uses `MyType` as the key, you can generate that. If you want a `HashMap` where the key is an `(Array (Array Int))` you can generate that as well.

It will look something like the following:

```
import Dict MyType as MyTypeDict
import Dict String as StringDict
```

`MyTypeDict` and `StringDict` are two different modules, but generated based on the same template.

It's important to point out that `MyType` and `String` are not referring to types, but modules. It's possible to define a `ReverseCompareString` module that when passed as an argument to `Dict` will still use `String` as keys, but where the keys will be stored in reverse alphabetical order.

You can [read more about parametric modules on this github issue](https://github.com/gren-lang/compiler/issues/81).

Now you might wonder: "what's wrong with type classes?"

My interpretation of why type classes never made it into Elm was because (1) it's hard to write good error messages when you are dealing with abstract types and interfaces and (2) it's easy to define and implement a type class that they have a habit of being used everywhere, even when there's no need.

For me, the biggest problem is that type classes form a global namespace. If someone implements a type class for a type, then no one else can provide a different implementation for that type, unless you're being clever/lucky with the imported modules. With parametric modules there is no global namespace. You can define three `Dict String`s, all with different comparison functions.

I also think parametric modules require a bit of planning to use well, so they're not as likely to be used everywhere type classes are (which I consider a plus).

## Overridable operators

Without type classes like `number`, `comparable` and `appendable`, we need to re-consider how operators work in Gren.

The current implementation of operators is a bit confusing. The language itself has support for custom operators, but it's locked down so that only the core team are allowed to use it.

The reasoning behind this is that custom operators can easily make code unreadable, as it's hard to remember the meaning of a foreign symbol and how they work regarding associativity and precedence. On the other hand, for mathematical expressions it's easier to read code that uses mathematical operators compared their function-based substitute. The limit on defining custom operators was meant to preserve a balance between too many and too few operators.

Unfortunately, you can find several examples of unnecessary operators in Gren's own core packages, like the `url` package and the `parser` package. These operators don't make any sense outside of their respective packages, and I believe many people are annoyed that there are different rules for the general community and the core team.

The currently defined operators could also be more flexible. It makes perfect sense to allow a `BigInt` type to be used in mathematical expressions, or allow the `++` operator on any sequence-like data structure, even those defined in third-party packages.

To solve both of these problems, a future version of Gren will remove syntax for defining custom operators. Operators will be reduced to a fixed set and treated like (special) functions.

Lets look at an expression like `a + b`. What is `+` in this case? In the future that will depend on what you have in scope. If you have an import statement like `import Int exposing (+)`, then `a + b` will represent integer addition.

You can define your own implementation of `+`:

```
(+) : BigInt -> BigInt -> BigInt
(+) a b =
  (BigInt.toInt a) Int.+ (BigInt.toInt b)
```

As you can see, we'll also allow qualified operators like `Int.+` so that it's possible to refer to different implementations of a given operator within a module.

It's important to note that you won't be allowed to define entirely new operators, or redefine precedence and associativity rules for existing ones. 

## Wrapping up

As mentioned, these are features I'm certain will make it into the language in the next couple of years. Most, if not all, of these will arrive when the parser is rewritten in Gren.

If you'd like to keep updated on the progress on these and other language features feel free to join us on [Discord](https://discord.gg/Chb9YB9Vmh).
