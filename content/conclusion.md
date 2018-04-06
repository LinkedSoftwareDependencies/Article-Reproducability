## Conclusion
{:#conclusion}

In this article, we introduced Components.js, a dependency injection framework that
(i) _interprets_ semantically described software components and their configuration, and thereby
(ii) automatically _instantiates_ experimental JavaScript Applications.
Semantic Dependency Injection brings the Linked Data merits to empirical software engineering,
enabling experimental software setups to be more transparent, flexible, and _unambiguously_ citable.
This enables joint discovery of experimental software and research articles by means of querying.
Furthermore, experiment reporting can be extended with an IRI to the software configuration.
The use of semantic configuration files can also facilitate more advanced static program analysis.

In future work, we aim to make the creation of semantic component files more developer-friendly.
A tool can automatically parse source code
and derive the appropriate semantic description on how components can be instantiated using which parameters.
Additionally, these semantic component definition files provide an interesting platform for validating software dependency relations.
Reasoning could for instance be done on parameter restrictions to check whether
or not different bundle versions will break certain component invocations.
