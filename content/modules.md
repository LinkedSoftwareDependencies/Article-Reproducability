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
This corresponds to the [metadata](https://docs.npmjs.com/files/package.json) added by the package developer,
with additional metadata automatically added by the npm publishing process.

To be able to uniquely identify software components and,
more importantly, interlink software components,
we converted the JSON metadata provided by the npm registry to JSON-LD.

### Bundles

### Modules
