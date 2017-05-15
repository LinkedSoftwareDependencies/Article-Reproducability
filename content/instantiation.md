## Instantiating component configurations
{:#instantiating}

In the previous section, we introduced vocabularies for describing software components and how they can be instantiated.
In this section, we introduce a dependency injection framework based on these component descriptions.
With this, we take semantic software component descriptions to the next level,
we don't only _describe_ components, but also allow them to be _instantiated_.

### Components.js dependency injection framework
We have implemented [Components.js](https://github.com/LinkedSoftwareDependencies/Components.js){:.mandatory},
an open-source dependency injection framework for JavaScript, and made it available on [npm](https://www.npmjs.com/package/lsd-components).
It is able to construct component instances based on declarative component constructions in RDF using the vocabulary introduced in [](#describing-components).
It accepts raw triple streams or URL's to RDF documents containing these declarations.
At the time of writing, the parser accepts RDF documents serialized in either JSON-LD, Turtle, TriG, N-Triples or N-Quads.

[](#components.js) illustrates how components can be instantiated using Components.js.
It provides a `Loader` class that acts as an assembler when instantiated.
This `Loader` provides _constructor injection_:
it dynamically calls the constructor of the component and passes the configured parameters in a single object argument.
If a constructor mapping is detected, the parameter values will be mapped to constructor arguments as configured by the mapping.
Additionally, [simplified mechanisms](https://github.com/LinkedSoftwareDependencies/Components.js#configuring-a-component-unnamed)
are in place for developers that want to use the dependency injector directly without having to semantically describe the component.

<figure id="components.js" class="listing">
````/code/components.js````
<figcaption markdown="block">
First, a new component loader is created
after which module and component definitions are registered.
Finally, a declarative component instantiation is supplied by providing the component URI
and the location at which the resource can be found.
</figcaption>
</figure>

While Linked Data is based on the open-world assumption, our dependency injector will _close the world_ when we enter the realm of OOP.
This is because a close-world assumption is required when instantiating a component with certain arguments.
We have to assume that all the arguments that are available to the loader is everything there is.

### Defining object mappings
A consequence of using RDF to instantiate components is that the parameters have no fixed order.
While this is sufficient to describe component instantiations on a semantic level,
it is insufficient for mapping parameter values to arguments in method and constructor calls that are based on a fixed ordering for parameters,
which is the case for most popular OOP languages.

We introduce a new ontology for describing the mapping between the pure semantic parameters
to arguments in method calls in OOP languages like JavaScript, hence the name [_Object Mapping ontology_](https://linkedsoftwaredependencies.org/vocabularies/object-mapping).
[](#voc-om-diagram) shows an overview of all the classes and predicates in the ontology.

<figure id="voc-om-diagram">
<img src="voc-om-diagram.svg" alt="[Object Mapping ontology diagram]">
<figcaption markdown="block">
Overview of the classes and properties in the _Object Mapping_ ontology, with as prefix [`om`](https://linkedsoftwaredependencies.org/vocabularies/object-mapping#){:.mandatory}.
</figcaption>
</figure>

The ontology introduces the _object mapping_ and the _array mapping_, the latter is a subclass of the former.
An object map can have several _object mapping entries_, where each entry has a field name and a field value.
An array map can have several _array mapping entries_, where each entry only has a value.

If the value of `om:fieldName` or `om:fieldValue` is a literal, the literal value will be mapped to the object field name or value.
An `om:fieldValue` can also refer to another object map, which will be mapped to the resulting object.
`om:collectsEntriesFrom` can refer to a predicate that points to entities with certain predicates.
Each entity predicate that is refered to by `om:fieldName` will have its values mapped to keys of the object.
Each entity predicate refered to by `om:fieldValue` will have its values mapped to values.

[](#module-ldf-mapped) shows the mapping of the LDF component parameters to the constructor implementations.
This description enchances the component definitions from [](#module-ldf)
as it provides a lower level (implementation) view on the component constructors.

<figure id="module-ldf-mapped" class="listing">
````/code/module-ldf-mapped.ttl````
<figcaption markdown="block">
The HDT and SPARQL-based datasource constructors both take require a single object as argument for the constructor.
The entries of this object are mapped from the parameter values using this mapping.
The TPF server constructor similarly requires a single object,
where the `datasources` entry points to an object that is a mapping from datasource title to datasource.
</figcaption>
</figure>
