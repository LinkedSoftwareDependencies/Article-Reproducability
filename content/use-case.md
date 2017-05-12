## Use case: describing a Linked Data Fragments experiment
{:#use-case}

Sarven, Joachim, Ruben V. write this
{:.todo}

In this section, we will provide a semantic description
of the experiment performed in [a previous ISWC2014 article](cite:citesAsAuthority verborgh_iswc_2014),
which involves specific software configurations
of a Linked Data Fragments (LDF) client and server.
This description serves as a guiding example
on how to create such descriptions for other evaluations.

To this end,
we have modularized the [LDF server](https://github.com/LinkedDataFragments/Server.js/tree/feature-lsd)
for dependency injection.
We have semantically described the LDF server module and its 32 components.
Instead of the former domain-specific [JSON configuration file](https://github.com/LinkedDataFragments/Server.js/blob/master/config/config-example.json),
the [semantic configuration](https://github.com/LinkedDataFragments/Server.js/blob/feature-lsd/config/config-example.json) is Linked Data
and can be instantiated automatically by Components.js.

The ISWC2014 LDF experiment can be described by the following steps:

0. 1 virtual machine for the server was created.
0. 1 virtual machine for a cache was created.
0. 60 virtual machines for clients were created.
0. The generated [BSBM dataset](#) was copied to the server.
0. [The server software configuration](#) was installed on the server.
0. [The client software configuration](#) was installed on each client machine.
0. Each client machine executed four processes of the [BSBM benchmark](#)
   with the client software.
0. We recorded the CPU time, RAM usage of each client,
   the CPU time and RAM usage of the server,
   and we measured the ingoing and outgoing bandwidth of the cache.
