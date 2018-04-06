## Related Work
{:#related-work}

In this section, we discuss existing description methods or ontologies to describe software, 
and position them to the Object-Oriented Components ontology, which is described in the next section.
In addition, we describe other dependency injection frameworks, both for JavaScript and other languages,
and discuss their limitations compared to Components.js.

### Semantic software description

Software can be described on several levels of granularity,
going from a high-level package overview to a low-level description of the actual code.
The [Software Ontology (SWO)](cite:cites malone2014software) and [Description of a Project (DOAP)](cite:cites doap) ontology focus on the high-level management of software development,
enabling the description of tools, resources, contributors and tasks. 
At a slightly lower level, SWO includes interfaces, algorithms, versions, and the associated provenance data, but does not reach the level of detail to describe operational code.

Ontologies that describe software configuration from a research workflow perspective are [LODFlow](cite:cites Rautenberg:2015:LWM:2814864.2814882), [Workflow-Centric Research Objects](cite:cites Belhajjame2015) with the <cite><a href="https://w3id.org/ro/">Wf4Ever Research Object Model</a></cite> and the [Ontologies for Describing the Context of Scientific Experiment Processes](cite:cites Mayer2014) with the <cite><a href="http://www.timbusproject.net/portal/publications/ontologies/">TIMBUS Context Model</a></cite> to compliment the Research Objects model. 
From a more generic perspective, there exist the [PROV Ontology](cito:citesAsAuthority PROVO), the [OPMW-PROV Ontology](cito:citesAsAuthority OPMWPROV), and the [DDI-RDF Discovery Vocabulary](cito:citesAsAuthority DDIRDF).
However, these efforts can only cover (parts of) the connection between research and software, which is insufficient for dependency injection.
Such descriptions are however interpretive in that any given tool is subject to having multiple descriptions by different users.
In contrast to the human-driven descriptions, our work both enables and accelerates the generation of machine-driven Linked Data descriptions of software modules, their components, as well as their configurations to be uniformly created.
Consequently, this makes it possible to accurately describe and instantiate software experiments that can be reused and compared with unambiguously.

Much more low-level and exact is the [Core Software Ontology (CSO)](cite:cites oberle2009ontology),
which provides a foundational vocabulary that is designed for extensibility.
This includes the distinctive concepts to describe software as code, software as object to computational hardware, and software as a running computational activity,
but also Interfaces, Classes, Methods, the relationships between them, and workflow information on their invocation.
Its extension, the Core Ontology of Software Components (COSC), moves closer to the topic of this article by describing interfaces and protocols of components.
Similar in scope is the [Software Engineering Ontology Network (SEON)](cite:cites ruy2016seon), which consolidates multiple ontologies for the Software Engineering field.
It includes a higher Core and Foundational layer, as well as multiple domain-specific ontologies.
Of particular interest is their Software Ontology (SwO) that captures the different artifacts in software.
In general, both ontologies (or suites) view software from a <q>network of communicating concepts</q> perspective.
This allows for exhaustive descriptions of complex software systems, but is not suited for describing class instances or aspects of modular programming (e.g., package dependencies).

### Dependency injection frameworks
The large spectrum of existing dependency injection frameworks indicates a high demand for such systems.
Dependency injection considers every software component as independent:
a single component is only aware about how these dependencies can be used,
but not about their whereabouts or how they were created.
The absence of internal dependencies simplifies testing separate components,
because their dependencies can be easily mocked.
Also, since there is no internal knowledge on a dependency's origin,
it is much easier to change the actual implementation and how the dependency fulfills the role of its interface.

Dependency injection frameworks facilitate in the creation of objects
and provide them to the classes that require them.
Hence, they provide the means to define how all the dependencies are linked together,
allowing developers to "outsource" the actual linking.
Java likely contains the largest collection of dependency injection frameworks.
Much of this stems from the strict typing,
which makes it difficult to create mock objects when required for testing
if the dependencies are nested in the implementation.

One of the biggest Java frameworks is [Spring](https://spring.io/),
which amongst many things, also provides dependency injection.
That is one of its advantages though:
many projects already use Spring for other reasons,
reducing the jump required to add the dependency injection framework.
It supports two ways to do the injection.
The first one is through an external XML configuration file
which defines all the classes and how they are linked together.
The other one is with annotations in the actual code
that define how the interlinking of classes should work.
Google's [Guice](https://github.com/google/guice) is a more lightweight alternative to Spring;
[Dagger](https://github.com/google/dagger) was created to be even more lightweight than Guice.

In JavaScript, 
dependency injection frameworks tend to be less common because of its flexible nature.
Still, multiple frameworks are available, such as [BottleJS](https://github.com/young-steveo/bottlejs), [Wire](https://github.com/cujojs/wire), and [Electrolyte](https://github.com/jaredhanson/electrolyte), all backed by rather small communities.
One of the biggest ones, [InversifyJS](https://github.com/inversify/InversifyJS),
uses annotations similar to Java frameworks to define possible injections.
Unlike standard JavaScript,
it requires you to define interfaces and types,
thereby allowing it to make use of this extra information to correctly handle the linking.
Like Guice, it also has a bindings file to link classes to interfaces.

Components.js differs from most of the aforementioned frameworks
by having the dependency injection metadata external to the code in RDF files,
both for describing what the classes look like, and how they should be linked together.
This provides the additional semantic benefits mentioned in this paper,
such as identification, dereferencing, and discoverability.
