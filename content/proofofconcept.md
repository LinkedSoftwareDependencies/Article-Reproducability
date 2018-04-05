## Proof of Concept
{:#proof-of-concept}

To demonstrate the merits of a semantic Dependency Injection framework for JavaScript,
we present a proof of concept using the Node Package Manager (npm) library.
NPM is a large collection of modules with over 480,000 JavaScript libraries,
all with their own features and requirements.
Such package contains the description of the project together with all its versions.
Using the terminology from [](#semantic-dependency-injection),
a specific version of a NPM package is considered a _module_,
which contains the specific dependencies and a link to the actual implementation.

### Describing NPM packages

NPM stores the metadata of every package in a [CouchDB](http://couchdb.apache.org/)
[instance](https://registry.npmjs.org/),
which includes the information added by the package developer in the [`package.json`](https://docs.npmjs.com/files/package.json) file,
and additional metadata added by the npm publishing process.
An example of a JSON representation of the N3.js NPM package can be found at <https://registry.npmjs.org/n3/>{:.iri-link},
which contains all the general descriptions that apply to all packages in this module,
such as the name, homepage and description.
To uniquely identify software components and,
more importantly, interlink them,
we added a [JSON-LD](cito:citesAsAuthority JSONLD) context to the JSON metadata provided by the npm registry, 
and published this RDF in a [server](https://github.com/LinkedSoftwareDependencies/npm-extraction-server){:.mandatory}.
This context is available at <https://linkedsoftwaredependencies.org/contexts/npm.jsonld>{:.iri-link} and maps most of the npm tags to corresponding RDF predicates,
leaving these tags unchanged in the JSON-LD representation.

For data fields that could not be mapped by using just the JSON-LD context,
such as concatenating values to create a IRI,
we modified some of the input JSON before exporting it to JSON-LD.
The limitations of context mapping necessitated
some other changes,
the most important one relating to the specific versions of the package.
This can be seen by retrieving <https://linkedsoftwaredependencies.org/bundles/npm/n3>{:.iri-link} with an `Accept: application/ld+json` header.
In this case, the package contains links to its corresponding modules,
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
This listing shows a partial representation of <https://linkedsoftwaredependencies.org/bundles/npm/n3>{:.iri-link} in the Turtle syntax.
Prefixes omitted for brevity.
</figcaption>
</figure>


Continuing with the examples shown above,
a module of version 0.10.0 of the N3 bundle can be found at
<https://registry.npmjs.org/n3/0.10.0>{:.iri-link},
while the IRI in our namespace is <https://linkedsoftwaredependencies.org/bundles/npm/n3/0.10.0>{:.iri-link}.
Similarly, many of the tags are mapped by the context,
while other tags had to be modified to provide more relevant triples.
An example of some of the data generated for this module can be seen in [](#n3-0.10.0.ttl).

<figure id="n3-0.10.0.ttl" class="listing">
````/code/n3-0.10.0.ttl````
<figcaption markdown="block">
This listing shows a partial representation of <https://linkedsoftwaredependencies.org/bundles/npm/n3/0.10.0>{:.iri-link} in the Turtle syntax.
Prefixes omitted for brevity.
</figcaption>
</figure>

An important part of an npm package description are the dependencies
and their semantic versions.
For example, N3 0.10.0 has a dependency on `async ^2.0.1`.
`^2.0.1` is a semantic version and corresponds to any version number
of async that has a major version of `2`.
As can be seen in the JSON-LD,
this async dependency is converted to 
<https://linkedsoftwaredependencies.org/bundles/npm/async/%5E2.0.1>{:.iri-link},
with `%5E` being the URL-encoded character `^`.
If accessed, the server detects the highest matching version number
and redirects to that module.
Additionally, the body of the redirect contains the relevant metadata describing this,
which in this case results in the following triple (prefixed for clarity):

```
async:\%5E2.0.1 npm:maxSatisfying async:2.4.0.
```

Additionally, to properly describe which modules are being used on a machine,
we created a [tool](https://github.com/LinkedSoftwareDependencies/node-dependency-parser){:.mandatory}
that outputs the actual dependencies
used by a specific package installation in RDF.
This way the exact installation that was used can be described,
without having to rely on the interpretation of semantic versions which can change over time.

### Publication & Querying

480,000 npm packages correspond to 300,000,000+ triples when we collect the information from all packages.
Next to the subject pages for each bundle, module and user,
we also publish [all of this data](https://linkedsoftwaredependencies.org/){:.mandatory} through a [Triple Pattern Fragments](cite:cites verborgh_iswc_2014) interface
and as [HDT](cite:cites hdt) and [Turtle](cite:cites turtle) dumps.
This data is republished daily to stay up-to-date with the available information on npm.
Every day, we collect all triples that are generated by our system in a Turtle file.
After that, we convert this Turtle file to an HDT file.
Finally, this HDT file is loaded into a [TPF server](https://github.com/LinkedDataFragments/Server.js) instance,
which allows us to publish this data through a low-cost interface that still enables querying.

[Custom SPARQL queries](https://query.linkedsoftwaredependencies.org/){:.mandatory} can be evaluated over this dataset to gain insights.


<figure id="query-ld" class="listing">
````/code/query-ld.txt````
<figcaption markdown="block">
Something Something darkside
</figcaption>
</figure>

such as retrieving all dependencies of a bundle 

<figure id="query-used" class="listing">
````/code/query-used.txt````
<figcaption markdown="block">
Something Something darkside
</figcaption>
</figure>


finding the author of a bundle.

<figure id="query-who" class="listing">
````/code/query-who.txt````
<figcaption markdown="block">
Something Something darkside
</figcaption>
</figure>