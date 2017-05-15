## Use case: describing a Linked Data Fragments experiment
{:#use-case}

In this section, we provide a semantic description
of the experiment performed in a previous research article,
as a guiding example
on how to create such descriptions for other evaluations.
The intention is that future research articles
directly describe their experimental setup this way,
either through HTML with embedded RDFa
or as a reference to an IRI of an RDF document.

This experiment we will describe
originates from [an ISWC2014 article](cite:citesAsAuthority verborgh_iswc_2014)
and involves specific software configurations
of a Linked Data Fragments (LDF) client and server.
We have semantically described the [LDF server](https://github.com/LinkedDataFragments/Server.js/tree/feature-lsd) module and its 32 components.
Instead of the former domain-specific [JSON configuration file](https://github.com/LinkedDataFragments/Server.js/blob/master/config/config-example.json),
the [semantic configuration](https://github.com/LinkedDataFragments/Server.js/blob/feature-lsd/config/config-example.json) is Linked Data
and can be instantiated automatically by Components.js.
Furthermore, we provide an automatically generated semantic description
of all concrete installed dependency versions
for both the LDF client and server.
This is necessary because,
as discussed in [](#modules),
modules indicate a compatibility range
instead of a concrete version.

The ISWC2014 LDF experiment can be described using the following <a about="#ldf-2014-qdwha-experiment-workflow" content="LDF 2014 experiment workflow" href="#ldf-2014-qdwha-experiment-workflow" property="rdfs:label" rel="cc:license" resource="https://creativecommons.org/licenses/by/4.0/">workflow</a>:

<!-- TODO:
  Define (elsewhere) and reuse an actual IRI Template for the workflow and steps
  i.e., preferrably not relative to this document.
  Change "#ldf-2014-qdwha-" to something else that is machine-generated and
  determinstic. More specific to the operation and independent to the article it
  was used in.

-->

<ol id="ldf-2014-qdwha-experiment-workflow" property="schema:hasPart" resource="#ldf-2014-qdwha-experiment-workflow" typeof="opmw:WorkflowTemplate" markdown="1">
<li id="ldf-2014-qdwha-experiment-create-vm-for-server" about="#ldf-2014-qdwha-experiment-create-vm-for-server" typeof="opmw:WorkflowTemplateProcess" rel="opmw:isStepOfTemplate" resource="#ldf-2014-qdwha-experiment-workflow" property="rdfs:label">Create 1 virtual machine for the server.</li>
<li id="ldf-2014-qdwha-experiment-create-vm-for-cache" about="#ldf-2014-qdwha-experiment-create-for-cache" typeof="opmw:WorkflowTemplateProcess" rel="opmw:isStepOfTemplate" resource="#ldf-2014-qdwha-experiment-workflow" property="rdfs:label">Create 1 virtual machine for a cache.</li>
<li id="ldf-2014-qdwha-experiment-create-60-vm-for-clients" about="#ldf-2014-qdwha-experiment-create-60-vm-for-clients" typeof="opmw:WorkflowTemplateProcess" rel="opmw:isStepOfTemplate" resource="#ldf-2014-qdwha-experiment-workflow" property="rdfs:label">Create 60 virtual machines for clients.</li>
<li id="ldf-2014-qdwha-experiment-copy-generated-bsbm-dataset-to-server" about="#ldf-2014-qdwha-experiment-copy-generated-bsbm-dataset-to-server" typeof="opmw:WorkflowTemplateProcess" rel="opmw:isStepOfTemplate" resource="#ldf-2014-qdwha-experiment-workflow" property="rdfs:label">Copy a generated <a href="http://wifo5-03.informatik.uni-mannheim.de/bizer/berlinsparqlbenchmark/spec/Dataset/index.html">Berlin SPARQL benchmark dataset</a> to the server.</li>
<li id="ldf-2014-qdwha-experiment-install-server-software-config-with-tpf-spec" about="#ldf-2014-qdwha-experiment-install-server-software-config-with-tpf-spec" typeof="opmw:WorkflowTemplateProcess" rel="opmw:isStepOfTemplate" resource="#ldf-2014-qdwha-experiment-workflow" property="rdfs:label" markdown="1">Install [the server software configuration](https://linkedsoftwaredependencies.org/raw/ldf-availability-experiment-config.jsonld){:.mandatory}, implementing the [TPF specification](https://www.hydra-cg.com/spec/latest/triple-pattern-fragments/){:.mandatory}, with its [dependencies](https://linkedsoftwaredependencies.org/raw/ldf-availability-experiment-setup.ttl){:mandatory} on the server.
</li>
<li id="ldf-2014-qdwha-experiment-install-client-software-config-with-sparql" about="#ldf-2014-qdwha-experiment-client-software-config-with-sparql" typeof="opmw:WorkflowTemplateProcess" rel="opmw:isStepOfTemplate" resource="#ldf-2014-qdwha-experiment-workflow" property="rdfs:label" markdown="1">Install [the client software configuration](https://github.com/LinkedDataFragments/Client.js){:.mandatory}, implementing the [SPARQL 1.1 protocol](https://www.w3.org/TR/sparql11-protocol){:mandatory}, with its [dependencies](https://linkedsoftwaredependencies.org/raw/ldf-availability-experiment-client.ttl){:.mandatory} on each client.
</li>
<li id="ldf-2014-qdwha-experiment-execute-bsbm-per-client" about="#ldf-2014-qdwha-experiment-bsbm-per-client" typeof="opmw:WorkflowTemplateProcess" rel="opmw:isStepOfTemplate" resource="#ldf-2014-qdwha-experiment-workflow" property="rdfs:label">Execute four processes of the [Berlin SPARQL benchmark](cite:cites bsdm) with the client software for each client machine</li>
<li id="ldf-2014-qdwha-experiment-record-cpu-ram-client-server-io-cache" about="#ldf-2014-qdwha-experiment-record-cpu-ram-client-server-io-cache" typeof="opmw:WorkflowTemplateProcess" rel="opmw:isStepOfTemplate" resource="#ldf-2014-qdwha-experiment-workflow" property="rdfs:label">Record CPU time, RAM usage of each client, the CPU time and RAM usage of the server, and measure the ingoing and outgoing bandwidth of the cache.</li>
<li id="ldf-2014-qdwha-experiment-publish-results" about="#ldf-2014-qdwha-experiment-publish-results" typeof="opmw:WorkflowTemplateProcess" rel="opmw:isStepOfTemplate" resource="#ldf-2014-qdwha-experiment-workflow" property="rdfs:label">Publish <a href="http://data.linkeddatafragments.org/benchmark">results</a> online.</li>
</ol>

An *executed* workflow corresponding to the *abstract* experiment workflow above
generates entities based on each activity as performed by various agents.
Essentially the resulting observations of the experiment are
among other valuable immutable provenance level data which plays a vital role in
verifying and reproducing the steps which led to the outcome.
Concretely, the conclusions in the article
have the resulting data as provenance,
which in turn was generated by applying the steps above.

Crucially, in the description above,
we refer to the exact software configurations by their IRI,
their specific dependency versions,
and the specifications they implement.
These serve as further documentation of the provenance.
Additionally, based on these IRIs,
other researchers can immediately instantiate the same configuration,
or derive their own similar configurations
to create comparative experiments.
While software container solutions (such as [Docker](https://www.docker.com/))
could also provide immediate instantiation,
their configuration is on a much higher level.
Instead, the Object-Oriented Components ontology
captures the low-level wiring between components,
enabling researchers to swap individual algorithms
or component settings.

For example, based on the above description,
the exact same experiment can be performed
with [different client-side algorithms](cito:obtainsBackgroundFrom vanherwegen_eswc_2015)
or [different server-side interfaces](cito:obtainsBackgroundFrom hartig_odbase_2016).
A common practice to achieve this currently,
as done in the aforementioned works [](cito:citesAsEvidence vanherwegen_eswc_2015,hartig_odbase_2016),
is to implement modifications in separate code repository branches.
Unfortunately,
such branches typically diverge from the main code tree,
and hence cannot easily be evaluated afterwards
with later versions of other components.
By implementing them as independent modules instead,
they can be plugged in automatically
by minimally altering the declarative experiment description.
This simultaneously records their provenance,
enables their automated instantiation,
and ensures their sustainability.
