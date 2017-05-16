## Conclusion
{:#conclusion}

The core idea of the scientific process is _to stand on the shoulders of giants_.
This means building further upon previous work to derive new work—but
also, enabling others to build upon our work.
Reproducibility, for instance, is an essential aspect of this process.
Not only does this concept apply to Web research as well,
but the Web makes an ideal platform to _improve_ the scientific process as a whole.

In this article, we introduce vocabularies for semantically describing software components and their configuration.
Publishing this information alongside experimental results is beneficial for the reproduction of experiments.
Furthermore, we introduce Components.js, a dependency injection framework that can _understand_ such configurations,
and _instantiate_ software in the exact same way as originally described.

In future work, we aim to make the creation of semantic component files more developer-friendly.
A tool can automatically parse source code
and derive the appropriate semantic description on how components can be instantiated using which parameters.
Additionally, these semantic component definition files provide an interesting platform for validating software dependency relations.
Reasoning could for instance be done on parameter restrictions to check whether
or not different bundle versions will break certain component invocations.
Furthermore, the semantic description of software metadata provides a useful platform for simplifying tasks that require a lot manual work,
such as discovering license incompatibilities between projects, which are now possible using a [SPARQL query](https://query.linkedsoftwaredependencies.org/#query=SELECT%20*%20WHERE%20%7B%0A%20%20%3Fbundle%20spdx%3AlicenseDeclared%20%3Chttps%3A%2F%2Fspdx.org%2Flicenses%2FGPL-3.0.html%3E.%0A%20%20%3Fbundle%20npm%3Adependency%20%3Fdependency.%0A%20%20%3Fdependency%20spdx%3AlicenseDeclared%20%3Chttps%3A%2F%2Fspdx.org%2Flicenses%2FGPL-2.0.html%3E.%0A%7D).
This even allows us to come up with SPARQL queries corresponding to some of the questions
that [the Web was intended to give an answer for](cite:citesForInformation InformationManagementAProposal),
such as <q markdown="1">[Where is this module used?](https://query.linkedsoftwaredependencies.org/#query=SELECT%20DISTINCT%20%3Fproject%20%3FprojectName%20%3Fdescription%20WHERE%20%7B%0A%20%20%3Chttps%3A%2F%2Flinkedsoftwaredependencies.org%2Fbundles%2Fnpm%2Fn3%3E%20doap%3Arelease%20%3Fversion.%0A%20%20%3Fdependingversion%20npm%3Adependency%20%3Fversion.%0A%20%20%3Fproject%20doap%3Arelease%20%3Fdependingversion.%0A%20%20%3Fproject%20doap%3Aname%20%3FprojectName.%0A%20%20%3Fproject%20dc%3Aabstract%20%3Fdescription.%0A%7D)</q> and <q markdown="1">[Who wrote this code?](https://query.linkedsoftwaredependencies.org/#query=SELECT%20*%20WHERE%20%7B%0A%20%20%3Chttps%3A%2F%2Flinkedsoftwaredependencies.org%2Fbundles%2Fnpm%2Fn3%3E%20doap%3Amaintainer%20%3Fauthor.%0A%20%20%3Fauthor%20foaf%3Aname%20%3Fname.%0A%20%20%3Fauthor%20foaf%3Ambox%20%3Fmail.%0A%7D)</q>.

Through this work, we make it easier to build sustainable research platforms,
which helps pave the stairs to the shoulders of giants.
The Linked Data Fragments server, for instance, is a reusable research platform.
The LDF server and client can be compatible with multiple APIs, have multiple algorithms, etc.
Through this work, only one "core version" is necessary, and many different configurations can co-exist,
where support for different APIs and algorithms are simply pluggable components that are referred to within a configuration.
Since components and configurations are identified by a IRI,
they can exist anywhere on the Web.
Based on a IRI, the injection framework can therefore instantiate software,
and wire its dependent components together automatically.
We thereby leverage the power of the Web to simplify the reproduction of existing experiments
and the creation of new ones.
