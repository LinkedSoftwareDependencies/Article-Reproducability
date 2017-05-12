## Use case: a Linked Data Fragments experiment
{:#use-case}

Sarven, Joachim, Ruben V. write this
{:.todo}

In this section, we will provide a semantic description
of the experiment performed in [a previous ISWC2014 article](cite:citesAsAuthority verborgh_iswc_2014),
which involves specific software configurations
of a Linked Data Fragments client and server.
This description serves as a guiding example
on how to create such descriptions for other evaluations.

To this end,
we have modularized the [LDF server](https://github.com/LinkedDataFragments/Server.js/tree/feature-lsd)
for dependency injection.
We have semantically described the LDF server module and its 32 components.
Instead of the former domain-specific [JSON configuration file](https://github.com/LinkedDataFragments/Server.js/blob/master/config/config-example.json),
the [semantic configuration](https://github.com/LinkedDataFragments/Server.js/blob/feature-lsd/config/config-example.json) is Linked Data
and can be instantiated automatically by Components.js.
