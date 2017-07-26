## Introduction
{:#introduction}

A large number of computer science articles describe experimental software evaluations,
but many of them refer to that software only by name or version number.
This information is insufficient for readers
to understand which _exact_ version of the software,
which versions of its _dependencies_,
and which detailed _configuration_ of the software's components
has obtained the reported results.
Therefore, potential users do not necessarily obtain the correct software installation
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
and essentially mandates a detailed description
of the executed experiment,
all of the involved artefacts and actors,
and the processing of the retrieved data.

Using [Linked Data](cite:citesAsAuthority LinkedData)
to publish experiment descriptions provides two immediate benefits:
the experimental setup and parts thereof can be _identified by IRIs_,
and their details can be retrieved by _dereferencing those IRIs_.
Therefore, if research articles complement their textual explanation of an experiment
with the IRI of the full setup, reproducibility is strongly facilitated.
Moreover, the IRIs of the entire experiment or its parts
can be reused in other articles or experiments
to unambiguously refer to the same conditions.

In this article,
we focus on the description of _software configurations_ and _software modules_,
such that an evaluated software setup
can be referred to unambiguously by an IRI.
We further facilitate the reproduction of experiments
through a mechanism that automatically _instantiates_ the software configuration
based on its Linked Data description.

This article is structured as follows.
In [](#related-work), we discuss related work.
[](#ontology) introduces the semantic description of software modules
and discusses a semantic description of software components and configurations.
[](#use-case), describes a use case where we apply software descriptions
to an experimental evaluation.
Finally, we discuss our conclusions and future work in [](#conclusion).
