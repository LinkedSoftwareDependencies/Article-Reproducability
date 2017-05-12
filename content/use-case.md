## Use case: a Linked Data Fragments experiment
{:#use-case}

Sarven, Joachim, Ruben V. write this
{:.todo}

[Linked Data Fragments](cite:citesAsAuthority verborgh_jws_2016)

We have implemented a new version of the [LDF server](https://github.com/LinkedDataFragments/Server.js/tree/feature-lsd)
where all components are dynamically wired by Components.js.
We semantically describe the LDF server module and its 32 components, which results in x triples.
The configuration file used to be a [JSON file](https://github.com/LinkedDataFragments/Server.js/blob/master/config/config-example.json)
with a custom domain-specific language.
Now, this [configuration file](https://github.com/LinkedDataFragments/Server.js/blob/feature-lsd/config/config-example.json) is a declarative components file that can be understood by Components.js,.
This new configuration format has two major advantages:

* The configuration file is RDF data with a semantic meaning.
* External components can be injected by including declaratively into the config file.

{:.todo}
count triples
