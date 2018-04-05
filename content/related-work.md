## Related Work
{:#related-work}

{:todo}
feest

### Semantic Software description

There are several levels of granularity on which software can be described,
going from a high-level package overview to a low-level description of the actual code.
In descriptions, we can use several of these layers,
depending on the context and the requirements.
Drilling down from the top to the bottom, we have the following layers:
 
 - a **bundle** is a container
 with metadata about the software and its functionality
 across different points in time.
 An example is [the *N3.js* library](https://linkedsoftwaredependencies.org/bundles/npm/n3).
 - a **module** or *version* is a concrete software package
 and an implementation of a bundle.
 [*N3.js 0.10.0*](https://linkedsoftwaredependencies.org/bundles/npm/n3/0.10.0) is a module.
 - a **component** is a specific part of a module 
 that can be called in a certain way with a certain set of parameters.
 The [*N3.js 0.10.0 Parser*](https://github.com/RubenVerborgh/N3.js/blob/v0.10.0/lib/N3Parser.js) is a component.


Description of Packages, Modules, and components

- Software ontology
- DOAP
- deps
- Semantic Science Integrated Ontology
- Software Process Control Model
- Software Work Product Model
- IT Service Management Ontology
- Core Software Ontology https://pdfs.semanticscholar.org/ffaf/4135ea2f43cf17fdf3dd6e879349f67a6c88.pdf
- Software Engineering Ontology Network

The [PROV Ontology](cito:citesAsAuthority PROVO) is a domain-independent ontology to capture provenance information about entities, activities, and agents involved in producing data. [The OPMW-PROV Ontology](cito:citesAsAuthority OPMWPROV) is an ontology for describing abstract and executable workflows. It extends PROV-O and the [P-PLAN Ontology](cito:citesAsAuthority PPLAN) which is designed to represent scientific processes. The [RDF Data Cube Vocabulary](cito:citesAsAuthority DataCube) enables defining and publishing multi-dimensional data structures and observations.
[DDI-RDF Discovery Vocabulary](cito:citesAsAuthority DDIRDF) is a vocabulary for publishing metadata about research and survey data.

[Workflow-Centric Research Objects](cite:cites Belhajjame2015) realises a suite of ontologies with the <cite><a href="https://w3id.org/ro/">Wf4Ever Research Object Model</a></cite> based on empirical analysis of workflow decay and repair in order to improve scientific workflow preservation requirements. It has the means to aggregate or bundle resources like workflows, provenance of executions, publications and datasets. [Ontologies for Describing the Context of Scientific Experiment Processes](cite:cites Mayer2014) compliments the Research Objects model with the <cite><a href="http://www.timbusproject.net/portal/publications/ontologies/">TIMBUS Context Model</a></cite> by process preservation. Its <q>context can range from immediate and local aspects such as the software and hardware supporting the process, to aspects such as the organisation the process is executed in, the people involved, service providers, and even laws and regulations</q>.

[LODFlow](cite:cites Rautenberg:2015:LWM:2814864.2814882) proposes the <cite><a href="https://github.com/AKSW/ldwpo">Linked Data Workflow Project Ontology</a></cite> to describe and plan workflows, tool configurations, and reporting.
Tool specifications and their configurations in LODFlow workflows are described declaratively by a human user without a prescribed schema.
Such descriptions are however interpretive in that any given tool is subject to having multiple descriptions by different users.
In contrast to the human-driven descriptions, our work both enables and accelerates the generation of machine-driven Linked Data descriptions of software modules, their components, as well as their configurations to be uniformly created.
Consequently, this makes it possible to accurately describe and instantiate software experiments that can be reused and compared with unambiguously.

### Dependency Injection frameworks
The main idea behind Dependency Injection is that every software component is independent,
and all other components they depend on should be provided by an external source.
The only thing a single component knows is how these dependencies can be used,
but it has no idea where they came from and how they were created.

There is a large spectrium of Dependency Injection frameworks available,
which shows the demand for such systems.
The lack of internal dependencies makes it much easier to test the separate components,
since all the dependencies can easily be mocked.
Since there is also no internal knowledge of where they came from,
it is much easier to change the actual implementation and how the dependency fulfills the role of its interface.

One of the main problems is that something still has to create all these objects
and provide them to the classes that require them.
That is where the Dependency Injection frameworks come in.
These frameworks provide the means to define how all the dependencies are linked together,
allowing developers to "outsource" the actual linking.

{:.todo}
Skipping C++ since there already seems to be a lot of stuff

#### Java frameworks

{:.todo}
Keep links to frameworks in pdf?

Java is probably the language with the largest collection of Dependency Injection frameworks.
Much of this stems from the strict typings Java uses,
which makes it difficult to create mock objects when required for testing
if the dependencies are nested in the implementation.

One of the biggest Java frameworks is [Spring](https://spring.io/).
While it does much more than Dependency Injection,
that is the only part we are going to cover.
That is one of its advantages though:
many projects already use Spring for other reasons,
reducing the jump required to add the Dependency Injection framework.
It supports two ways to do the injection.
The first one is through an external XML configuration file
which defines all the classes and how they are linked together.
The other one is with annotations in the actual code
that define how the interlinking of classes should work.

[Guice](https://github.com/google/guice) was designed by Google
to be a more lightweight alternative to Spring.
The main idea is that it makes use of bindings,
mapping dependencies to corresponding classes that should be filled in for those dependencies.
Besides that it also makes use of annotations

[Dagger](https://github.com/google/dagger) was created to be even more lightweight than Guice.
Originally developed by Square and later forked to Dagger 2.0 by Google.
It focuses more on the actual performance,
making it more interesting for mobile solutions.
Just like the other systems it mainly uses annotations for this.

#### JavaScript frameworks

{:.todo}
There actually seem to be a lot of frameworks: inversifyJS, bottlejs, wire, electrolyte etc.
Wire actually seems outdated.

Due to the flexible nature of JavaScript,
Dependency Injection frameworks tend to be less common than in Java,
but there still are multiple available.
One of the biggest ones is InversifyJS.
Similarly to the Java libraries,
it makes use of annotations to define the possible injections.
Unlike standard JavaScript,
it requires you to define interfaces and types,
thereby allowing it to make use of this extra information to correctly handle the linking.
For this it makes use of TypeScript.
Additionally, just like Guice it also has a bindings file to link classes to interfaces.
