## Related Work
{:#related-work}

In this section, we discuss related work on the reproducibility of scientific experiments in scholarly articles,
ontologies for describing these experiments, and dependency injection as a design principle in experimental software.

### Reproducibility of software experiments
In order to better keep track of experiments and minimise information loss at CERN, [Information Management: A Proposal](cite:citesForInformation InformationManagementAProposal), recommends a system (WWW) to address questions like <q>Where is this module used? Who wrote this code? Which systems depend on this device?</q>.

In [four-level provenance](cite:cites Banati2015), authors show that infrastructural, environmental, workflow and data provenance, are needed to achieve reproducibility of scientific workflows.
The information captured at different levels of quality enables different levels of reproducibility or repeatability.

With the goal of improving the way dataset-based software evaluations are performed in the Semantic Web,
[LOD Lab](cite:cites LODLab) was introduced.
It offers a service to simplify software evaluation
against a large amount of Linked Datasets.
This was done because (Semantic Web) experiments are typically done using only a few datasets,
since handling them requires significant manual labor.

### Ontologies and vocabularies for describing experiments
The [PROV Ontology](cito:citesAsAuthority PROVO) is a domain-independent ontology to capture provenance information about entities, activities, and agents involved in producing data. [The OPMW-PROV Ontology](cito:citesAsAuthority OPMWPROV) is an ontology for describing abstract and executable workflows. It extends PROV-O and the [P-PLAN Ontology](cito:citesAsAuthority PPLAN) which is designed to represent scientific processes. The [RDF Data Cube Vocabulary](cito:citesAsAuthority DataCube) enables defining and publishing multi-dimensional data structures and observations.
[DDI-RDF Discovery Vocabulary](cito:citesAsAuthority DDIRDF) is a vocabulary for publishing metadata about research and survey data.

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
[Dependency Injection](cite:cites DependencyInjection) is a form of Inversion of Control where components
are injected into other components by an _assembler_.
Experimental software benefits from this paradigm,
because it allows different components to be defined and injected independently.
