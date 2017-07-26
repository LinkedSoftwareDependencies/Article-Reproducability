## Ontology
{:#ontology}

To make sure we can fully describe our experiments in RDF,
we need some way to link to the specific software components
that were used when running the experiment.
To this end we converted the entire npm library to RDF.
That library contains over 480,000 JavaScript packages
and is the most relevant JavaScript package manager.
After conversion we publish over 174,000,000 
[triples](https://linkedsoftwaredependencies.org/) through multiple interfaces.

We also created an ontology to describe
how software components can be configured.
Now we can not only describe all the packages used by the software,
but also how the software itself is configured for maximum reproducability.

### Software modules

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
 
Bundles and modules are described in the npm dataset.
For describing components we will use our new ontology

### Node Package Manager (npm)
All npm data is stored in a [CouchDB](http://couchdb.apache.org/)
[instance](https://registry.npmjs.org/) with one entry per bundle.
This corresponds to the metadata, added by the package developer in a [`package.json`](https://docs.npmjs.com/files/package.json) file,
with additional metadata automatically added by the npm publishing process.
To be able to uniquely identify software components and,
more importantly, interlink them,
we converted the JSON metadata provided by the npm registry to RDF,
for which we set up a [server](https://github.com/LinkedSoftwareDependencies/npm-extraction-server){:.mandatory}.

### Describing components and their configuration
The [_Object-Oriented Components ontology_](https://linkedsoftwaredependencies.org/vocabularies/object-oriented)
is an ontology for describing software components and their instantiation in a certain configuration.
Within this ontology,
we reuse Fowler's definition of a [software component](cito:providesQuotationFor DependencyInjection) as a "glob" of software.
The purpose of a component is to provide operations that can be used by other components.
The instantiation of a component can require certain parameters,
just like object-oriented programming (OOP) languages allow constructors to have certain arguments.
We assume OOP in the broad sense of the word, which only requires _classes_, _objects_ and _constructor parameters_.
[](#voc-oo-diagram) shows an overview of the ontology.

<figure id="voc-oo-diagram">
<img src="voc-oo-diagram.svg" alt="[Object-Oriented Components ontology diagram]">
<figcaption markdown="block">
Classes and properties in the [_Object-Oriented Components_ ontology](https://linkedsoftwaredependencies.org/vocabularies/object-oriented#){:.mandatory},
with as prefix `oo`.
</figcaption>
</figure>

We define `oo:Component` as a _subclass_ of `rdfs:Class`.
The parameters to construct a component can therefore be defined as an `rdfs:Property` on a component.
This class structure enables convenient semantic descriptions of components instantiations
through the regular `rdf:type` predicate.
For instance,
a software module representing a parser
can be described as
`ldfs:Datasource:Hdt a oo:Class.`,
and a concrete instance is
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
`oo:defaultValue` allows parameters to have a default value when no other values have been provided.
The `oo:uniqueValue` predicate is a flag that can be set to indicate whether or not the parameter can only have a single value.