## Instantiating component configurations
{:#instantiating}

mention closing of the world
{:.todo}

In the previous section, we introduced a vocabulary for describing software components and how they can be instantiated.
In this section, we introduce a dependency injection framework based on these component descriptions.
With this, we take semantic software component descriptions to the next level,
we don't only _describe_ components, but also allow them to be _instantiated_.

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
Additionally, [simplified mechanisms](https://github.com/LinkedSoftwareDependencies/Components.js#component-configuration-unnamed)
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
