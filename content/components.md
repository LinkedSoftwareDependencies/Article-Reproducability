## Describing components and their configuration
{:#describing-components}

Ruben T. writes this
{:.todo}

In this section, we introduce a vocabulary for describing software components and how they can be instantiated.
We provide an example of the application of this vocabulary to object-oriented software components using JavaScript.

### Components

Within the components vocabulary, we define a software _component_ as _either a software class that can be instantiated or an instance_.
The purpose of a component is to provide operations that can be used by other components.
In object-oriented programming (OOP), a component could therefore be either an _object_, _object factory_ or the _constructor of a class_.
The instantiation of a component can require certain parameters, just like OOP languages allow constructors to have certain arguments.

link to voc
{:.todo}

A _module_ is a collection of components.
Within OOP languages, this can correspond to a software library or an application,
which can contain a multitude of functionalities, i.e., components.

We define a component as a _subtype_ of `rdfs:Class`.
The parameters of a component can therefore be defined as an `rdfs:Property` on a component.
This simple component structure enables convenient semantic descriptions of components instantiations,
requiring only the fundamental concepts of RDF classes and properties.

Figure TODO shows an overview of all the classes and predicates in the components vocabulary.

figure
{:.todo}

Several component subtypes are defined.
A component can be constructable, which means that it requires some form of instantiation before it can be used elsewhere.
It can also be a direct instance, meaning that it can directly be used within other components and needs no further instantiation.
A component can also be abstract, which does not allow directly instantiating this component type.
Abstract components can be used to define a set of shared parameters in a common ancestor.
Conforming to the RDF semantics, components can have multiple ancestors, and are indicating using the `rdfs:subClassOf` predicate.

Say some things about parameters once the vocabulary on this has been fixed.
{:.todo}

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

### Object-oriented components

A consequence of using RDF to instantiate components is that the parameters have no fixed order.
While this is sufficient to describe component instantiations on a semantic level,
it is insufficient for mapping parameter values to arguments in method and constructor calls that are based on a fixed ordering for parameters,
which is the case for most popular programming languages.

We introduce a new vocabulary for describing the mapping between the pure semantic parameters
to arguments in method calls in OOP languages like JavaScript, hence the name _object mapping vocabulary_.

link to voc
{:.todo}

Our vocabulary introduces the _object map_ and the _array map_, the latter is a subclass of the former.
An object map can have several _object map entries_, where each entry has a field name and a field value.
An array map can have several _array map entries_, each entry only has a value.

Figure TODO shows an overview of all the classes and predicates in the components vocabulary.

If the value of `fieldName` or `fieldValue` is a literal, the literal value will be mapped to the object field name or value.
A `fieldValue` can also refer to another object map, which will be mapped to the resulting object.
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
