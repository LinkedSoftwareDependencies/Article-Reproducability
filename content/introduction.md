## Introduction
Too many computer science articles
that contain experimental software evaluations
identify that software only by name and, sometimes, version number.
This information is insufficient for readers
to understand which _exact_ version of the software,
which exact versions of its _dependencies_,
and which detailed _configuration_ of the software's components
has in fact obtained the reported results.
Therefore, potential users cannot necessarily obtain the correct software installation
that will behave according to the article's conclusions.
Moreover, other researchers might fail
in reproducing the same results
because of differences in any of these aspects.

As [Claerbout's Principle](cite:providesQuotationFor WaveLab) explains,
<q>an article about computational science in a scientific publication
is not the scholarship itself, it is merely **advertising** of the scholarship.
The actual scholarship is the complete software development environment
and the complete set of instructions which generated the figures.</q>
This stresses the importance of reproducibility,
and essentially mandates a detailed description
of the executed experiment, the involved artefacts and actors,
and the processing of the retrieved data.

Using Linked Data to publish such descriptions provides two immediate benefits:
the experimental setup and parts thereof can be _identified with IRIs_,
and their details can be retrieved by _dereferencing those IRIs_.
Therefore, if research articles complement their textual explanation of an experiment
with the IRI of the full setup, reproducibility is guaranteed.
Moreover, the IRIs of the entire experiment or its parts
can be reused in other articles or experiment
to unambiguously refer to the same conditions.
[Fig. 1](#description-diagram) illustrates how this leads to a chain of provenance
from the research article to the data
and the experiment that generates it,
and all the aspects surrounding that experiment.

Explain that we will focus on describing software configurations
used for an experiment.
{:.todo}



<figure id="description-diagram">
<img src="description-diagram.svg" alt="[description diagram]">
<figcaption markdown="block">
A _research article_ is based on _result data_,
which are the outcomes of an _experiment_.
The experiment in turn also has (multiple) provenance chains,
and this article focuses on _software configurations_ and _software modules_.
</figcaption>
</figure>
