## Conclusion
{:#conclusion}

The core idea of the scientific process is _to stand on the shoulders of giants_.
This means building further upon previous work to derive new work—but
also, enabling others to build upon our work.
Reproducibility, for instance, is an essential aspect of this process.
Not only does this concept apply to Web research as well,
but the Web makes an ideal platform to _improve_ the scientific process as a whole.

In this article, we introduce vocabularies for semantically describing software components and their configuration.
Publishing this information alongside experimental results is beneficial for the reproduction of experiments.

Through this work, we make it easier to build sustainable research platforms,
which helps pave the stairs to the shoulders of giants.
The Linked Data Fragments server, for instance, is a reusable research platform.
The LDF server and client can be compatible with multiple APIs, have multiple algorithms, etc.
Through this work, only one "core version" is necessary, and many different configurations can co-exist,
where support for different APIs and algorithms are simply pluggable components that are referred to within a configuration.
Since components and configurations are identified by a IRI,
they can exist anywhere on the Web.

A possibility would then be to have an injection framework
that can instantiate the software based on that IRI,
and wire its dependent components together automatically.
This would leverage the power of the Web to simplify the reproduction of existing experiments
and the creation of new ones.