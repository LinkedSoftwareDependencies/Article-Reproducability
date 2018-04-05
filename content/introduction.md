## Introduction
{:#introduction}

Among the broad range of research fields conveyed by the Semantic Web domain, 
[Empirical Software Engineering](cite:citesAsAuthority shull2007guide,futureEmpirical) is undeniably prominent.
This field attempts to relieve tension between the curiosity driven _science_ and the utility driven _engineering_,
by concerning itself with [<q>empirical observation of software engineering artifacts and the empirical validation of software engineering theories
and assumptions</q>](cite:citesAsAuthority monperrus2015introduction).
Evidently,
this includes developing software in a way that improves _reporting_, i.e., supporting a systematic, standardized presentation of empirical research in publications [](cite:citesAsAuthority jedlitschka2008reporting); 
and conducting _controlled experiments_, i.e., testing hypotheses where one or more independent variables (treatment) are manipulated to measure their effect on one or more dependent variables (e.g., execution time, resource consumption, etc.) [](cite:citesAsAuthority easterbrook2008selecting).
Experimental software therefore preferably supports the [exact replication of experimental procedures](cite:citesAsAuthority shull2008role), 
which can be _dependent_---all the conditions of the experiment remain the same (or very similar),
or _independent_---one or more major aspects of the conditions of the experiment are deliberately varied.

Rather than obscuring them in monolithic, non transparent software, which is often reported in an ambiguous way by only name or version number,
different algorithms, or implementations thereof, need to be easily swappable in a transparent manner.
The latter is embodied by the [Dependency Injection](cite:cites DependencyInjection) principle (e.g., implemented by the [Spring](https://projects.spring.io/spring-framework/) framework).
where instead of custom code, a generic framework---the _assembler_---determines the flow of control and calls upon individual _software components_ when needed.
Such components are
<q>globs of software that are intended to be used, without change, by an application that is out of the control of the writers of the component</q> [](cite:providesQuotationFor DependencyInjection),
and can be defined and injected independently.
An external configuration (e.g., described in XML) specifies the wiring of these components during the _configuration phase_, 
which is used by the assembler to perform the actual instantiation during the _injection phase_.
With the Semantic Web in mind, however,
these configurations could move beyond their local scope,
and also improve in reporting to help finding the right experiment, understanding how it is conducted, and assess the validity of its results [](cite:citesAsAuthority jedlitschka2008reporting).

To this extent, 
we present _Components.js_, 
a Semantic Dependency Injection framework for JavaScript applications that makes software configuration _addressable_ and _discoverable_, hence surpassing existing Dependency Injection frameworks.
The framework is open-source, available on [npm](https://www.npmjs.com/package/lsd-components), and its complete documentation can be found at [https://componentsjs.readthedocs.io](https://componentsjs.readthedocs.io).
Software configurations and modules are described as Linked Data using the [_Object-Oriented Components ontology_](cite:citesAsAuthority van2017describing) and the introduced _Object Mapping ontology_.
By publishing such descriptions,
the composition of experimental software, and parts thereof, can be _unambiguously identified_ by IRIs and 
retrieved with _dereferencing_.
Components.js automatically _instantiates_ such software configuration, including resolving the necessary dependencies, 
and is fully compatible with the modular programming approach.
In total, this entails the following benefits:

- Extended reporting of experiments in research articles with an IRI (i.e., to facilitate recreating the same conditions);
- Improved transparency and replication of experimental software. Components and configurations can be analyzed in detail, easily replaced, and independently tested;
- Facilitation of static program analysis through the use of external, semantic configuration files;
- A joined data space of research articles and experimental software, enabling discoverable and queryable links between research effort and, for instance, applied algorithms or implementations.

Finally, we include a proof of concept based on the Node.js package manager [npm](https://www.npmjs.com/).
An RDF-based description was generated for 480,000+ packages. Thereby, 
we demonstrate 
(i) the description of an existing application and its available components (available as modules);
(ii) the automated instantiation of such a configuration; and
(iii) the discoverability with a set of insightful queries.
Note that, although this is a JavaScript implementation, the principles are generalizable, 
can be implemented in other languages, or can improve cross-language replication of software.

The remainder article is structured as follows.
First, we discuss the semantic description of software and other Dependency Injection frameworks
in [](#related-work).
Then, [](#semantic-dependency-injection) introduces Components.js and shows how RDF-based software configurations can be instantiated directly from the Web.
Next, 
[](#proof-of-concept) describes the Proof of Concept and its generality is discussed in [](#discussion).
Finally, we discuss our conclusions and future work in [](#conclusion).
