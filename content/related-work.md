## Related Work
{:#related-work}

In this section, we discuss the related work on the reproducibility of scientific experiments in scholarly articles,
ontologies for describing these experiments, and dependency injection as a design principle in experimental software.

### Scholarly publishing and reproducibility
In order to better keep track of experiments and minimise information loss at CERN, [Information Management: A Proposal](cite:citesForInformation InformationManagementAProposal), recommends a system (WWW) to address questions like <q>Where is this module used? Who wrote this code? Which systems depend on this device?</q>. We contend that the vision to link information systems in the domain of scientific experiments and scholarly articles is not fully realised on the Web. Identifiable parts of experiments, workflows, as well as the articles which refer to them, still predominantly require human intervention and interpretation, and thereby leaving deterministic reproducibility an open problem on the Web. Our work focuses on improving the state of <q>black box</q> science in particular to experiments using software from the <cite>node package manager</cite>.

With the goal of improving the way dataset-based software evaluations are performed in the Semantic Web,
[LOD Lab](cite:cites LODLab) was introduced.
They introduced a service to simplify software evaluation
against [a large amount of Linked Datasets](cite:cites LODLaundromat).
This was done because (Semantic Web) experiments are typically done using only a few datasets.
This is because handling Linked Datasets can require a lot of manual labour
because they are mostly disseminated as datadumps,
which can introduce problems such as syntax errors and the harmonization of various formats.
This service not only makes it easier for researchers to _develop_ experiments,
it also makes it easier for others to _reproduce_ these experiments,
because the manual phase of dataset setup is simplified or even removed.
While reusability of datasets is one aspect of experiment reproducibility,
our work focuses on reusability of software within experiments, and replication of the environment.

### Ontologies and vocabularies for describing experiments
[LODFlow](cite:cites Rautenberg:2015:LWM:2814864.2814882) proposes the <cite><a href="https://github.com/AKSW/ldwpo">Linked Data Workflow Project Ontology</a></cite> to describe and plan workflows, tool configurations, and reporting.
Tool specifications and their configurations in LODFlow workflows are described declaratively by a human user without a prescribed schema.
Such descriptions are however interpretive in that any given tool is subject to having multiple descriptions by different users.
In contrast to the human-driven descriptions, our work both enables and accelerates the generation of machine-driven Linked Data descriptions of software modules, their components, as well as their configurations to be uniformly created.
Consequently, this makes it possible to accurately describe and instantiate software experiments that can be reused and compared with unambiguously.

### Dependency injection
{:#related-work-dependency-injection}

[_Separation of concerns_](cite:cites SeparationOfConcerns) is a software design principle in which software is
split into separate components, each having their own separate task.
Fowler defines a [software component](cite:providesQuotationFor DependencyInjection) as
<q>a glob of software that's intended to be used, without change, by an application that is out of the control of the writers of the component</q>.
This design principle is especially useful for experimental software,
because it improves the flexibility to, for instance,
compare different implementations of an algorithm
by plugging them into a larger piece of software.

Programmers traditionally interact with a library of components
by calling its functionality from within their own code.
In that case, the developed software module defines the flow of control.
In contrast, with [_Inversion of Control_](cite:cites InversionOfControl,DesigningReusableClasses),
an external component framework defines this flow:
programmers write code such that it can be called by the framework.
This concept is also known as the [_Hollywood Principle_](cite:cites HollywoodPrinciple):
<q>Don't call us, we'll call you</q>.
[Dependency Injection](cite:cites DependencyInjection) is a form of Inversion of Control where components
are injected into other components by an _Assembler_.
Experimental software benefits from this paradigm,
because it allows different components to be defined and injected independently.

Dependency injection requires a _configuration phase_
to describe how components need to be wired together,
and an _injection phase_ to perform the actual instantiation.
Frameworks such as [Spring](https://projects.spring.io/spring-framework/)
facilitate configuration by specifying it declaratively in a configuration file.
That way, a specific software configuration can be instantiated
by merely describing it in XML or JSON.
These configuration files, however,
can not always be reused outside the scope of a particular project.
Furthermore, different mechanisms are used
to capture additional information needed for the instantiation,
such as module dependencies and their version numbers.
There is no interoperability between these configuration files,
and they cannot easily be combined into a detailed description
of the exact software used.

To that end, we introduce RDF-based software dependency configurations
([](#describing-components))
that exactly capture the used modules and dependencies
([](#describing-modules)).
The resulting description can then be published on the Web as Linked Data,
for instance, as part of the description of an experimental evaluation
([](#overview)).
Furthermore, we implemented a framework
that can instantiate such software descriptions
directly from the Web
([](#instantiating)).
