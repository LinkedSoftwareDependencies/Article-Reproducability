## Related Work
{:#related-work}

Introduce section structure
{:.todo}

### Scholarly publishing and reproducibility
Sarven will start this
{:.todo}

We should cite [LOD Lab](cite:cites LODLab),
as they brought a major new angle to reproducibility within the Semantic Web.
Should also look at their argumentation.
{:.todo}

### Ontologies and vocabularies for describing experiments
Sarven will start this
{:.todo}

### Dependency injection

Software frameworks are often based on the concept of [Inversion of Control](cite:cites InversionOfControl,DesigningReusableClasses).
Inversion of Control is, according to [Fowler](cite:providesQuotationFor InversionOfControl), <q>a key part of what makes a framework different to a library</q>.
While a library provides functions that can be called by you, a framework provides some form kind of workflow,
where you can plug in certain functionality, and the framework will call you when needed[^HollywoodPrinciple].

[^HollywoodPrinciple]: This concept is also know as the [Hollywood Principle](cite:cites HollywoodPrinciple): <q>Don't call us, we'll call you</q>

[Dependency Injection](cite:cites DependencyInjection) is a form of Inversion of Control where components
are injected into other components by an external component.
Fowler defines a [software component](cite:providesQuotationFor DependencyInjection) as
<q>a glob of software that's intended to be used, without change, by an application that is out of the control of the writers of the component</q>.
Three types of dependency injection are typically distinguished,
which always need an external _Assembler_ component that is responsible for injecting the components.

* Interface injection: The assembler calls an `inject` method in the target component to inject its dependencies.
* Setter injection: The assembler maps interfaces to implementation instances.
* Constructor injection: The assember maps interfaces to implementation classes with their constructor parameters and allows dynamic construction.

Each of these types requires a configuration phase to wire the component instances or factories,
and an injection phase to plug in the actual dependencies inside components.
This wiring can either be done in code, or through external configuration files.
These configuration files are typically declarative, and can be defined in formats such as XML or JSON.
Separating configuration from code is considered a good practise in software design,
as it follows the principle of separating interfaces from implementation.
