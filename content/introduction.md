## Introduction
{:#introduction}

Among the many fields conveyed by the Semantic Web domain, 
[empirical software engineering](cite:citesAsAuthority shull2007guide,futureEmpirical) is undeniably prominent.
Here, research concerns itself with [<q>empirical observation of software engineering artifacts and the empirical validation of software engineering theories
and assumptions</q>](cite:citesAsAuthority monperrus2015introduction),
thus relieving tension between the curiosity-driven _science_ and the utility-driven _engineering_.
Evidently,
this includes developing software in a way that improves _reporting_, i.e., supporting a systematic, standardized presentation of empirical research in publications [](cite:citesAsAuthority jedlitschka2008reporting),
and conducting _controlled experiments_, i.e., testing hypotheses where one or more independent variables (treatment) are manipulated to measure their effect on one or more dependent variables (e.g., execution time, etc.) [](cite:citesAsAuthority easterbrook2008selecting).
Experimental software therefore preferably supports the [exact replication of experimental procedures](cite:citesAsAuthority shull2008role), 
which keep the conditions of the experiment _dependent_ (all remain the same or very similar),
or _independent_ (one or more major aspects are deliberately varied).

Rather than obscuring experimental software in monolithic, non-transparent packages—often referred to in an ambiguous way by only name or version number—different algorithms and implementations thereof need to be easily swappable in a transparent manner.
The latter is embodied by the [Dependency Injection](cite:cites DependencyInjection) pattern,
where instead of custom code, a generic framework---the _assembler_---determines the flow of control and calls upon individual _software components_ when needed.
Such components are
<q>globs of software that are intended to be used, without change, by an application that is out of the control of the writers of the component</q> [](cite:providesQuotationFor DependencyInjection),
and can be defined and injected independently.
An external configuration document specifies the wiring of these components during the _configuration phase_, 
which is used by the assembler to perform the actual instantiation during the _injection phase_.
With the Semantic Web in mind,
these configurations could move beyond their local scope,
and also improve in reporting to help finding the right experiment, understanding how it is conducted, and assess the validity of its results [](cite:citesAsAuthority jedlitschka2008reporting).

To this end, 
we present _Components.js_, 
a semantic dependency Injection framework for JavaScript applications that makes software configuration _addressable_ and _discoverable_, hence surpassing existing dependency injection frameworks.
The framework is [open-source](https://github.com/LinkedSoftwareDependencies/Components.js){:.mandatory},
available on [npm](https://www.npmjs.com/package/componentsjs){:.mandatory},
and its complete documentation can be found at [https://componentsjs.readthedocs.io/](https://componentsjs.readthedocs.io/){:.mandatory}
(canonical citation: [https://doi.org/10.5281/zenodo.1243988](https://doi.org/10.5281/zenodo.1243988)).
Software configurations and modules are described as Linked Data using
the [_Object-Oriented Components vocabulary_](cite:citesAsAuthority van2017describing)
(canonical citation: [https://doi.org/10.5281/zenodo.1245660](https://doi.org/10.5281/zenodo.1245660))
and the introduced [_Object Mapping vocabulary_](cite:citesAsAuthority van2017describing)
(canonical citation: [https://doi.org/10.5281/zenodo.1245658](https://doi.org/10.5281/zenodo.1245658)).
By publishing such descriptions,
the composition of experimental software (and parts thereof) can be _unambiguously identified_ by IRIs and 
retrieved through _dereferencing_.
Components.js automatically _instantiates_ such software configurations, including resolving the necessary dependencies, 
and is fully compatible with the modular programming approach.
In total, this entails the following benefits:
(i) extended reporting of experiments in research articles by IRI;
(ii) improved transparency and replication of experimental software;
(iii) facilitation of static program analysis through the use of external, semantic configuration files;
(iv) a joint data space of research articles and experimental software, enabling discoverable and queryable links between research and implementations.

Finally, we include a proof of-concept based on the Node.js package manager [npm](https://www.npmjs.com/).
An RDF-based description was generated for 700,000+ packages. Thereby, 
we demonstrate the description of an existing application and its available components (available as modules),
the automated instantiation of such a configuration, and the discoverability with a set of insightful queries.
Note that, although this is a JavaScript implementation, the principles are generalizable, 
can be implemented in other languages, or can improve cross-language replication of software.
