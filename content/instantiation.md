## Instantiating component configurations
{:#instantiating}

In the previous section, we introduced a vocabulary for describing software components and their instantiation.
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
Finally, a declarative component instantiation is supplied by providing the component IRI.
</figcaption>
</figure>

While Linked Data is based on the open-world assumption, our dependency injector will close the world when we enter the realm of OOP.
This is because a closed-world assumption is required for features such as default arguments:
we have to assume that all the arguments that are available to the loader is everything there is.

The constructor injection described above works out of the box
with single-argument constructors that accept a map,
as is quite common in JavaScript.
For constructors that require a different kind of parameters,
we created the [_Object Mapping ontology_](https://linkedsoftwaredependencies.org/vocabularies/object-mapping),
which can be used to describe non-map constructors.