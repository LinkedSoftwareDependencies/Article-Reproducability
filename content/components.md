## Describing components and their configuration
{:#describing-components}

In this section, we introduce a vocabulary for describing software components and how they can be instantiated.
We provide an example of the application of this vocabulary to object-oriented software components using JavaScript.

### Object-oriented components

Within the _object-oriented components vocabulary_,
we reuse Fowler's definition of a [software component](cito:providesQuotationFor DependencyInjection) as a "glob" of software.
The purpose of a component is to provide operations that can be used by other components.
The instantiation of a component can require certain parameters,
just like object-oriented programming (OOP) languages allow constructors to have certain arguments.
In this section, we assume OOP in the broad sense of the word, which only requires _classes_, _objects_ and _constructor parameters_.

link to voc
{:.todo}

We define a _module_ as a collection of components.
Within OOP languages, this can correspond to for example a software library or an application,
which can contain a multitude of functionalities, i.e., components.

We define component as a _subclass_ of `rdfs:Class`.
The parameters to construct a component can therefore be defined as an `rdfs:Property` on a component.
This class structure enables convenient semantic descriptions of components instantiations,
requiring only the fundamental concepts of RDF classes and properties.

Figure TODO shows an overview of all the classes and predicates in the components vocabulary.

figure
{:.todo}

Several `oo:Component` subclasses are defined.
An `oo:Component` can be an `oo:Class`, which means that it can be instantiated based on parameters.
All instantiations of `oo:Class` instances are an `oo:Instance`.
It can also be an `oo:Instance`, meaning that it can directly be used within other components and needs no further instantiation.
An `oo:Class` can also be `oo:ClassAbstract`, which does not allow directly instantiating this component type.
Abstract components can be used to define a set of shared parameters in a common ancestor.
Conforming to the RDF semantics, components can have multiple ancestors, and are indicated using the `rdfs:subClassOf` predicate.

The parameters that are used to instantiate an `oo:Class` to an `oo:Instance` are of type `oo:Parameter`.
An `oo:Parameter` is a _subclass_ of `rdfs:Property`, which simplifies its usage as an RDF property.

[](#module-n3) shows an example of the N3.js npm module using the components vocabulary.
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

{:.todo} mention reasoning for checking things like valid parameter range

### Object mapping

A consequence of using RDF to instantiate components is that the parameters have no fixed order.
While this is sufficient to describe component instantiations on a semantic level,
it is insufficient for mapping parameter values to arguments in method and constructor calls that are based on a fixed ordering for parameters,
which is the case for most popular OOP languages.

We introduce a new vocabulary for describing the mapping between the pure semantic parameters
to arguments in method calls in OOP languages like JavaScript, hence the name _object mapping vocabulary_.

link to voc
{:.todo}

Our vocabulary introduces the _object map_ and the _array map_, the latter is a subclass of the former.
An object map can have several _object map entries_, where each entry has a field name and a field value.
An array map can have several _array map entries_, each entry only has a value.

Figure TODO shows an overview of all the classes and predicates in the components vocabulary.

figure
{:.todo}

If the value of `om:fieldName` or `om:fieldValue` is a literal, the literal value will be mapped to the object field name or value.
An `om:fieldValue` can also refer to another object map, which will be mapped to the resulting object.
An object map can be dynamic, where the object field names and values can be mapped dynamically based on predicates.

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
