---
title: "Documentation as a first class citizen"
published: "2022-08-22"
---

A crucial aspect of any programming language, is how easy it is to discover and learn new functionality. One of the most common questions asked since [Gren's first release](/news/220530_first_release) is "what can I do with Gren?" and "where can I see what's in the core package? I don't have to read the code, do I?".

Searching through github and reading source code is far from the easiest way to discover and learn the finer details of a language, so today we're proud to announce the availability of [packages.gren-lang.org](https://packages.gren-lang.org). Here you can learn the documentation of Gren's core packages, and discover third-party packages as they arrive.

### Discoverability

The packaging site provides full-text search to allow people to find a package by author, package name and keywords in the package summary. In addition, all recently updated packages are listed on the front page.

If you're a member of our [Zulip](https://gren.zulipchat.com), new package versions are posted to the `#packages` topic, so that you can discover new packages as they arrive.

### Previewing documentation

When you install the package site with [npm](https://www.npmjs.com/package/gren-packages) (`npm install -g gren-packages`), you get access to a binary called `gren-doc-preview` which will generate documentation for the package in your current directory, and host a local copy of the packaging site to display it. This let's you see exactly how the documentation will look when imported into the main packaging site, which helps you perfect your documentation with minimal effort.

### Easy to self-host

The packaging site is easy to self-host. It runs on Node 16 and uses SQLite as its database. You can run it on your own machine in order to have access to documentation offline, or you can host it on a server to host the documentation for your private packages.

Just like the Gren compiler, the packages site uses your local install of Git to retrieve packages from Github. As long as your git client has access to a Gren repo, the packages site can import it as well.

### Future enhancements

Today marks the first release, but it certaintly won't be the last. Several new features are planned for the future, like being able to mirror another package server, extensive caching and recursive imports of the dependencies of a package.

We believe that this new packaging site will enable new developers to discover new packages and learn how those packages work.

As always, if you've got some idea on how to improve it, we hope to discuss it further on our [Zulip](https://gren.zulipchat.com). See you there?
