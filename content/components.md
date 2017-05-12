## Describing components and their configuration
{:#describing-components}

In this section, we introduce the _Object-Oriented Components_ ontology for describing software components and how they can be instantiated.
We provide an example of the application of this vocabulary to object-oriented software components using JavaScript.

{:.todo}
Be mentally prepared for needing to remove these figures. Idea would be to include them in the ontology, and change our ontology application so it also shows images. (That would be nice actually.)

### Object-oriented components

Within the [_Object-Oriented Components ontology_](http://linkedsoftwaredependencies.org/vocabularies/object-oriented),
we reuse Fowler's definition of a [software component](cito:providesQuotationFor DependencyInjection) as a "glob" of software.
The purpose of a component is to provide operations that can be used by other components.
The instantiation of a component can require certain parameters,
just like object-oriented programming (OOP) languages allow constructors to have certain arguments.
In this section, we assume OOP in the broad sense of the word, which only requires _classes_, _objects_ and _constructor parameters_.
[](#voc-oo-diagram) shows an overview of all the classes and predicates in the ontology.

<figure id="voc-oo-diagram">
<img src="voc-oo-diagram.svg" alt="[Object-Oriented Components ontology diagram]">
<figcaption markdown="block">
Overview of the classes and properties in the _object-oriented components_ ontology.
</figcaption>
</figure>

We define a _module_ as a collection of components.
Within OOP languages, this can correspond to for example a software library or an application,
which can contain a multitude of functionalities, i.e., components.

We define component as a _subclass_ of `rdfs:Class`.
The parameters to construct a component can therefore be defined as an `rdfs:Property` on a component.
This class structure enables convenient semantic descriptions of components instantiations,
requiring only the fundamental concepts of RDF classes and properties.

Several `oo:Component` subclasses are defined.
An `oo:Component` can be an `oo:Class`, which means that it can be instantiated based on parameters.
All instantiations of `oo:Class` instances are an `oo:Instance`.
It can also be an `oo:Instance`, meaning that it can directly be used within other components and needs no further instantiation.
An `oo:Class` can also be `oo:AbstractClass`, which does not allow directly instantiating this component type.
Abstract components can be used to define a set of shared parameters in a common ancestor.
Conforming to the RDF semantics, components can have multiple ancestors, and are indicated using the `rdfs:subClassOf` predicate.

The parameters that are used to instantiate an `oo:Class` to an `oo:Instance` are of type `oo:Parameter`.
An `oo:Parameter` is a _subclass_ of `rdfs:Property`, which simplifies its usage as an RDF property.
`oo:defaultValue` allows parameters to have a default value when no other values have been provided.
The `oo:uniqueValue` predicate is a flag that can be set to indicate whether or not the parameter can only have a single value.

[](#module-n3) shows an example of the N3.js npm module using the components ontology.
It exposes several components such as _Parser_ and _Lexer_.
Each of these components can take several different parameters.
[](#config-n3) illustrates how instances can be created of these component types.

<figure id="module-n3" class="listing">
````/code/module-n3.ttl````
<figcaption markdown="block">
The N3.js module contains a parser, lexer and util component.
The parser and lexer are a constructable components.
The parser has a parameter that takes another component, a lexer, as input.
The util component already is an instance, for which it needs no parameters.
</figcaption>
</figure>

<figure id="config-n3" class="listing">
````/code/config-n3.ttl````
<figcaption markdown="block">
`ex:myLexer` is a lexer that accepts comments.
`ex:myParser` is a parser that accepts the TriG format and uses `ex:myLexer` for lexing.
</figcaption>
</figure>

{:.todo}
mention reasoning for checking things like valid parameter range

### Object mapping

A consequence of using RDF to instantiate components is that the parameters have no fixed order.
While this is sufficient to describe component instantiations on a semantic level,
it is insufficient for mapping parameter values to arguments in method and constructor calls that are based on a fixed ordering for parameters,
which is the case for most popular OOP languages.

We introduce a new ontology for describing the mapping between the pure semantic parameters
to arguments in method calls in OOP languages like JavaScript, hence the name [_Object Mapping ontology](http://linkedsoftwaredependencies.org/vocabularies/object-mapping).
[](#voc-om-diagram) shows an overview of all the classes and predicates in the ontology.

<figure id="voc-om-diagram">
<img src="voc-om-diagram.svg" alt="[Object Mapping ontology diagram]">
<figcaption markdown="block">
Overview of the classes and properties in the _Object Mapping_ ontology.
</figcaption>
</figure>

The ontology introduces the _object map_ and the _array map_, the latter is a subclass of the former.
An object map can have several _object map entries_, where each entry has a field name and a field value.
An array map can have several _array map entries_, each entry only has a value.

{:.todo}
Consider dropping all listings in this section, we’ll need to keep the explanation conceptual there. People will need to understand _why_ mappings are needed, understand high-level _what_ they do, but the _how_ might not be possible to explain.

If the value of `om:fieldName` or `om:fieldValue` is a literal, the literal value will be mapped to the object field name or value.
An `om:fieldValue` can also refer to another object map, which will be mapped to the resulting object.
`om:collectsEntriesFrom` can refer to a predicate that points to entities with certain predicates.
Each entity predicate that is refered to by `om:fieldName` will have its values mapped to keys of the object.
Each entity predicate refered to by `om:fieldValue` will have its values mapped to values.
[](#om-collects-module), [](#om-collects-data) and [](#om-collects-result) show an example of this entry collection process.
<figure id="om-collects-module" class="listing">
````/code/collects-module.ttl````
````/code/collects-data.ttl````
````/code/collects-result.txt````
<figcaption markdown="block">
An object mapping for mapping all `foaf:knows` resources to an object
with as key the `foaf:name` and as value the `foaf:mbox`.
</figcaption>
</figure>
<figure id="om-collects-data" class="listing">
````/code/collects-data.ttl````
<figcaption markdown="block">
All the people `:me` knows using the [FOAF vocabulary](http://xmlns.com/foaf/spec/).
</figcaption>
</figure>
<figure id="om-collects-result" class="listing">
````/code/collects-result.txt````
<figcaption markdown="block">
The resulting object when mapping the people `:me` knows from [](#om-collects-data)
using the object mapping from [](#om-collects-module).
</figcaption>
</figure>

[](#module-n3-mapped) shows the mapping of the N3.js component parameters to the constructor implementations.
This description enchances the component definitions from [](#module-n3)
as it provides a lower level (implementation) view on the component constructors.

<figure id="module-n3-mapped" class="listing">
````/code/module-n3-mapped.ttl````
<figcaption markdown="block">
Both the parameters of the parser and lexer component are respectively mapped to an object.
These objects are the single arguments of respectively the parser and lexer constructor.
The field value in this case is always a parameter.
</figcaption>
</figure>
