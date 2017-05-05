## Abstract
<!-- Context      -->
The scientific process requires reproducible experiments and findings
to foster trust and accountability.
Within computer science engineering,
reproducing experiments involves setting up
the exact same software with the same benchmarks and test data,
which often requires non-trivial manual work.
<!-- Need         -->
Unfortunately,
many research articles ambiguously refer to software by name only,
leaving out crucial details such as module and dependency version numbers
or the configuration of the individual components.
<!-- Task         -->
To this end, we created vocabularies
for the semantic description of software components and their configuration,
which can be published as Linked Data alongside experimental results.
We implemented a dependency injection framework
to accurately instantiate these described experimental configurations.
<!-- Object       -->
This article discusses the approach and its application,
and explains with a use case
how to publish experiments and their software configurations on the Web.
<!-- Findings     -->
In order to enable semantic interlinking between configurations and modules,
we published the metadata of all 475,000+ JavaScript libraries on npm
as 150,000,000+ RDF triples.
<!-- Conclusion   -->
Through our work,
research articles can refer by URL
to fine-grained, instantiatable descriptions of experimental setups,
completing the provenance chain from
specifications to implementations, dependencies, and configurations
all the way to experimental results.
This ultimately brings faster and more accurate reproductions of experiments,
and facilitates the evaluation of new research contributions.
<!-- Perspectives -->
Moreover, this work can serve other use cases,
such as general software instantiation outside of experiments,
and query execution over software configuration metadata.
