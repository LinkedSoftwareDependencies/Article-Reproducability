## Describing components and their configuration
Ruben T. writes this
{:.todo}

In this section, we introduce a vocabulary for describing software components and how they can be instantiated.
We provide an example of the application of this vocabulary to object-oriented software components using JavaScript.

### Components vocabulary

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

[Fig. 2](#module-n3) shows an example of the N3.js npm module using the components vocabulary.
It exposes several components such as _Parser_ and _Lexer_.
Each of these components can take several different parameters.
[Fig. 3](#config-n3) illustrates how instances can be created of these component types.

<figure id="module-n3">
<iframe src="code/module-n3.ttl" style="width:100%; height:500px"></iframe>
<figcaption markdown="block">
The N3.js module contains a parser, lexer and util component.
The parser and lexer are a constructable components.
The parser has a parameter that takes another component, a lexer, as input.
The util component already is an instance, for which it needs no parameters.
</figcaption>
</figure>

<figure id="config-n3">
<iframe src="code/config-n3.ttl" style="width:100%; height:120px"></iframe>
<figcaption markdown="block">
`ex:myLexer` is a lexer that accepts comments.
`ex:myParser` is a parser that accepts the TriG format and uses `ex:myLexer` for lexing.
</figcaption>
</figure>

Don't use iframes
{:.todo}

### Object-oriented components

constructor mapping (params have no order, in OOP they do)
{:.todo}

{:.todo} object mapping voc

link to voc
{:.todo}

different types and simplified form for non-semantic devs
{:.todo}