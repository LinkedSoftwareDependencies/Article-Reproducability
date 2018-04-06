## A Semantic Dependency Injection framework
{:#semantic-dependency-injection}
This section introduces the dependency injection framework [Components.js](https://github.com/LinkedSoftwareDependencies/Components.js){:.mandatory}.
It can instantiate JavaScript components based on a declarative configuration.
These are semantic by default (i.e., described in RDF using a set of vocabularies), but can also be non-semantic (i.e., using direct references to a JavaScript classes).

In this respect, Components.js distinguishes between three main concepts:

- **Module**: a software package containing zero or more components. This is equivalent to a Node module or NPM package.

- **Component**: a class that can be instantiated by creating a new instance of that type with zero or more parameter values. Parameters are defined by the class and its superclasses.

- **Component Configuration**: a semantic representation of an instantiation of a component into an instance based on parameters.

All concepts are described in the programming language independent [_Object-Oriented Components ontology (OO)_](https://linkedsoftwaredependencies.org/vocabularies/object-oriented) [](cite:citesAsAuthority van2017describing).
In the following, we first explain how to describe modules and components using this ontology.
Then, we introduce an additional _Object Mapping ontology_ to describe parameter order in constructors.
Finally, we explain how component configuration files are created, which describe the application wiring, 
and how the framework can instantiate this file to compose a working application.

### Describing modules and components
{:#describing-components}

The Object-Oriented Components ontology reuses Fowler's definition of a [software component](cito:providesQuotationFor DependencyInjection) as a "glob" of software, which 
provides operations that can be used by other components.
The instantiation of such component requires certain parameters,
analog to constructors arguments in object-oriented programming.
This is interpreted in the broad sense: only _classes_, _objects_ and _constructor parameters_ are considered.
An overview is given in [](#voc-oo-diagram).

<figure id="voc-oo-diagram">
<img src="voc-oo-diagram.svg" alt="[Object-Oriented Components ontology diagram]">
<figcaption markdown="block">
Classes and properties in the [_Object-Oriented Components_ ontology](https://linkedsoftwaredependencies.org/vocabularies/object-oriented#){:.mandatory},
with as prefix `oo`.
</figcaption>
</figure>

[](#module) illustrates the basic definition of a module `MyModule`, which is indicated by the type `oo:Module`.
Note that we added a prefix `ex` to shorten the URIs.
Additional metadata is added with the [Description of a Project (DOAP) vocabulary](https://github.com/ewilderj/doap/wiki), e.g., `doap:name`.

<figure id="module" class="listing">
````/code/module.ttl````
<figcaption markdown="block">
A description of a module `ex:MyModule`.
</figcaption>
</figure>

A module is considered a collection of components.
Within object-oriented languages, this can correspond to for example a software library or an application.
A component is typed as `oo:Component`, which is a _subclass_ of `rdfs:Class`.
The parameters to construct the component can therefore be defined as an `rdfs:Property` on a component.
For instance,
a software module representing a parser
can be described as
`ldfs:Datasource:Hdt a oo:Class.`,
and a concrete instance is
`:myHdtDatasource a ldfs:Datasource:Hdt`.

[](#component) extends `MyModule` with a component `ex:MyModule/MyComponent` by adding a `oo:component` predicate.
The type `oo:Class` is one of the several defined subclasses of `oo:Component`,
which indicates that it is instantiatable based on parameters.
Each component can refer to its path within a module using the `oo:componentPath` predicate,
which can for instance be the package name in npm.
The resulting description can be included in the module
(e.g., as a JSON-LD file),
or can be created and referred to externally.
Afterwards, it can be reused by multiple dependents.

<figure id="component" class="listing">
````/code/component.ttl````
<figcaption markdown="block">
The component `ex:MyModule/MyComponent` is described as part of the module `ex:MyModule`.
</figcaption>
</figure>

The parameters that are used to instantiate an `oo:Class` are of type `oo:Parameter`.
An `oo:Parameter` is a _subclass_ of `rdfs:Property`, which simplifies its usage as an RDF property.
`oo:defaultValue` allows parameters to have a default value when no other values have been provided:
upon instantiation ([](#instantiating)),
a closed world will be assumed.
The `oo:uniqueValue` predicate is a flag that can be set to indicate whether or not the parameter can only have a single value.

[](#module-ldf) shows a simplified example of the Linked Data Fragments (LDF) server npm module.
It exposes several components such as an HDT and SPARQL datasource and a TPF server,
each of which can take multiple parameters.
These are provided with a unique identifier and definition,
such that the software configuration can receive a semantic interpretation.

Although the examples in this article are presented in Turtle syntax, Components.js encourages the use of JSON-LD for compatibility with JSON and the use of shortcuts.
A general context is defined for the Object-Oriented Components ontology, which is available at [https://linkedsoftwaredependencies.org/contexts/components.jsonld](https://linkedsoftwaredependencies.org/contexts/components.jsonld).
The dereferencable URI of your module is defined by `@id`, and `requireName` refers to the package (as defined in npm's package.json file).

<figure id="module-ldf" class="listing">
````/code/module-ldf.ttl````
<figcaption markdown="block">
The LDF server module contains, among others, an HDT and SPARQL-based datasource component, which both extend from the abstract datasource component.
The HDT and SPARQL datasource are a classes, which both inherit the title parameter from the abstract datasource.
The HDT datasource takes an HDT file as parameter.
The SPARQL datasource takes a SPARQL endpoint IRI as parameter.
</figcaption>
</figure>

### Describing object mappings
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

### Describing and instantiating a Component Configuration
{:#instantiating}

Once modules and components are described, 
a component configuration can wire a JavaScript application by declaring specific instances.
An instance of the module from [](#component), with the parameter `ex:MyModule/MyComponent#name` set to <q>John</q>, is given in [](#configuration).
The type of our instance `ex:myInstance` is simply the component that must be instantiated, in this case `ex:MyModule/MyComponent`.
All instantiations of `oo:Class` instances are also of type `oo:Instance`.
The parameters that were defined by the component, can now be used as keys in the configuration file.

<figure id="configuration" class="listing">
````/code/configuration.ttl````
<figcaption markdown="block">
A component configuration file that describes the instantiation of `ex:MyModule/MyComponent` with the parameter  `ex:MyModule/MyComponent#name` set to <q>John</q>
</figcaption>
</figure>

An `oo:Class` can also be an `oo:AbstractClass`, which does not allow directly instantiating this component type.
Abstract components can be used to define a set of shared parameters in a common ancestor.
Conforming to the RDF semantics, components can have multiple ancestors, and are indicated using the `rdfs:subClassOf` predicate.

<figure id="components.js" class="listing">
````/code/components.js````
<figcaption markdown="block">
First, a new component loader is created
after which the component definitions are registered.
Finally, a declarative component instantiation is supplied by providing the component IRI.
</figcaption>
</figure>

The initial steps for using the framework are shown in [](#components.js).
First, it provides a `Loader` class that acts as an assembler.
This `Loader` provides _constructor injection_:
it dynamically calls the constructor of the component and passes the configured parameters in a single object argument.
Then, a module description is registered, which can be retrieved by automatically scanning NPM modules, 
parsing a downloaded RDF document via URL, or reading a raw triple stream.
At the time of writing, the parser accepts RDF documents serialized as either JSON-LD, Turtle, TriG, N-Triples or N-Quads.
In this example, the Linked Data Fragments module description from [](#module-ldf) is registered as [http://example.org/my-ldf-server.ttl]().
Finally,
the `Loader` instantiates one or more components by invoking a component configuration.
[](#config-ldf) depicts the configuration file for a [Linked Data Fragments server](http://linkeddatafragments.org/software/#server) application,
which is identified by [http://example.org/config-ldf.ttl](). 

<figure id="config-ldf" class="listing">
````/code/config-ldf.ttl````
<figcaption markdown="block">
`ex:myServer` is a TPF server which will be loaded with a HDT and SPARQL-based datasource.
</figcaption>
</figure>

Note that, while Linked Data has an open-world assumption, our dependency injector operates in the closed-world environment of OOP.
Hence, we assume that all the necessary constructor arguments are included in the configuration and are available to the loader,
as this is required for features such as default arguments.

As a complete example, the documentation of Components.js has been made self-instantiatable using its own framework and is available at [http://componentsjs.readthedocs.io/en/latest/example/](http://componentsjs.readthedocs.io/en/latest/example/).