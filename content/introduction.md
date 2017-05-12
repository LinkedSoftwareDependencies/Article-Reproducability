## Introduction
{:#introduction}

A large number of computer science articles describe experimental software evaluations,
but many of them refer to that software only by name or version number.
This information is insufficient for readers
to understand which _exact_ version of the software,
which exact versions of its _dependencies_,
and which detailed _configuration_ of the software's components
has obtained the reported results.
Therefore, potential users cannot necessarily obtain the correct software installation
that will behave according to the article's conclusions.
Moreover, other researchers might fail
in reproducing the same results
because of differences in any such aspects.

As [Claerbout's Principle](cite:providesQuotationFor WaveLab) explains,
<q>an article about computational science in a scientific publication
is not the scholarship itself, it is merely **advertising** of the scholarship.
The actual scholarship is the complete software development environment
and the complete set of instructions which generated the figures.</q>
This stresses the importance of reproducibility,
and essentially mandates a detailed description
of the executed experiment,
all of the involved artefacts and actors,
and the processing of the retrieved data.

Using [Linked Data](cite:citesAsAuthority LinkedData)
to publish such descriptions provides two immediate benefits:
the experimental setup and parts thereof can be _identified by IRIs_,
and their details can be retrieved by _dereferencing those IRIs_.
Therefore, if research articles complement their textual explanation of an experiment
with the IRI of the full setup, reproducibility is strongly facilitated.
Moreover, the IRIs of the entire experiment or its parts
can be reused in other articles or experiments
to unambiguously refer to the same conditions.
[](#description-diagram) illustrates how this leads to a chain of provenance
from the research article to the data
and the experiment that generates it,
as well as all aspects surrounding that experiment.

<figure id="description-diagram">
<img src="description-diagram.svg" alt="[description diagram]">
<figcaption markdown="block">
A _research article_ is based on _result data_,
which are the outcomes of an _experiment_.
The experiment in turn also has (multiple) provenance chains,
and this article focuses on _software configurations_ and _software modules_.
</figcaption>
</figure>

In this article,
we focus on the description of _software configurations_ and _software modules_,
such that an evaluated software setup
can be referred to unambiguously by an IRI.
We thereby avoid the inherent vagueness
of referring to software by name or version only.
We further facilitate the reproduction of experiments
through a mechanisms that automatically _instantiates_ the software configuration
based on its Linked Data description.
Our contributions are the following:

- the RDF-based description of **software modules**,
  applied to the 475,000+ bundles of [npm](https://www.npmjs.com/) (Node.js);
- the RDF-based description of **available components** within software modules;
- the RDF-based description of a **precise configuration** of software modules;
- the **automated instantiation** of such a configuration;
- a **use case** explaining the usage of the resulting Linked Data
  in scientific articles.

This article is structured as follows.
In [](#related-work), we discuss related work.
Next, in [](#overview) we present an overview of the required steps for software experimentations that will be discussed in this paper.
[](#describing-modules) introduces the semantic description of software modules.
Next, [](#describing-components) discusses a semantic description of software components,
followed by the introduction of a dependency injection framework that can instantiate these described components in [](#instantiating).
In [](#use-case), we present a use case where we apply software descriptions
to an experimental evaluation.
Finally, we discuss our conclusions and future work in [](#conclusion).
