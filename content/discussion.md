## Discussion
{:#discussion}

- good for static analysis


The core idea of the scientific process is _to stand on the shoulders of giants_.
This means building further upon previous work to derive new work—but
also, enabling others to build upon our work.
Reproducibility, for instance, is an essential aspect of this process.
Not only does this concept apply to Web research as well,
but the Web makes an ideal platform to _improve_ the scientific process as a whole.

A large number of computer science articles describe experimental software evaluations,
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
