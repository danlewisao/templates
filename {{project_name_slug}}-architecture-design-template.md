# Architecture Design Document for {Project/Solution Name}

Version: {x.x.x}

Date: {dd/mm/yyyy}

Status: {**Working Draft** \ **Proposed Recommendation** \ **Recommendation**}

# !!IMPORTANT USAGE NOTES!!

Agile methods are not opposed to documentation, only to valueless documentation. Documents that assist the team itself can have value, but only if they are kept up to date. Large documents are seldom kept up to date. Small, modular documents have at least a chance at being updated.

Therefore you should consider the following sections as OPTIONAL and include only if appropriate to the design in question

- [Components](#components)
- [Runtime View](#runtime-view)
- [Cross-cutting Concepts](#cross-cutting-concepts) - choose only those cross cutting concerns that are appropriate and always try and refer to existing or isolated [standards](../../docs/reference/standards/README.md)
- [Infrastructure Level 2](#infrastructure-level-2)
- [Standards Conformance](#standards-conformance)
- [Decommissioning](#decommissioning)

Where possible re-use and include existing project assets, such as data models, API specifications and DO NOT
document for the sake of documentation, ever!

A markdown pre-processing docker image is available to facilitate document includes [here](../tools/markdown-pre-processor/README.md)

# Document Control

| Title            | Document Author | Product Manager   |
|------------------|-----------------|-------------------|
| {approach-title} | {author}        | {product-manager} |

# Change History

| Version   | Status                                                                 | Author/Editor | Change (brief summary of change) |
|-----------|------------------------------------------------------------------------|---------------|----------------------------------|
| {version} | {**Working Draft** \ **Proposed Recommendation** \ **Recommendation**} | {author}      | {change}                         |


# Table of Contents
- [Architecture Design Document for {Project/Solution Name}](#architecture-design-document-for-projectsolution-name)
- [!!IMPORTANT USAGE NOTES!!](#important-usage-notes)
- [Document Control](#document-control)
- [Change History](#change-history)
- [Table of Contents](#table-of-contents)
- [Introduction and Goals](#introduction-and-goals)
  - [Requirements Overview](#requirements-overview)
  - [Quality Goals](#quality-goals)
  - [Stakeholders](#stakeholders)
- [Architecture Constraints](#architecture-constraints)
- [System Scope and Context](#system-scope-and-context)
- [Solution Strategy](#solution-strategy)
- [Building Block View](#building-block-view)
  - [Containers](#containers)
    - [Change](#change)
    - [Container Interfaces](#container-interfaces)
  - [Components](#components)
    - [Component 1](#component-1)
    - [Component 2](#component-2)
    - [Component n](#component-n)
  - [Code](#code)
- [Runtime View](#runtime-view)
  - [Data](#data)
  - [Runtime Scenario 1](#runtime-scenario-1)
  - [Runtime Scenario 2](#runtime-scenario-2)
  - [Runtime Scenario n](#runtime-scenario-n)
- [Deployment View](#deployment-view)
  - [Deployment Diagram](#deployment-diagram)
    - [Change](#change-1)
  - [Infrastructure Level 2](#infrastructure-level-2)
    - [<Infrastructure Element 1>](#infrastructure-element-1)
    - [<Infrastructure Element 2>](#infrastructure-element-2)
    - [*\<Infrastructure Element n\>*](#infrastructure-element-n)
- [Cross-cutting Concepts](#cross-cutting-concepts)
  - [InfoSec SureCloud](#infosec-surecloud)
  - [Data/domain models](#datadomain-models)
  - [Persistency](#persistency)
  - [User interface](#user-interface)
  - [I don't like GPL License](#i-dont-like-gpl-license)
  - [User Interface optimisations](#user-interface-optimisations)
  - [Transaction processing](#transaction-processing)
  - [Open Source Vulnerabilities](#open-source-vulnerabilities)
  - [External Pen Test](#external-pen-test)
  - [CIS Hardening](#cis-hardening)
  - [Patching](#patching)
  - [System resiliency](#system-resiliency)
  - [Scalability](#scalability)
  - [Performance Testing](#performance-testing)
  - [Session Handling](#session-handling)
  - [Security (Authentication / Authorization)](#security-authentication--authorization)
  - [Architecture patterns or design patterns](#architecture-patterns-or-design-patterns)
  - [Rules for using specific technology](#rules-for-using-specific-technology)
  - [Implementation rules and maintenance](#implementation-rules-and-maintenance)
  - [Exception/Error Handling](#exceptionerror-handling)
  - [Logging, Tracing](#logging-tracing)
  - [Configurability](#configurability)
  - [Internationalization](#internationalization)
  - [Migration](#migration)
  - [Testability](#testability)
  - [Build-Management](#build-management)
  - [DevOps - Separation of Duties](#devops---separation-of-duties)
  - [Concept 1](#concept-1)
  - [Concept 2](#concept-2)
  - [Concept n](#concept-n)
- [Design Decisions](#design-decisions)
- [Quality Requirements](#quality-requirements)
  - [Quality Tree](#quality-tree)
  - [Quality Scenarios](#quality-scenarios)
- [Standards Conformance](#standards-conformance)
- [Technical Risks and Technical Debt](#technical-risks-and-technical-debt)
- [Decommissioning](#decommissioning)
- [Information Security](#information-security)
  - [Data Privacy Impact Assessment (DPIA)](#data-privacy-impact-assessment-dpia)
- [Supporting Strategy](#supporting-strategy)
- [Glossary](#glossary)

# Introduction and Goals

**InfoSec mandatory:** Yes

* *below in the document you will find whether a paragraph is important from InfoSec point of view, meaning is mandatory to have InfoSec approval of the design.*

**Contents.**

Describe the relevant requirements and the driving forces that architects
and development teams must consider.

Including:

- underlying business goals
- essential features and functional requirements of the project/system
- quality goals for the architecture
- relevant stakeholders and their expectations

## Requirements Overview

**InfoSec mandatory:** Yes

**Contents.**

Short description of the functional requirements, driving forces,
extract (or abstract) of requirements. 

Link to (hopefully existing) requirements (Epics) in Backlog/Roadmap. Hopefully in AzureDevOps.

Ideally Acceptance criteria should be defined as BDD features/scenarios, including NFRs.

For example:

```gherkin
Feature: DAM Search Latency

    As a member of the Creative Services Team,
    or the Off shore team, all DAN searches
    must not be affected by latency 

Scenario: Simple DAM search   
	Given a web browser is on the DAM search page   
	When the search phrase "A&O" is entered   
	And the user is in the <region>
    Then the results must return in <time> seconds 

    | region    | time |
    | UK        | 2    |
    | Australia | 5    |
```

**Motivation.**

From the point of view of the end-users, a system is created or modified
to improve the support of the business activity and/or improve the quality.

BDD features/scenarios ensure that the business, developers and testers all
use the same ubiqituous language to define acceptance.

**Form.**

Short textual description to summarise the requirements.

If requirements documents/features/scenarios exist this overview must refer to these documents in AzureDevOPs.

Project Acceptance should be defined as a set of BDD Features/Scenarios within AzureDevOPs.

In most cases these features should be automated within the code base and builds should only pass if all acceptance tests are green and pass. Thus ensuring that
the whole team understands and can measure quality and acceptance.

Balance readability of this document with potential redundancy w.r.t to requirements documents.

## Quality Goals

**InfoSec mandatory:** Yes

**Contents.**

The top three (max five) quality goals for the architecture whose
fulfilment is of the highest importance to the major stakeholders. We
mean quality goals for the architecture. Don't confuse them with
project goals. They are not necessarily identical.

**Motivation.**

You should know the quality goals of your most important stakeholders
since they will influence fundamental architectural decisions. Make sure
to be very concrete about these qualities, avoid buzzwords. If you as an
architect do not know how the quality of your work will be judged ...

**Form.**

A table with quality goals and concrete scenarios, ordered by priorities

For Example

## Stakeholders

**InfoSec mandatory:** No

**Contents.**

Explicit overview of stakeholders of the system, i.e. all person, roles
or organizations that

- should know the architecture

- have to be convinced of the architecture

- have to work with the architecture or with code

- need the documentation of the architecture for their work

- have to come up with decisions about the system or its development

**Motivation.**

You should know all parties involved in the development of the system or
affected by the system. Otherwise, you may get nasty surprises later in
the development process. These stakeholders determine the extent and the
level of detail of your work and its results.

**Form.**

Table with role names, person names, and their expectations with respect
to the architecture and its documentation.

| Role/Name    | Contact         | Expectations        |
| ------------ | --------------- | ------------------- |
| *\<Role-1\>* | *\<Contact-1\>* | *\<Expectation-1\>* |
| *\<Role-2\>* | *\<Contact-2\>* | *\<Expectation-2\>* |

# Architecture Constraints

**InfoSec mandatory:** Yes

**Content.**

Any requirement that constrains software architects in their freedom of
design and implementation decision or decisions about the development
process. These constraints sometimes go beyond individual systems and
are valid for whole organizations and companies.

**Motivation.**

Architects should know exactly where they are free in their design
decisions and where they must adhere to constraints. Constraints must
always be dealt with; they may be negotiable, though.

**Form.**

Simple tables of constraints with explanations. If needed you can
subdivide them into technical constraints, organizational and political
constraints and conventions (e.g. programming or versioning guidelines,
documentation or naming conventions)

# System Scope and Context

**InfoSec mandatory:** Yes

**Content.**

[C4 Context diagram](https://c4model.com/#SystemContextDiagram)

A System Context diagram is a good starting point for diagramming and
documenting a software system, allowing you to step back and see the
big picture. Draw a diagram showing your system as a box in the center,
surrounded by its users and the other systems that it interacts with.

The detail isn't important here as this is your zoomed out view showing
a big picture of the system landscape. The focus should be on people
(actors, roles, personas, etc) and software systems rather than
technologies, protocols, and other low-level details. It's the sort of
diagram that you could show to non-technical people.

Scope: A single software system.

Primary elements: The software system in scope.
Supporting elements: People (e.g. users, actors, roles, or personas)
and software systems (external dependencies) that are directly
connected to the software system in scope. Typically these other software
systems sit outside the scope or boundary of your software system,
and you don’t have responsibility or ownership of them.

Intended audience: Everybody, both technical and non-technical people,
inside and outside of the software development team.

# Solution Strategy

**InfoSec mandatory:** Yes

**Contents.**

A summary and explanation of the fundamental decisions and
solution strategies, that shape the system's architecture. These include

- technology decisions

- decisions about the top-level decomposition of the system, e.g. usage
  of an architectural pattern or design pattern

- decisions on how to achieve key quality goals

- relevant organizational decisions, e.g. selecting a development process
  or delegating certain tasks to third parties.

# Building Block View

**InfoSec mandatory:** Yes

**Content.**

The building block view describes the decomposition of the system
into building blocks (containers, components, classes) as well as their
dependencies (relationships, associations, ...)

- A Container diagram is mandatory.
- Component diagrams are only required for particularly interesting/important or
technically challenging components. In most cases, these can be left out of the
design.
- Class diagrams are only required for particularly challenging
  interesting/important components. In most cases, design should be done by
  writing code and can be left out of the design.

## Containers

**InfoSec mandatory:** Yes

**Contents.**

[C4 Container diagram](https://c4model.com/#SystemContextDiagram)

NOTE: Preferred notation is to use embedded PlantUML.

Once you understand how your system fits into the overall IT environment, a
really useful next step is to zoom-in to the system boundary with a Container
diagram. A "container" is something like a server-side web application,
single-page application, desktop application, mobile app, database schema,
file system, etc. Essentially, a container is a separately runnable/deployable
unit (e.g. a separate process space) that executes code or stores data.

The Container diagram shows the high-level shape of the software architecture
and how responsibilities are distributed across it. It also shows the major
technology choices and how the containers communicate with one another. It's
a simple, high-level technology focussed diagram that is useful for software
developers and support/operations staff alike.

Scope: A single software system.

Primary elements: Containers within the software system in scope.
Supporting elements: People and software systems are directly connected to the
containers.

Intended audience: Technical people inside and outside of the software
development team; including software architects, developers, and operations/support
staff.

Notes: This diagram says nothing about deployment scenarios, clustering,
replication, failover, etc See [Deployment Diagram](#deployment-diagram)

**InfoSec Guidance**  

The Container diagram will allow InfoSec to determine all the elements which compose the system, so that its 
defensive measures have no blind spots.  The PlantUML container diagram describes  encryption in transit, 
at rest, protocols used etc.

### Change

**InfoSec mandatory:** N

**Contents.**

It is important to describe any areas of the current Technology domain which will
change or that will be impacted by this design. Therefore include a list
describing existing containers with the design modification and impact.

**Form.**

A table with columns \<Container\> and \<Change\>.

| Container       | Change       |
|-----------------|--------------|
| \<Container-1\> | \<change-1\> |
| \<Container-2\> | \<change-2\> |

### Container Interfaces

**InfoSec mandatory:** Yes

Table with links to Interface/API specifications.
API specifications should ideally be included as links to Mock Services rather
than static definitions.

Always use standards where possible:

- REST: Open API
- GraphQL: Schema
- Etc.

Avoid defining API/Interfaces as non-executable documentation.
Do NOT define APIs in design docs!


| Interface | Description | Specification Link              |
|-----------|-------------|---------------------------------|
| #         | <descrip>   | <url to mock or interface spec> |

## Components

**InfoSec mandatory:** No

OPTIONAL!! Mostly not required! Component diagrams are only required for
particularly interesting/important or technically challenging components.
In most cases, these can be left out of the design.

[C4 Component Diagram](https://c4model.com/#ComponentDiagram)

Next you can zoom in and decompose each container further to identify
the major structural building blocks and their interactions.

The Component diagram shows how a container is made up of a number of
"components", what each of those components is, their responsibilities,
and the technology/implementation details.

Scope: A single container.

Primary elements: Components within the container in scope.
Supporting elements: Containers (within the software system in scope) plus
people and software systems directly connected to the components.

Intended audience: Software architects and developers.

### Component 1

- *\<insert  component diagram or textual description of the component\>*

- *\<insert description of the notable aspects of the interactions
between the building block instances depicted in this diagram.\>*

### Component 2

### Component n

## Code

**InfoSec mandatory:** No

OPTIONAL!! Mostly not required!

Finally, you can zoom in to each component to show how it is implemented
as code; using UML class diagrams, entity-relationship diagrams, or similar.

This is an optional level of detail and is often available on-demand
from tooling such as IDEs. Ideally, this diagram would be automatically
generated using tooling (e.g. an IDE or UML modelling tool), and you should
consider showing only those attributes and methods that allow you to tell
the story that you want to tell. This level of detail is not recommended for
anything but the most important or complex components.

Scope: A single component.

Primary elements: Code elements (e.g. classes, interfaces, objects, functions,
database tables, etc) within the component in scope.

Intended audience: Software architects and developers.

# Runtime View

**InfoSec mandatory:** Yes, for certain scenarios related to security, like the authentication flow, handling of keys, etc.

NOTE!!! Only include particularly interesting, important, or challenging
behaviours and interactions. Don't document for documentation's sake!

BUT: The primary container interactions must be described. Ideally
as a sequence diagram. 

These runtime views intend to describe system interactions.
They are also included to show how authentication/authorisation occurs, 
the protocols used, encryption and token usage.

A data table should be included that describes data in transit between
the container interfaces. Of the form:

## Data

**InfoSec mandatory:** Yes

What data is processed with this system design? Is encryption used to protect sensitive data?
Is Pseudonymisation or anonymization used to protect personal information?

| Data name   | Confidentiality | Integrity                                                | Availability | Backup? | Description                                                   | Encryption          | Pseudonymisation            |
|-------------|-----------------|----------------------------------------------------------|--------------|---------|---------------------------------------------------------------|---------------------|-----------------------------|
| {DATA_NAME} | Sensitive/Highly Restricted/Restricted/Public | [describe](https://en.wikipedia.org/wiki/Data_integrity) | Medium       | Yes/No  | Descirption of the data possibly with a reference to a sample | Describe encryption | Client/Personal information |


**Contents.**

The runtime view describes concrete behaviors and interactions of the
system's building blocks in form of scenarios from the following areas:

- important use cases or features: how do building blocks execute
  them?

- interactions at critical external interfaces: how do building blocks
  cooperate with users and neighboring systems?

- operation and administration: launch, start-up, stop

- error and exception scenarios

Remark: The main criterion for the choice of possible scenarios
(sequences, workflows) is their **architectural relevance**. It is
**not** important to describe a large number of scenarios. You should
rather document a representative selection.

**Motivation.**

You should understand how (instances of) building blocks of your system
perform their job and communicate at runtime. You will mainly capture
scenarios in your documentation to communicate your architecture to
stakeholders that are less willing or able to read and understand the
static models (building block view, deployment view).

**Form.**

There are many notations for describing scenarios, e.g.


- **sequence diagrams** Preference!

- numbered list of steps (in natural language)

- activity diagrams or flow charts

- BPMN or EPCs (event process chains)

- state machines

- ...

## Runtime Scenario 1

- *\<insert runtime diagram or textual description of the scenario\>*

- *\<insert description of the notable aspects of the interactions
between the building block instances depicted in this diagram.\>*

## Runtime Scenario 2

## Runtime Scenario n

# Deployment View

**InfoSec mandatory:** Yes, for information on network security and connectivity.

**Content.**

The deployment view describes:

1. the technical infrastructure used to execute your system, with
   infrastructure elements like geographical locations, environments,
   computers, processors, channels, and network topologies as well as other
   infrastructure elements and

2. the mapping of (software) building blocks to that infrastructure
   elements.

Often systems are executed in different environments, e.g. development
environment, test environment, production environment. In such cases, you
should document all relevant environments.

Especially document the deployment view when your software is executed
as a distributed system with more than one computer, processor, server or
container or when you design and construct your own hardware processors
and chips.

From a software perspective, it is sufficient to capture those elements
of the infrastructure that are needed to show the deployment of your
building blocks. Hardware architects can go beyond that and describe the
infrastructure to any level of detail they need to capture.

**Motivation.**

Software does not run without hardware. This underlying infrastructure
can and will influence your system and/or some cross-cutting concepts.
Therefore, you need to know the infrastructure.

In this section you will zoom into the
[Context Diagram](#system-scope-and-context) with additional deployment
diagrams to provide more detail

## Deployment Diagram

**InfoSec mandatory:** No, but please explain network connectivity and security in other way if not providing Deployment Diagram.

[C4 Deployment diagram](https://c4model.com/#DeploymentDiagram)

A deployment diagram allows you to illustrate how software systems and/or
containers in the static model are mapped to infrastructure. This deployment
diagram is based upon a UML deployment diagram, although simplified slightly
to show the mapping between containers and deployment nodes. A deployment
node is something like physical infrastructure (e.g. a physical server or
device), virtualised infrastructure (e.g. IaaS, PaaS, a virtual machine),
containerised infrastructure (e.g. a Docker container), an execution
environment (e.g. a database server, Java EE web/application server,
Microsoft IIS), etc. Deployment nodes can be nested.

You may also want to include infrastructure nodes such as DNS services,
load balancers, firewalls, etc.

Scope: One or more software systems.

Primary elements: Deployment nodes, software system instances, and
container instances.
Supporting elements: Infrastructure nodes used in the deployment of the software system.

Intended audience: Technical people inside and outside of the software development
team; including software architects, developers, infrastructure architects, and
operations/support staff.

- Motivation and Rationale
 *\<explanation in text form\>*

- Quality and/or Performance Features  
 *\<explanation in text form\>*

### Change

**InfoSec mandatory:** No

**Contents.**

It is important to describe any areas of the current Technology domain which will
change or that will be impacted by this design. Therefore include a list that
describes existing infrastructure with the design modification and impact.

**Form.**

A table with columns \<Component\> and \<Change\>.

| Component       | Change       |
|-----------------|--------------|
| \<Component-1\> | \<change-1\> |
| \<Component-2\> | \<change-2\> | 

## Infrastructure Level 2

OPTIONAL: Here you can include the internal structure of (some) infrastructure
elements from level 1.

### <Infrastructure Element 1>

*\<diagram + explanation\>*

### <Infrastructure Element 2>

*\<diagram + explanation\>*

### *\<Infrastructure Element n\>*

*\<diagram + explanation\>*

# Cross-cutting Concepts

**InfoSec mandatory:** See each component below.

**Content.**

This section describes overall, principal regulations and solution ideas
that is relevant in multiple parts (= cross-cutting) of your system.
Such concepts are often related to multiple building blocks. They can
include many different topics, such as.

In many cases the approach will align with known
[standards](../../docs/reference/standards/README.md) and in some cases may required the
curation of a standards document.

Always consider [NCSC.GOV.UK Cyber Security Design Principles](https://www.ncsc.gov.uk/collection/cyber-security-design-principles/cyber-security-design-principles) to ensure the system is "Secure by Design"

**Motivation.**

Concepts form the basis for *conceptual integrity* (consistency,
homogeneity) of the architecture. Thus, they are an important
contribution to achieve the inner qualities of your system.

Some of these concepts cannot be assigned to individual building blocks
(e.g. security or safety). This is the place in the template for a
cohesive specification of such concepts.

## InfoSec SureCloud

**InfoSec mandatory:** Yes

Third Party application: Has a [SureCloud](https://www.surecloud.com/) assessment and [DPIA](./dipa-assessment-with-guidance.md) been completed?

## Data/domain models

**InfoSec mandatory:** Yes

(ER Models, Ontology Models, JSON/XML Schema etc.).
Ideally reverse engineered from source DDL, RDFS/OWL, JSON Schema etc.

## Persistency

**InfoSec mandatory:** Yes

Storage options and frameworks. 
Include a description of encryption at rest (client/personal information)
Is Pseudonymization or anonymization used to protect personal information? Describe the process and mechanism.

## User interface

**InfoSec mandatory:** No

Description of the frameworks and patterns used to build the user interface

## I don't like GPL License

**InfoSec mandatory:** Yes

Describe the open/source licenses in use. Ideally refer to a WhiteSource license scan.

## User Interface optimisations

**InfoSec mandatory:** No

(JavaScript and CSS optimizations, minifier's etc)

## Transaction processing

**InfoSec mandatory:** No

Approach and frameworks.

## Open Source Vulnerabilities

**InfoSec mandatory:** Yes

Reduce attack surface – has the container image, source code, VM been scanned with Whitesource / Qualys? 

## External Pen Test

**InfoSec mandatory:** Yes

Has an external security test been requested to InfoSec?

## CIS Hardening 

**InfoSec mandatory:** Yes

Has or will CIS hardening or other best practice configuration been followed.

## Patching

**InfoSec mandatory:** Yes

What process will be used for system and application patching (Existing solution / ad-hoc - custom / 3rd Party service)

## System resiliency 

**InfoSec mandatory:** No

Design a system that is resilient to denial of service attacks and usage spikes!

Describe the system resiliency design and requirements
What 3rd parties if any are we reliant on for resilience? (Do we have SLA’s / OLA’s in place?). Describe them.

## Scalability 

**InfoSec mandatory:** No

Describe the system scalability requirements – i.e. vertical / horizontal scaling, window of operation etc.
Describe how the system achieves the scalability requirements.

## Performance Testing

**InfoSec mandatory:** No

Has performance testing been completed or planned for this system design. Document the results.

## Session Handling

**InfoSec mandatory:** No

## Security (Authentication / Authorization)

**InfoSec mandatory:** Yes

Design for AD/ADFS/OAuth and RBAC etc.
  
## Architecture patterns or design patterns

**InfoSec mandatory:** No

List and/or reference design patterns or templates (including infra as code templates)

## Rules for using specific technology

**InfoSec mandatory:** No

Principal, often technical decisions of overall decisions

## Implementation rules and maintenance

**InfoSec mandatory:** No

Link to external developers guide where possible

## Exception/Error Handling

**InfoSec mandatory:** No

Describe the process of handling an processing errors

## Logging, Tracing

**InfoSec mandatory:** Yes, however for the first release, if under pressure, can be omitted.

Design your system so you can spot suspicious activity as it happens and take necessary action!

Ideally linking to a standard document describing patterns such as correlation ids etc.
Describe the logging and audit functionality – provide samples of audit log output for review

Does the system integrate with existing log management solutions (SecureWorks, ELK, Azure Log Analytics, 
Azure Security Centre etc.)

How are logs ingested Syslog, API, Agent, Other?

If no integration is possible describe how audit logging will be performed, retention periods adhered to 
(Minimum 12 months) and integrity of the log store maintained?

## Configurability

**InfoSec mandatory:** No

How and where the service/product/solution can be configured

##  Internationalization

**InfoSec mandatory:** No

Language support and configuration

## Migration

**InfoSec mandatory:** No

Details from previous solutions, including data ETL etc

## Testability

**InfoSec mandatory:** Yes, for security related aspects of the design.

links to acceptance tests (ideally written using BDD)

## Build-Management

**InfoSec mandatory:** No

links to build approach and standards if appropriate.

## DevOps - Separation of Duties

**InfoSec mandatory:** No

Separation of duties – who will be responsible for the various roles for this system / design / software?

**Form.**

The form can be varied:

- Entity-Relationship, Ontology, Graph, data model views

- References to Architectural standards. Such as X_Request_ID! Create
one if it does not exist!!

- cross-cutting model excerpts or scenarios using notations of the architecture views

- references/links to spikes/POC implementations, especially for technical concepts

- reference/links  to typical usage of standard frameworks (e.g. using )

## Concept 1

*\<explanation\>*

## Concept 2

*\<explanation\>*

## Concept n

*\<explanation\>*

# Design Decisions

**InfoSec mandatory:** Yes, for security related DD.

**Contents.**

Important, expensive, large scale, or risky architecture decisions
including rationale that has changed the design during implementation.

With \"decisions\" we mean selecting one alternative based on given criteria.

Avoid redundancy. Where you have already captured the most important decisions of
your architecture blueprint.

[ADR](https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions)

**Motivation.**

Stakeholders of your system should be able to comprehend and retrace
your decisions.

One of the hardest things to track during the life of a project is the motivation behind certain decisions. A new person coming on to a project may be perplexed, baffled, delighted, or infuriated by some past decision. Without understanding the rationale or consequences, this person has only two choices:

Blindly accept the decision.

This response may be OK, if the decision is still valid. It may not be good, however, if the context has changed and the decision should really be revisited. If the project accumulates too many decisions accepted without understanding, then the development team becomes afraid to change anything and the project collapses under its own weight.

Blindly change it.

Again, this may be OK if the decision needs to be reversed. On the other hand, changing the decision without understanding its motivation or consequences could mean damaging the project's overall value without realizing it. (E.g., the decision supported a non-functional requirement that hasn't been tested yet.)

It's better to avoid either blind acceptance or blind reversal.

Significant ADRs that have a material impact to an approved bluepring must be reviewed and approved by the Architecture Review Board.

**Form.**

- ADR (architecture decision record) for every important decision

A table linking to design decision documents.

| ADR            | Status*                                     | Link to ARR |
|----------------|---------------------------------------------|-------------|
| \<ADR-1-Name\> | \<proposed-accepted-deprecated-superseded\> | \<Link-1\>  |
| \<ADR-2-Name\> | \<proposed-accepted-deprecated-superseded\> | \<Link-2\>  |

* A decision may be "proposed" if the project stakeholders haven't agreed with it yet, or "accepted" once it is agreed. If a later ADR changes or reverses a decision, it may be marked as "deprecated" or "superseded" with a reference to its replacement.

# Quality Requirements

**InfoSec mandatory:** No

**Content.**

This section contains all quality requirements as a 
[critical quality tree](https://www.lucidchart.com/blog/how-to-make-a-critical-to-quality-tree)
with scenarios. The most important ones should been described already in
section [quality goals](#quality-goals)

Optionally, here you can also capture quality requirements with lesser priority,
which will not create high risks when they are not fully achieved.

**Motivation.**

Since quality requirements will have a lot of influence on architectural
decisions you should know for every stakeholder what is really important
to them, concrete and measurable.

## Quality Tree

**InfoSec mandatory:** No

**Content.**

The quality tree (as defined in 
[ATAM -- Architecture Tradeoff Analysis](https://concisesoftware.com/architecture-tradeoff-analysis-method-atam/) 
Method with quality/evaluation scenarios as leaves.

**Motivation.**

The tree structure with priorities provides an overview for a sometimes
a large number of quality requirements.

**Form.**

The quality tree is a high-level overview of the quality goals and
requirements:

- tree-like refinement of the term \"quality\". Use \"quality\" or
 \"usefulness\" as a root

- a mind map with quality categories as main branches

In any case, the tree should include links to the scenarios of the
following section.

## Quality Scenarios

**InfoSec mandatory:** No

**Contents.**

A concrete set of (sometimes vague or implicit) quality requirements
using (quality) scenarios.

These scenarios describe what should happen when a stimulus arrives at
the system.

For architects, two kinds of scenarios are important:

- Usage scenarios (also called application scenarios or use case
  scenarios) describe the system's runtime reaction to a certain
  stimulus. This also includes scenarios that describe the system's
  efficiency or performance. Example: The system reacts to a user's
  request within one second.

- Change scenarios describe a modification of the system or of its
  immediate environment. Example: Additional functionality is
  implemented or requirements for a quality attribute change.

 **Motivation.**

Scenarios make quality requirements concrete and allow to more easily
measure or decide whether they are fulfilled.

It also describes the quality objectives and impact on Service Management.

Especially when you want to assess your architecture using methods like
ATAM you need to describe your quality goals (from section 1.2) more
precisely down to a level of scenarios that can be discussed and
evaluated.

**Form.**

Tabular or free form text.

# Standards Conformance

**InfoSec mandatory:** Yes, for security related standards

**Contents.**

A list of standards this design complies with. Ordered by importance.
New standards introduced should be highlighted as such and take highest
importance.

**Motivation.**

**Form.**

A table with columns \<Term\> and \<Definition\>.

Potentially more columns in case you need translations.

| Standard   | New   | Link to Standard |
| ---------- | ---------------- | ---------------- |
| \<Standard-Name-1\> | \<true|false\> | [Link](../../docs/standards/README.md) |
| \<Standard-Name-1\> | \<true|false\> | [Link](../../docs/standards/README.md) |

# Technical Risks and Technical Debt

**InfoSec mandatory:** No

**Contents.**

A list of identified technical risks or technical debts, ordered by
priority

**Motivation.**

"Risk management is project management for grown-ups" (Tim Lister,
Atlantic Systems Guild.)

This should be your motto for systematic detection and evaluation of
risks and technical debts in the architecture, which will be needed by
management stakeholders (e.g. project managers, product owners) as part
of the overall risk analysis and measurement planning.

**Form.**

List of risks and/or technical debts, probably including suggested
measures to minimize, mitigate or avoid risks or reduce technical debts.

# Decommissioning

**InfoSec mandatory:** No

Please provide information on any hardware or software components that will be retired and decommissioned.   
Please confirm whether decommissioning is in or out of scope for the project/solution by ensuring that
these are linked [Requirements](#requirements-overview)

# Information Security

**InfoSec mandatory:** Yes

@TODO Link to new Risk Assessment and Control Template.

## Data Privacy Impact Assessment (DPIA)

**InfoSec mandatory:** Yes

**Contents.**

When the project/solution involves introducing new personal data processing or changes how existing processing is done, it is mandatory that the Project Manager considers the privacy implications of the change and follows the Data Privacy Impact Assessment (DPIA) process. Please complete Part A (can be accessed here).

Should Part B be required, then this must be included in TDD Pt II.  
Include the completed DPIA ServiceNow ticket number.

**Motivation.**

**Form.**


# Supporting Strategy

**InfoSec mandatory:** No

| A&O Strategy (Technical Strategy gains / Etc) | Other (Technical Debt)          |
|-----------------------------------------------|---------------------------------|
| {Simplification\Data\Etc} {description}       | {description of technical debt} |

# Glossary

**InfoSec mandatory:** No

**Contents.**

The most important domain and technical terms that your stakeholders use
when discussing the system.

You can also see the glossary as a source for translations if you work in
multi-language teams.

**Motivation.**

You should clearly define your terms so that all stakeholders

- have an identical understanding of these terms

- do not use synonyms and homonyms

**Form.**

A table with columns \<Term\> and \<Definition\>.

Potentially more columns in case you need translations.

| Term       | Definition       |
| ---------- | ---------------- |
| \<Term-1\> | \<definition-1\> |
| \<Term-2\> | \<definition-2\> |
