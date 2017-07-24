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

### Describing components and their configuration
The [_Object-Oriented Components ontology_](https://linkedsoftwaredependencies.org/vocabularies/object-oriented)
is an ontology for describing software components and their instantiation in a certain configuration.
Within this ontology,
we reuse Fowler's definition of a [software component](cito:providesQuotationFor DependencyInjection) as a "glob" of software.
The purpose of a component is to provide operations that can be used by other components.
The instantiation of a component can require certain parameters,
just like object-oriented programming (OOP) languages allow constructors to have certain arguments.
We assume OOP in the broad sense of the word, which only requires _classes_, _objects_ and _constructor parameters_.

[](#module-ldf) shows a simplified example of the Linked Data Fragments (LDF) server npm module using the components ontology.
It exposes several components such as an HDT and SPARQL datasource and a TPF server,
each of which can take multiple parameters.
These are provided with a unique identifier and definition,
such that the software configuration can receive a semantic interpretation.
For example,
[](#config-ldf) illustrates how instances of these component types can be declared.

<figure id="module-ldf" class="listing">
````/code/module-ldf.ttl````
<figcaption markdown="block">
The LDF server module contains, among others, an HDT datasource component, which both extend from the abstract datasource component.
The HDT datasource is a class, which inherits the title parameter from the abstract datasource.
</figcaption>
</figure>

<figure id="config-ldf" class="listing">
````/code/config-ldf.ttl````
<figcaption markdown="block">
`ex:myServer` is a TPF server which will be loaded with a HDT and SPARQL-based datasource.
</figcaption>
</figure>
 