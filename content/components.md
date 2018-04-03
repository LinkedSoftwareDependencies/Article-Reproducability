## Instantiating component configurations
{:#instantiating}

In the previous section, we introduced a vocabulary for describing software components and their instantiation.
In this section, we introduce a dependency injection framework based on these component descriptions.
With this, we take semantic software component descriptions to the next level,
we don't only _describe_ components, but also allow them to be _instantiated_.

### Describing components and their configuration
{:#describing-components}

The [_Object-Oriented Components ontology_](cite:van2017describing,https://linkedsoftwaredependencies.org/vocabularies/object-oriented)
describes software components and their instantiation in a certain configuration,
and provide an example of its application to JavaScript.
This ontology reuses Fowler's definition of a [software component](cito:providesQuotationFor DependencyInjection) as a "glob" of software.
The purpose of a component is to provide operations that can be used by other components.
The instantiation of a component can require certain parameters,
just like object-oriented programming (OOP) languages allow constructors to have certain arguments.
In this section, we assume OOP in the broad sense of the word, which only requires _classes_, _objects_ and _constructor parameters_.
[](#voc-oo-diagram) shows an overview of the ontology.

<figure id="voc-oo-diagram">
<img src="voc-oo-diagram.svg" alt="[Object-Oriented Components ontology diagram]">
<figcaption markdown="block">
Classes and properties in the [_Object-Oriented Components_ ontology](https://linkedsoftwaredependencies.org/vocabularies/object-oriented#){:.mandatory},
with as prefix `oo`.
</figcaption>
</figure>

Following [](#describing-modules), we have defined a _module_ as a collection of components.
Within OOP languages, this can correspond to for example a software library or an application,
which can contain a multitude of components.

We define `oo:Component` as a _subclass_ of `rdfs:Class`.
The parameters to construct a component can therefore be defined as an `rdfs:Property` on a component.
This class structure enables convenient semantic descriptions of components instantiations
through the regular `rdf:type` predicate.
For instance,
a software module representing a parser
can be described as
`ldfs:Datasource:Hdt a oo:Class.`,
and a concrete instance is
`:myHdtDatasource a ldfs:Datasource:Hdt`.


Several `oo:Component` subclasses are defined.
An `oo:Component` can be an `oo:Class`, which means that it can be instantiated based on parameters.
Each component can refer to its path within a module using the `oo:componentPath` predicate,
which can for instance be the package name in Java.
All instantiations of `oo:Class` instances are an `oo:Instance`.
An `oo:Class` can also be an `oo:AbstractClass`, which does not allow directly instantiating this component type.
Abstract components can be used to define a set of shared parameters in a common ancestor.
Conforming to the RDF semantics, components can have multiple ancestors, and are indicated using the `rdfs:subClassOf` predicate.

The parameters that are used to instantiate an `oo:Class` to an `oo:Instance` are of type `oo:Parameter`.
An `oo:Parameter` is a _subclass_ of `rdfs:Property`, which simplifies its usage as an RDF property.
`oo:defaultValue` allows parameters to have a default value when no other values have been provided:
upon instantiation ([](#instantiating)),
a closed world will be assumed.
The `oo:uniqueValue` predicate is a flag that can be set to indicate whether or not the parameter can only have a single value.

The resulting description can be included in the module
(for instance, as a JSON-LD file),
or can be created and referred to externally.
Afterwards, it can be reused by multiple dependents.

[](#module-ldf) shows a simplified example of the Linked Data Fragments (LDF) server npm module using the components ontology.
It exposes several components such as an HDT and SPARQL datasource and a TPF server,
each of which can take multiple parameters.
These are provided with a unique identifier and definition,
such that the software configuration can receive a semantic interpretation.
For example,
[](#config-ldf) illustrates how instances of these component types can be declared.

<figure id="module-ldf" class="listing">
````/code/module-ldf.ttl````
<figcaption markdown="block">
The LDF server module contains, among others, an HDT and SPARQL-based datasource component, which both extend from the abstract datasource component.
The HDT and SPARQL datasource are a classes, which both inherit the title parameter from the abstract datasource.
The HDT datasource takes an HDT file as parameter.
The SPARQL datasource takes a SPARQL endpoint IRI as parameter.
</figcaption>
</figure>

<figure id="config-ldf" class="listing">
````/code/config-ldf.ttl````
<figcaption markdown="block">
`ex:myServer` is a TPF server which will be loaded with a HDT and SPARQL-based datasource.
</figcaption>
</figure>


### Components.js dependency injection framework
We have implemented [Components.js](https://github.com/LinkedSoftwareDependencies/Components.js){:.mandatory},
an open-source dependency injection framework for JavaScript, and made it available on [npm](https://www.npmjs.com/package/lsd-components).
It is able to construct component instances based on declarative component constructions in RDF using the vocabulary introduced in [](#describing-components).
It accepts raw triple streams or URLs to RDF documents containing these declarations.
At the time of writing, the parser accepts RDF documents serialized as either JSON-LD, Turtle, TriG, N-Triples or N-Quads.

[](#components.js) illustrates how components can be instantiated using Components.js.
It provides a `Loader` class that acts as an assembler.
This `Loader` provides _constructor injection_:
it dynamically calls the constructor of the component and passes the configured parameters in a single object argument.
Additionally, [simplified mechanisms](https://github.com/LinkedSoftwareDependencies/Components.js#configuring-a-component-unnamed)
are in place for developers that want to use the dependency injector directly without having to semantically describe the component.

<figure id="components.js" class="listing">
````/code/components.js````
<figcaption markdown="block">
First, a new component loader is created
after which the component definitions are registered.
Finally, a declarative component instantiation is supplied by providing the component IRI.
</figcaption>
</figure>

While Linked Data is based on the open-world assumption, our dependency injector will close the world when we enter the realm of OOP.
This is because a closed-world assumption is required for features such as default arguments:
we have to assume that all the arguments that are available to the loader is everything there is.

### Defining object mappings
The constructor injection described above works out of the box
with single-argument constructors that accept a map,
as is quite common in JavaScript.
Components.js then creates a map with key/value pairs
with the property IRIs and corresponding objects
of all triples with the instance as subject.
This map is then passed to the constructor,
which reads its settings from the map.
Depending on a flag,
the keys and values are either full IRIs
or abbreviated JSON-LD strings.

New libraries that use Components.js
can be designed for such single-parameter constructors.
For all other types constructors,
a mapping mechanism is needed
between the RDF properties
and the concrete parameter order of the constructor.
To this end, we introduce the [_Object Mapping ontology_](https://linkedsoftwaredependencies.org/vocabularies/object-mapping).
[](#voc-om-diagram) shows an overview of all its classes and predicates.

<figure id="voc-om-diagram">
<img src="voc-om-diagram.svg" alt="[Object Mapping ontology diagram]">
<figcaption markdown="block">
Overview of the classes and properties in the _Object Mapping_ ontology, with as prefix [`om`](https://linkedsoftwaredependencies.org/vocabularies/object-mapping#){:.mandatory}.
</figcaption>
</figure>

The ontology introduces the _object mapping_ and the _array mapping_.
An object map can have several _object mapping entries_, where each entry has a field name and a field value.
An array map can have several _array mapping entries_, where each entry only has a value.
Together, they can express all ways
in which the flat object from the RDF description
maps to an ordered list of simple or complex constructor parameters.

[](#module-ldf-mapped) shows the mapping of the LDF component parameters to the constructor implementation.
This description complements the component definitions from [](#module-ldf)
as it provides an implementation view on the component constructors.
Like the component definitions,
a mapping is only necessary once per module
and can be reused across dependents.

<figure id="module-ldf-mapped" class="listing">
````/code/module-ldf-mapped.ttl````
<figcaption markdown="block">
The HDT and SPARQL-based datasource constructors both take a custom object as argument for the constructor.
The entries of this object are mapped from the parameter values using this mapping.
The TPF server constructor similarly requires a custom object,
where the `datasources` entry points to an object that is a mapping from titles to datasources.
</figcaption>
</figure>
