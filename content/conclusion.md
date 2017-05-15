## Conclusion
{:#conclusion}

The core idea of the scientific process is _to stand on the shoulders of giants_,
i.e., building further upon previous work to derive new work.
Not only does this concept apply to Web research, next to that,
the Web is an ideal platform to _improve_ the scientific process as a whole.
Reproducibility, for instance, is an essential aspect of this process.
Without it, building and improving upon previous work can become difficult.

In this article, we introduce vocabularies for semantically describing software components and their configuration.
Publishing this information alongside experimental results is beneficial for the reproduction of experiments.
Furthermore, we introduce Components.js, a dependency injection framework that can _understand_ such configurations,
and _instantiate_ software in the exact same way as originally described.

In future work, we aim to make the creation of semantic component files more developer friendly.
A tool could be built that automatically parses source code,
and derives the appropriate semantic description on how components can be instantiated using which parameters.
Nex to that, these semantic component definition files provide an interesting platform for validating software dependency relations.
Reasoning could for instance be done on parameter restrictions to check whether
or not different bundle versions will break certain component invocations.
Furthermore, the semantic description of software metadata provides a useful platform for simplifying tasks that require a lot manual work,
such as discovering license incompatibilities between projects, which are now possible using a [SPARQL query](https://query.linkedsoftwaredependencies.org/#query=SELECT%20*%20WHERE%20%7B%0A%20%20%3Fbundle%20spdx%3AlicenseDeclared%20%3Chttps%3A%2F%2Fspdx.org%2Flicenses%2FGPL-3.0.html%3E.%0A%20%20%3Fbundle%20npm%3Adependency%20%3Fdependency.%0A%20%20%3Fdependency%20spdx%3AlicenseDeclared%20%3Chttps%3A%2F%2Fspdx.org%2Flicenses%2FGPL-2.0.html%3E.%0A%7D).

Through this work, we make it easier to build sustainable research platforms,
which paves the way to the shoulders of giants.
Our Linked Data Fragments server, for instance, is a reusable research platform.
The LDF server (and client) can be compatible with multiple APIs, have multiple algorithms, ...
Up until now, these different variants were made available as different software branches, which complicates their usage.
Through this work, only one "core version" exists, and many different configurations can exist,
where support for different APIs and algorithms are simply pluggable components that are refered to within a configuration.
As components and configurations are identified by a URI,
they can exist anywhere on the Web.
Based on a URI, the injection framework can therefore instantiate software,
and wire its dependent components together automatically, thereby leveraging the power of the Web to simplify the method of reproducibility.
