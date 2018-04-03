## Abstract
<!-- Context      -->
In Empirical Software Engineering,
_replications_ provide knowledge on what results hold under which conditions.
Often, a replication ought to be _exact_: the experimental procedures and its accompanying software are matched as closely as possible.
<!-- Need         -->
Because different algorithms, or implementations thereof, need to be easily swappable in a transparent manner,
writing experimental software benefits from the Dependency Injection (DI) design pattern.
Various wiring of independent components can be created, tested, and compared---even through means of static program analysis.
Within Semantic Web,
the opportunity exists to move beyond the local scope of existing DI frameworks and 
facilitate exact replication on the Web with addressable, citable, dereferencable, unambiguous software configurations.
<!-- Task         -->
Therefore, 
we introduce Components.js, a Semantic Dependency Injection framework for JavaScript,
that (i) describes software components using a _Object-Oriented Components ontology_, 
(ii) automatically instantiates experimental configurations using the Linked Data merits of linking and dereferencing, and
(iii) is fully complementary to the _modular programming_ design common to package managers.
<!-- Object       -->
This article lays out the structure of this framework, 
explains its application, 
and incorporates a proof-of-concept in both discovery and comparison of experimental software configurations on the Web.
<!-- Findings     -->
We were able to publish the metadata of all 480,000+ Node Package Manager (npm) libraries, resulting in
more than 3 million RDF triples that semantically describe configurations, which interlink different modules.
Thereby, a set of queries provide insights such as what experiments use the same algorithm, 
the author of certain code, and the different implementations of the same function.
<!-- Conclusion   -->
Components.js enables research articles to refer to fine-grained, 
instantiatable descriptions of experimental setups by URL,
which completes the provenance chain of 
specification, implementation, components, configuration, and experimental results.
This ultimately brings faster and more accurate reproductions of experiments,
and facilitates the evaluation of new research contributions.
