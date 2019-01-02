## Abstract
<!-- Context      -->
In empirical software engineering,
replications provide knowledge on what results hold under which conditions.
Often, these ought to be exact: the experimental procedures and their accompanying software are matched as closely as possible.
<!-- Need         -->
Because different algorithms, or implementations thereof, need to be easily swappable in a transparent manner,
a dependency injection design benefits experimental software.
Various wiring of independent components can be created, tested, and compared---even through means of static program analysis.
Within the Semantic Web,
the opportunity exists to move beyond the local scope of existing dependency injection frameworks and 
facilitate exact replication on the Web with addressable, dereferenceable, and unambiguous software configurations.
<!-- Task         -->
Therefore, 
we introduce Components.js, a semantic dependency injection framework for JavaScript,
that (i) describes software components using a Object-Oriented Components and Object Mapping vocabulary, 
(ii) automatically instantiates experimental configurations using linking and dereferencing, and
(iii) is complementary to the modular programming of package managers.
<!-- Object       -->
This article presents the framework, 
its application, 
and incorporates a proof of concept on discovery of experimental software configurations on the Web.
<!-- Findings     -->
All 700,000+ Node Package Manager libraries were described
as more than 300 million RDF triples, which interlink different modules.
Thereby, a set of queries provide insights like what experiments use the same algorithm, 
or the different implementations of the same function.
<!-- Conclusion   -->
Components.js enables research articles to complete the provenance chain of experimental results.
This ultimately brings faster and more accurate reproductions of experiments,
and facilitates the evaluation of new research contributions.

<span id="keywords" rel="schema:about"><span class="title">Keywords</span>
<a href="https://en.wikipedia.org/wiki/Dependency_injection" resource="http://dbpedia.org/resource/Dependency_injection">Dependency injection</a>;
<a href="https://en.wikipedia.org/wiki/Linked_Data" resource="http://dbpedia.org/resource/Linked_Data">Linked Data</a>;
<a href="https://en.wikipedia.org/wiki/Semantic_Web" resource="http://dbpedia.org/resource/Semantic_Web">Semantic Web</a>;
<a href="https://en.wikipedia.org/wiki/Resource_Description_Framework" resource="http://dbpedia.org/resource/Resource_Description_Framework">RDF</a>;
<a href="https://en.wikipedia.org/wiki/JavaScript" resource="http://dbpedia.org/resource/JavaScript">JavaScript</a>;
<a href="https://en.wikipedia.org/wiki/Reproducibility" resource="http://dbpedia.org/resource/Reproducibility">Reproducibility</a>;
<a href="https://en.wikipedia.org/wiki/Artificial_intelligence" resource="http://dbpedia.org/resource/Artificial_intelligence">Artificial intelligence</a>
</span>
