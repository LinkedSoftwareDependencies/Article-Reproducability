## Abstract
<!-- Context      -->
Reproducibility of research results is one of the main requirements for conducting a qualitative peer-reviewed research process.
Unfortunately, reproducing these results can be cumbersome because a variety of reasons:
setting up the experiments can require non-trivial manual work;
not all required experiment elements are available
or the described experiment may not work as described.
<!-- Need         -->
In order to improve the quality of research in general,
reproducibility of experimental results needs to be improved.
<!-- Task         -->
For this, we introduce vocabularies to describe software components and their configuration.
Secondly, we introduce a system that can instantiate software components based on these descriptions.
<!-- Object       -->
In this paper, we describe these software component vocabularies,
how they can be instantiated,
and we apply it to the use case of the Linked Data Fragments server and its experimental results.
<!-- Findings     -->
In order to make our configurations fully dereferenceable,
we published the metadata of all 470,000+ JavaScript libraries on npm
as more than 150,000,000 Linked Data triples.
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

