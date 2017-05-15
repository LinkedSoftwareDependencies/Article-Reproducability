## Describing software modules
{:#describing-modules}

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

Within this section, we will focus on bundles and modules,
while components are described more in-depth in [](#describing-components).

### Node Package Manager (npm)
An example of a large collection of bundles and modules is the npm library.
It contains over 480,000 JavaScript libraries,
all with their own features and requirements.
Using our terminology,
an npm package is a bundle,
while a specific version of such a package is a module.
The bundle contains the description of the project together with all its versions,
while a module contains the specific dependencies and a link to the actual implementation.

All this npm data is stored in a [CouchDB](http://couchdb.apache.org/)
[instance](https://registry.npmjs.org/) with one entry per bundle.
This corresponds to the metadata, added by the package developer in a [`package.json`](https://docs.npmjs.com/files/package.json) file,
with additional metadata automatically added by the npm publishing process.
To be able to uniquely identify software components and,
more importantly, interlink software components,
we converted the JSON metadata provided by the npm registry to RDF,
for which we set up a [server](https://github.com/LinkedSoftwareDependencies/npm-extraction-server){:.mandatory}.

### Interpreting package.json using JSON-LD
Since the input data is JSON,
we opted to convert it to [JSON-LD](cito:citesAsAuthority JSONLD),
an RDF syntax specifically designed for adding semantics to JSON.
JSON-LD achieves this by adding a so-called *context* to the JSON data,
which describes how the JSON tags should be interpreted.
E.g., having `"name": "foaf:name"` in your context implies
that all name tags should be interpreted as the predicate `foaf:name`.
Other JSON-LD keywords can be used to identify whether certain values are IRIs,
or whether an entity has a specific type.
For the data where we could not reach the format using just the JSON-LD context,
such as concatenating values to create a IRI,
we modified some of the input JSON before exporting it to JSON-LD.

### Bundles
A bundle represents the general npm package.
An example of a JSON representation of an npm bundle can be found at <https://registry.npmjs.org/n3/>{:.iri-link}.
This contains all the general descriptions that apply to all bundles in this module,
such as the name, homepage and description.

To adapt this JSON to RDF,
we start by adding our context,
<https://linkedsoftwaredependencies.org/contexts/npm>{:.iri-link},
which already maps many of the npm tags to corresponding RDF predicates.
This allows these tags to remain the same in the JSON-LD representation.
The limitations of context mapping necessitated
some other changes,
the most important one relating to the specific versions of the bundle.
This can be seen by retrieving <https://linkedsoftwaredependencies.org/bundles/npm/n3>{:.iri-link} with an `Accept: application/ld+json` header.
There the bundle now contains links to its corresponding modules,
providing semantic connections between them.
Additionally, some tags were added to provide identifiers and link to the original repository.

Since JSON-LD is an RDF representation, it can easily be converted to other syntaxes,
of which several are supported by our server,
such as Turtle and N-Triples.
These can be retrieved by sending the corresponding `Accept` headers.
An example of some of the data generated this way can be seen in [](#n3.ttl).

<figure id="n3.ttl" class="listing">
````/code/n3.ttl````
<figcaption markdown="block">
This listing shows a partial representation in the Turtle syntax of <https://linkedsoftwaredependencies.org/bundles/npm/n3>{:.iri-link}.
Prefixes omitted for brevity.
</figcaption>
</figure>

### Modules
A module is a specific version of a package.
Continuing with the examples shown above,
the JSON metadata of version 0.10.0 of the N3 bundle can be found at
<https://registry.npmjs.org/n3/0.10.0>{:.iri-link},
while the IRI in our namespace is <https://linkedsoftwaredependencies.org/bundles/npm/n3/0.10.0>{:.iri-link}.
Similarly, many of the tags are mapped by the context,
while other tags had to be modified to provide more relevant triples.

An important part of an npm package description are the dependencies
and their semantic versions.
For example, N3 0.10.0 has a dependency on `async ^2.0.1`.
`^2.0.1` is a semantic version and corresponds to any version number
of async that has a major version of `2`.
As can be seen in the JSON-LD,
this async dependency is converted to 
<https://linkedsoftwaredependencies.org/bundles/npm/async/%5E2.0.1>{:.iri-link},
with `%5E` being the URL-encoded `^`.
If accessed, the server detects the highest matching version number
and redirects to that module.
Additionally, the body of the redirect contains the relevant metadata describing this,
which in this case results in the following triple (prefixed for clarity):

```
async:\%5E2.0.1 npm:maxSatisfying async:2.4.0.
```

Additionally, to support in description which modules are being used on a machine,
we created a [tool](https://github.com/LinkedSoftwareDependencies/node-dependency-parser){:.mandatory}
that outputs the actual dependencies
used by a specific package installation in RDF.
This way the exact installation that was used can be described,
without having to rely on the interpretation of semantic versions which can change over time.

### Publication
480,000 npm packages correspond to 174,000,000+ triples when we collect the information from all packages.
Next to the subject pages for each bundle, module and user,
we also publish [all of this data](https://linkedsoftwaredependencies.org/){:.mandatory} through a [Triple Pattern Fragments](cite:cites verborgh_iswc_2014) interface
and as [HDT](cite:cites hdt) and [Turtle](cite:cites turtle) dumps.
This data is republished daily to stay up-to-date with the available information on npm.
Every day, we collect all triples that are generated by our system in a Turtle file.
After that, we convert this Turtle file to an HDT file.
Finally, this HDT file is loaded into a [TPF server](https://github.com/LinkedDataFragments/Server.js) instance,
which allows us to publish this data through a low-cost interface that still enables querying.
Using TPF, [custom SPARQL queries](https://query.linkedsoftwaredependencies.org/){:.mandatory} can be evaluated over this dataset,
such as retrieving all dependencies of a bundle and finding the author of a bundle.

