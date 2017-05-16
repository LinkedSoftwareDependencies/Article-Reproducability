## Describing components and their configuration
{:#describing-components}

In this section, we introduce the [_Object-Oriented Components ontology_](https://linkedsoftwaredependencies.org/vocabularies/object-oriented)
for describing software components and their instantiation in a certain configuration,
and provide an example of its application to JavaScript.
Within this ontology,
we reuse Fowler's definition of a [software component](cito:providesQuotationFor DependencyInjection) as a "glob" of software.
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

We define component as a _subclass_ of `rdfs:Class`.
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
An `oo:Class` can also be `oo:AbstractClass`, which does not allow directly instantiating this component type.
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

[](#module-ldf) shows a simplified example of the LDF server npm module using the components ontology.
It exposes several components such as an HDT and SPARQL datasource and a QPF server,
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
