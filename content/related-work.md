## Related Work
{:#related-work}

In this section, we discuss related work on the reproducibility of scientific experiments in scholarly articles,
ontologies for describing these experiments, and dependency injection as a design principle in experimental software.

### Reproducibility of software experiments
In order to better keep track of experiments and minimise information loss at CERN, [Information Management: A Proposal](cite:citesForInformation InformationManagementAProposal), recommends a system (WWW) to address questions like <q>Where is this module used? Who wrote this code? Which systems depend on this device?</q>. We contend that the vision to link information systems in the domain of scientific experiments and scholarly articles is not fully realized on the Web. Identifiable parts of experiments, workflows, as well as the articles which refer to them, still predominantly require human intervention and interpretation, and thereby leaving deterministic reproducibility an open problem on the Web. Our work focuses on improving the state of <q>black box</q> science, in particular to experiments using software from the <cite>node package manager</cite>.

In [four-level provenance](cite:cites Banati2015), authors show that infrastructural, environmental, workflow and data provenance, are needed to achieve reproducibility of scientific workflows.
The information captured at different levels of quality enables different levels of reproducibility or repeatability.
While our work is conceptually grounded on the same levels, we describe our concrete work on globally identifiable and semantic descriptions of software modules and configurations.

With the goal of improving the way dataset-based software evaluations are performed in the Semantic Web,
[LOD Lab](cite:cites LODLab) was introduced.
It offers a service to simplify software evaluation
against a large amount of Linked Datasets.
This was done because (Semantic Web) experiments are typically done using only a few datasets,
since handling them requires significant manual labor.
This service not only makes it easier for researchers to _develop_ experiments,
it also makes it easier for others to _reproduce_ these experiments,
because the manual phase of dataset setup is simplified or even removed.
While reusability of datasets is one aspect of experiment reproducibility,
our work focuses on reusability of software within experiments, and replication of the environment.

### Ontologies and vocabularies for describing experiments
The [PROV Ontology](cito:citesAsAuthority PROVO) is a domain-independent ontology to capture provenance information about entities, activities, and agents involved in producing data. [The OPMW-PROV Ontology](cito:citesAsAuthority OPMWPROV) is an ontology for describing abstract and executable workflows. It extends PROV-O and the [P-PLAN Ontology](cito:citesAsAuthority PPLAN) which is designed to represent scientific processes. The [RDF Data Cube Vocabulary](cito:citesAsAuthority DataCube) enables defining and publishing multi-dimensional data structures and observations.
[DDI-RDF Discovery Vocabulary](cito:citesAsAuthority DDIRDF) is a vocabulary for publishing metadata about research and survey data.

[Workflow-Centric Research Objects](cite:cites Belhajjame2015) realises a suite of ontologies with the <cite><a href="https://w3id.org/ro/">Wf4Ever Research Object Model</a></cite> based on empirical analysis of workflow decay and repair in order to improve scientific workflow preservation requirements. It has the means to aggregate or bundle resources like workflows, provenance of executions, publications and datasets. [Ontologies for Describing the Context of Scientific Experiment Processes](cite:cites Mayer2014) compliments the Research Objects model with the <cite><a href="http://www.timbusproject.net/portal/publications/ontologies/">TIMBUS Context Model</a></cite> by process preservation. Its <q>context can range from immediate and local aspects such as the software and hardware supporting the process, to aspects such as the organisation the process is executed in, the people involved, service providers, and even laws and regulations</q>.

[LODFlow](cite:cites Rautenberg:2015:LWM:2814864.2814882) proposes the <cite><a href="https://github.com/AKSW/ldwpo">Linked Data Workflow Project Ontology</a></cite> to describe and plan workflows, tool configurations, and reporting.
Tool specifications and their configurations in LODFlow workflows are described declaratively by a human user without a prescribed schema.
Such descriptions are however interpretive in that any given tool is subject to having multiple descriptions by different users.
In contrast to the human-driven descriptions, our work both enables and accelerates the generation of machine-driven Linked Data descriptions of software modules, their components, as well as their configurations to be uniformly created.
Consequently, this makes it possible to accurately describe and instantiate software experiments that can be reused and compared with unambiguously.
