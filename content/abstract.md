## Abstract
<!-- Context      -->
Reproducibility is a core characteristic of solid research.
In the domain of computer science engineering,
reproducing experiments involves setting up the exact same software
with the same benchmarks and test data.
<!-- Need         -->
Unfortunately,
many research articles ambiguously refer to software by name only,
leaving out crucial details such as package and dependency version numbers
or the configuration of the individual components—all of which
are necessary to reproduce experiments.
<!-- Task         -->
Therefore,
we designed JSON-LD-based software configurations
which can be published as Linked Data alongside experimental results,
and implemented a dependency injection framework
that can instantiate such experimental setups faithfully.
<!-- Object       -->
This article discusses the approach,
applies it to the npm ecosystem,
and explains how to publish software configurations on the Web.
<!-- Findings     -->
In order to make configurations such fully dereferenceable,
we published the metadata of all 470,000 JavaScript libraries on npm
as 150,000,000 Linked Data triples.
<!-- Conclusion   -->
Through our work,
research articles can precisely refer to experimental setups
using the URL of an instantiatable configuration,
completing the provenance chain from
specifications to implementations, dependencies, and configurations
all the way to experimental results.
This ultimately brings faster and more accurate replications of experiments,
and facilitates the evaluation of new research contributions.
<!-- Perspectives -->
