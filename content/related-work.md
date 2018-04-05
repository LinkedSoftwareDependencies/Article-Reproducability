## Related Work
{:#related-work}

In this section, we discuss existing description methods or ontologies to describe software, 
and position them to the Object-Oriented Components ontology, which is described in the next section.
In addition, we describe other Dependency Injection frameworks, both for JavaScript and other languages,
and discuss their limitations compared to Components.js.

### Semantic Software description

Software can be described on several levels of granularity,
going from a high-level package overview to a low-level description of the actual code.
The [Software Ontology (SWO)](cite:cites malone2014software) and [Description of a Project (DOAP)](cite:cites doap) ontology focus on the high-level management of software development,
enabling the description of tools, resources, contributors and tasks. 
At a slightly lower-level, SWO includes interfaces, algorithms, versions, and the associated provenance data, but does not reach the level of detail to describe operational code.

Ontologies that describe software configuration from a research workflow perspective are [LODFlow](cite:cites Rautenberg:2015:LWM:2814864.2814882), [Workflow-Centric Research Objects](cite:cites Belhajjame2015) with the <cite><a href="https://w3id.org/ro/">Wf4Ever Research Object Model</a></cite> and the [Ontologies for Describing the Context of Scientific Experiment Processes](cite:cites Mayer2014) with the <cite><a href="http://www.timbusproject.net/portal/publications/ontologies/">TIMBUS Context Model</a></cite> to compliment the Research Objects model. 
From a more generic perspective, there exist the [PROV Ontology](cito:citesAsAuthority PROVO), [The OPMW-PROV Ontology](cito:citesAsAuthority OPMWPROV), and the [DDI-RDF Discovery Vocabulary](cito:citesAsAuthority DDIRDF).
However, these efforts can only cover (parts of) the connection between research and software, which is insuffient for Dependency Injection.
Such descriptions are however interpretive in that any given tool is subject to having multiple descriptions by different users.
In contrast to the human-driven descriptions, our work both enables and accelerates the generation of machine-driven Linked Data descriptions of software modules, their components, as well as their configurations to be uniformly created.
Consequently, this makes it possible to accurately describe and instantiate software experiments that can be reused and compared with unambiguously.

Much more low-level and exact is the [Core Software Ontology](cite:cites oberle2009ontology),
which provides a foundational vocabulary that is designed for extensibility.
This includes the distinctive concepts to describe software as code, software as object to computational hardware, and software as a running computational activity,
but also Interfaces, Classes, Methods, the relationships between them, and workflow information on their invocation.
Its extension, the Core Ontology of Software Components (COSC), moves closer to the topic of this article by describing interfaces and protocols of components.
Similar in scope is the [Software Engineering Ontology Network (SEON)](cite:cites ruy2016seon), which consolidates multiple ontologies for the Software Engineering field.
It includes a higher Core and Foundational layer, as well as multiple Domain-specific ontologies.
Of particular interest is their Software Ontology (SwO) that captures the different artifacts in software.


TODO: finish this paragraph












### Dependency Injection frameworks
The main idea behind Dependency Injection is that every software component is independent,
and all other components they depend on should be provided by an external source.
The only thing a single component knows is how these dependencies can be used,
but it has no idea where they came from and how they were created.

There is a large spectrum of Dependency Injection frameworks available,
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
