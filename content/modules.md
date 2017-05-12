## Describing software modules
{:#describing-modules}

Joachim writes this
{:.todo}

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

{:.todo}
I don't like how this line sticks to the listing

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

All this npm data is stored in a [CouchDB](http://couchdb.apache.org/) 
[instance](https://registry.npmjs.org/) with one entry per bundle.
This corresponds to the metadata, added by the package developer in a [`package.json`](https://docs.npmjs.com/files/package.json) file,
with additional metadata automatically added by the npm publishing process.
To be able to uniquely identify software components and,
more importantly, interlink software components,
we converted the JSON metadata provided by the npm registry to RDF.

### JSON-LD
Since our input data is JSON,
it made sense to convert to [JSON-LD](http://json-ld.org/),
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
An example of a JSON representation of an npm bundle can be found at [https://registry.npmjs.org/n3/](https://registry.npmjs.org/n3/).
This contains all the general descriptions that apply to all bundles in this module,
such as the name, homepage and description.

To adapt this JSON to RDF,
we start by adding our context,
[https://linkedsoftwaredependencies.org/contexts/npm](https://linkedsoftwaredependencies.org/contexts/npm),
which already maps many of the npm tags to corresponding RDF predicates.
This allows these tags to stay the same in the JSON-LD representation,
with changes required.
Due to the limitations of context mapping,
some other changes were needed,
with the most important one relating to the specific versions of the bundle.
This can be seen by calling [https://linkedsoftwaredependencies.org/bundles/npm/n3](https://linkedsoftwaredependencies.org/bundles/npm/n3) with the `"Accept: application/ld+json"` header or by accessing the more human friendly [URL](https://linkedsoftwaredependencies.org/bundles/npm/n3.jsonld).
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
Turtle representation of [](#n3.ttl).
Prefix definitions omitted for brevity.
</figcaption>
</figure>

### Modules
A module is a specific version of a package.
Continuing with the examples shown above,
[](#n3-0.10.0.json) provides some tags present
in the npm metadata of N3 version 0.10.0.
Since the general case of tags has already been covered above,
we focus on several more interesting tags in the metadata shown here.

As can be seen in the JSON-LD version in [](#n3-0.10.0.jsonld),
we minted several new URIs here.
In the dependencies, we now link to the semantic version `^2.0.1` 
of the async package in our own namespace.
This version corresponds to any version number of that package
that does not modify the left-most non-zero digit of the given version.
When accessing this URI,
the semantic version number will be interpreted
and a redirect will be given to the highest matching actual number.
In this case, a redirect will be given to 
[https://linkedsoftwaredependencies.org/bundles/npm/async/2.4.0](https://linkedsoftwaredependencies.org/bundles/npm/async/2.4.0).

For the scripts we also generated new URIs.
Several scripts are predefined by npm,
meaning they get shared by many packages,
so a shared URI for those makes sense.
The actual content of the script can be accessed by accessing the new script URI,
allowing for easier automation by services that can execute these scripts.

<figure id="n3-0.10.0.json" class="listing">
````/code/n3-0.10.0.json````
<figcaption markdown="block">
Subset of the JSON npm representation N3 version 0.10.0.
</figcaption>
</figure>

<figure id="n3-0.10.0.jsonld" class="listing">
````/code/n3-0.10.0.jsonld````
<figcaption markdown="block">
Subset of the JSON npm representation N3 version 0.10.0.
</figcaption>
</figure>
