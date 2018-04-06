## Proof of Concept
{:#proof-of-concept}

To demonstrate the merits of a semantic Dependency Injection framework for JavaScript,
we present a proof of concept using the Node Package Manager (npm) library.
npm is a large collection of modules with over 600,000 JavaScript libraries,
all with their own features and requirements.
Such package contains the description of the project together with all its versions.
Using the terminology from [](#semantic-dependency-injection),
a specific version of a npm package is considered a _module_,
which contains the specific dependencies and a link to the actual implementation.

npm stores the metadata of every package in a [CouchDB](http://couchdb.apache.org/)
[instance](https://registry.npmjs.org/),
which includes the information added by the package developer in the [`package.json`](https://docs.npmjs.com/files/package.json) file,
and additional metadata added by the npm publishing process.
An example of a JSON representation of the N3.js npm package can be found at <https://registry.npmjs.org/n3/>{:.iri-link},
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

The semantic description of software metadata provides a useful platform for simplifying tasks that require a lot manual work,
such as discovering license incompatibilities between projects, which are now possible using a [SPARQL query](https://query.linkedsoftwaredependencies.org/#query=SELECT%20*%20WHERE%20%7B%0A%20%20%3Fbundle%20spdx%3AlicenseDeclared%20%3Chttps%3A%2F%2Fspdx.org%2Flicenses%2FGPL-3.0.html%3E.%0A%20%20%3Fbundle%20npm%3Adependency%20%3Fdependency.%0A%20%20%3Fdependency%20spdx%3AlicenseDeclared%20%3Chttps%3A%2F%2Fspdx.org%2Flicenses%2FGPL-2.0.html%3E.%0A%7D).
All 600,000 npm packages produced 300,000,000+ triples,
which we publish through a [Triple Pattern Fragments](cite:cites verborgh_iswc_2014) interface and as [HDT](cite:cites hdt) and [Turtle](cite:cites turtle) dumps.
These are located at [https://linkedsoftwaredependencies.org](https://linkedsoftwaredependencies.org/){:.mandatory}, together with subject pages for each bundle, module and user.
The triples are collected and republished daily to stay up-to-date with the available information on npm.

Queries are executed using a [Triple Pattern Fragments browser client](https://query.linkedsoftwaredependencies.org), which can provide insights that [the Web was intended to give](cite:citesForInformation InformationManagementAProposal).
Examples are given in [](#query-used) and [](#query-who), which answer the questions <q markdown="1">[Where is this module used?](https://query.linkedsoftwaredependencies.org/#query=SELECT%20DISTINCT%20%3Fproject%20%3FprojectName%20%3Fdescription%20WHERE%20%7B%0A%20%20%3Chttps%3A%2F%2Flinkedsoftwaredependencies.org%2Fbundles%2Fnpm%2Fn3%3E%20doap%3Arelease%20%3Fversion.%0A%20%20%3Fdependingversion%20npm%3Adependency%20%3Fversion.%0A%20%20%3Fproject%20doap%3Arelease%20%3Fdependingversion.%0A%20%20%3Fproject%20doap%3Aname%20%3FprojectName.%0A%20%20%3Fproject%20dc%3Aabstract%20%3Fdescription.%0A%7D)</q> and <q markdown="1">[Who wrote this code?](https://query.linkedsoftwaredependencies.org/#query=SELECT%20*%20WHERE%20%7B%0A%20%20%3Chttps%3A%2F%2Flinkedsoftwaredependencies.org%2Fbundles%2Fnpm%2Fn3%3E%20doap%3Amaintainer%20%3Fauthor.%0A%20%20%3Fauthor%20foaf%3Aname%20%3Fname.%0A%20%20%3Fauthor%20foaf%3Ambox%20%3Fmail.%0A%7D)</q>.

<figure id="query-used" class="listing">
````/code/query-used.txt````
<figcaption markdown="block">
SPARQL query to discover all dependencies of a package.
</figcaption>
</figure>

<figure id="query-who" class="listing">
````/code/query-who.txt````
<figcaption markdown="block">
SPARQL query to discover the author of a package.
</figcaption>
</figure>

As a complete example, the documentation of Components.js has been made self-instantiatable using its own framework and is available at [http://componentsjs.readthedocs.io/en/latest/example/](http://componentsjs.readthedocs.io/en/latest/example/).