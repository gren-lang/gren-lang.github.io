---
title: "Gren 0.1.0 is released"
published: "2022-05-30"
---

Today marks the first release of Gren, a programming language that helps you write simple and correct software.

Gren aims to be a small language that is easy to learn, and easy to understand. It wants to help you write correct software by being your assistant, pointing out likely mistakes as you write code. Finally, it tries to be available wherever you need it to be, so that you can use it to write CLI tools, backend- or even frontend applications.

There already exist a language that is close to matching this description: [Elm](https://elm-lang.org). What Elm lacks is better support for Web API's, and official support for running outside the browser.

While we could spend considerable time and effort in creating a language which would look very similar to Elm, we've instead decided to fork the compiler and core packages, and use that as the basis of Gren.

### Differences from Elm

If you already know Elm, then you also know Gren. Even the core packages are similar. That said, there are some differences:

* A git-based package manager. It's slower, but has access to any github repo that you have, even private ones.
* Extended support for pattern matching on records.
* The default sequential data structure is an immutable array, not a linked list.
* No tuples.
* No automatic constructors for type aliased records.
* No GLSL syntax.
* No reactor.

If you have no experience with Elm, you can read more about the language in our official [guide](/learn). If you'd like to try it out, you can find instructions on getting started [here](/install).

Version 0.1.0 is considered to be an alpha release. While you can write production quality software with it today, there are likely bugs in the compiler and core packages, and breaking changes are planned for the next release.

If you like what you see, consider joining the [community](/community). We can use all the help we can get.

### Looking forward

Gren follows a six-month release cadence. The next release will be v0.2.0 and be made available in December.

The plan is to add support for more Web API's and basic support for applications running on the NodeJS runtime. In addition, the package manager will become more efficient and reliable.

### Thank you, contributors

This release of Gren was made possible by people who've written new code, ported packages from Elm and provided valuable feedback on [Zulip](https://gren.zulipchat.com). Those people are, in alphabetic order:

* Aaron VonderHaar
* Allan Clark
* Dimitri B.
* Gabriella Sartori
* Gaute Berge
* Harry Sarson
* Jeroen Engels
* Joaquin
* Julian Antonielli
* Lue
* Mario Rogic
* Oliver Schöning
* Ragnhild Aalvik
* Robin Heggelund Hansen

Thank you!
