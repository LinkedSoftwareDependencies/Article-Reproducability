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
Finally, a declarative component instantiation is supplied by providing the component IRI
and the location at which the resource can be found.
</figcaption>
</figure>

While Linked Data is based on the open-world assumption, our dependency injector will close the world when we enter the realm of OOP.
This is because a close-world assumption is required for features such as default arguments:
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
The TPF server constructor similarly requires a single object,
where the `datasources` entry points to an object that is a mapping from datasource title to datasource.
</figcaption>
</figure>
