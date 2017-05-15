## Describing software modules
{:#describing-modules}

There are several levels of granularity on which software can be described,
going from a high-level package overview to a low-level description of the actual code.
In our descriptions we make use of several of these layers,
depending on the context and the requirements.
Drilling down from the top to the bottom, we have the following layers:
 
 - a *bundle* is a container. It describes what the software is expected to do. 
 An example of this would be the *N3.js* library.
 - a *module* is a software package implementing a specific bundle. 
 This is also known as a version of a bundle.
 *N3.js 0.10.0* is a module.
 - a *component* is a specific part of a module 
 that can be called in a certain way with a certain set of parameters.
 The *N3.js 0.10.0 Parser* is a component.

Within this section we will focus on bundles and modules,
while components are described more in-depth in the following sections.

### Node Package Manager (npm)
An example of a large collection of bundles and modules is the npm library.
It contains over 475,000 Node.js libraries,
all with their own features and requirements.
Using our terminology,
an npm package would be a bundle,
while a specific version of such a package would be a module.
The package contains the description of the project together with all its versions,
while a version contains the specific dependencies and a link to the actual implementation.

All this npm data is stored in a [CouchDB](http://couchdb.apache.org/){:.mandatory} 
[instance](https://registry.npmjs.org/){:.mandatory} with one entry per bundle.
This corresponds to the metadata, added by the package developer in a [`package.json`](https://docs.npmjs.com/files/package.json){:.mandatory} file,
with additional metadata automatically added by the npm publishing process.
To be able to uniquely identify software components and,
more importantly, interlink software components,
we converted the JSON metadata provided by the npm registry to RDF.

### JSON-LD
Since our input data is JSON,
it made sense to convert to [JSON-LD](http://json-ld.org/){:.mandatory},
a format specifically made for adding semantics to JSON.
JSON-LD achieves this by adding a so-called *context* to the JSON data.
This context describes how the JSON tags should be interpreted.
E.g., having `"name": "foaf:name"` in your context implies
that all name tags should be interpreted as the predicate `foaf:name`.
Other JSON-LD keywords can be used to identify if certain values are URIs,
or if an entity has a specific type.
For the data where we could not reach the format using just the JSON-LD context,
such as concatenating values to create a URI,
we modified some of the input JSON before exporting it to JSON-LD.

{:.todo}
Decrease tags in examples for pages.
Probably also drop either JSON-LD or turtle

### Bundles
A bundle represents the general npm package.
An example of a JSON representation of an npm bundle can be found at <https://registry.npmjs.org/n3/>.
This contains all the general descriptions that apply to all bundles in this module,
such as the name, homepage and description.

To adapt this JSON to RDF,
we start by adding our context,
<https://linkedsoftwaredependencies.org/contexts/npm>,
which already maps many of the npm tags to corresponding RDF predicates.
This allows these tags to stay the same in the JSON-LD representation,
with changes required.
Due to the limitations of context mapping,
some other changes were needed,
with the most important one relating to the specific versions of the bundle.
This can be seen by calling <https://linkedsoftwaredependencies.org/bundles/npm/n3> with the `"Accept: application/ld+json"` header..
There the bundle now contains links to its corresponding modules,
providing semantic links between them.
Additionally, some tags were added to provide identifiers and link to the original repository.

Since JSON-LD is an RDF representation it can easily be converted to other formats,
of which several are supported by our server,
such as turtle and n-triples.
These can be retrieved by sending the corresponding Accept headers.
An example of some of the data generated this way can be seen in [](#n3.ttl).

{:.todo}
Bit weird to link to the listing at the end, might have to change the story up a bit somehow.

<figure id="n3.ttl" class="listing">
````/code/n3.ttl````
<figcaption markdown="block">
Partial turtle representation of <https://linkedsoftwaredependencies.org/bundles/npm/n3>.
Prefix definitions omitted for brevity.
</figcaption>
</figure>

### Modules
A module is a specific version of a package.
Continuing with the examples shown above,
the JSON metadata of version 0.10.0 of the N3 bundle can be found at
<https://registry.npmjs.org/n3/0.10.0>,
while the URI in our namespace is <https://linkedsoftwaredependencies.org/bundles/npm/n3/0.10.0>.
Here also, many of the tags are mapped by the context,
while other tags had to be modified to provide more interesting data.

An important part of an npm package description are the dependencies
and their semantic versions.
E.g., N3 0.10.0 has a dependency on `async ^2.0.1`.
`^2.0.1` is a semantic version and corresponds to any version number
of async that starts with a 2.
As can be seen in the JSON-LD,
this async dependency gets converted to 
<https://linkedsoftwaredependencies.org/bundles/npm/async/%5E2.0.1>,
with `%5E` being the url-encoded `^`.
If accessed, the server detects the highest matching version number
and redirects to that module.
Additionaly, the body of the redirect contains the relevant metadata describing this,
which in this case results in the following triple (prefixed for brevity):

```
async:\%5E2.0.1 npm:maxSatisfying async:2.4.0.
```

Another tag where we changed the content is the *scripts* tag.
Since there is a fixed set of scripts that [npm supports](https://docs.npmjs.com/misc/scripts){:.mandatory},
being able to easily query those can be helpful for automated systems.
To that end we converted the actual script tags to specific predicates,
such as `<https://linkedsoftwaredependencies.org/scripts/npm/test>` for the test script.
These predicates have as object a new URI that links to actual content of that script,
meaning the execution script is found by accessing that URI.

### Publication
475,000 npm packages correspond to 150,000,000+ triples when we collect the information from all packages.
Next to the subject pages for each bundle, module and user,
we also publish [all of this data](https://linkedsoftwaredependencies.org){:.mandatory} through a [Triple Pattern Fragments](cite:cites verborgh_iswc_2014) interface
and as [HDT](cite:cites hdt) and [Turtle](cite:cites turtle) dumps.
This data is republished every day to stay up-to-date with the available information on npm.
Every day, we collect all triples that are generated by our system in a Turtle file.
After that, we convert this Turtle file to a HDT file.
Finally, this HDT file is loaded into a [TPF server](https://github.com/LinkedDataFragments/Server.js) instance,
which allows us to publish this data through a low-cost interface that still enables querying.
Using TPF, we allow several [queries](https://query.linkedsoftwaredependencies.org/){:.mandatory} to be evaluated over this dataset,
such as retrieving all dependencies of a bundle and finding the author of a bundle.

