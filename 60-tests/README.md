---
artefact_type: evidence
visibility: public
audience: everyone
form: text
role: evidence
status: informative
owner: system-quality
---

# System Tests and Evidence

This folder contains **system-level tests, acceptance criteria, and assurance artefacts** derived from the project’s specifications.

It exists to demonstrate — in a structured and auditable way — that the system behaves as intended **across components** and **over time**.

This is not a collection of unit tests or framework-level test suites. It is an **evidence layer**.


## Purpose

In complex institutional systems, correctness is not established by isolated component tests alone.

What ultimately matters is that:

- specifications are respected,
- system-wide invariants hold,
- security boundaries are enforced,
- non-functional guarantees are met,
- and evidence of these properties can be produced when required.

This folder provides that evidence.

---

## What belongs in this folder

The artefacts in this folder describe **what must be true of the system**.

They typically cover:

- **End-to-end acceptance tests**  
  Validating complete flows (e.g. onboarding lifecycle) across multiple components.

- **Cross-component integration tests**  
  Verifying interactions between Access Gateway, DESP, auxiliary services, and PSP systems.

- **Contract and interface tests**  
  Ensuring externally exposed APIs conform to specifications and constraints.

- **Invariant checks**  
  Asserting properties that must always hold (e.g. no double reservation, valid lifecycle order).

- **Smoke tests**  
  Minimal system readiness checks used after deployment or configuration changes.

- **Security assurances**  
  Behavioural guarantees such as authentication enforcement, authorisation rules, and audit event generation.

- **System-level performance expectations**  
  Latency, throughput, and degradation guarantees expressed as assertions, not as tool-specific benchmarks.

These artefacts may be implemented as automated tests, manual procedures, simulations, or derived reports. The key requirement is that they are **traceable to specifications**.


## What does not belong in this folder

The following do **not** belong here and should live close to the code instead:

- unit tests,
- component-internal integration tests,
- framework or library tests,
- micro-benchmarks or tuning experiments,
- tool-specific load or penetration testing scripts.

Those are implementation concerns.
This folder is concerned with **system behaviour and assurance**.


## Claims, evidence, and tools

Artefacts in this folder are organised around **claims** and **evidence**, not around specific testing tools.

A typical verification artefact expresses:

- a claim about system behaviour (e.g. a security or performance guarantee),
- the conditions under which the claim must hold,
- the types of evidence that are acceptable to substantiate it.

The **tools used to produce that evidence** — such as load-testing frameworks,
security scanners, or custom scripts — are deliberately treated as interchangeable
implementation details.

Tool-specific artefacts are therefore not stored here. They may live in component repositories, vendor environments, or secured CI/CD pipelines.

This distinction is intentional:

- tools change,
- environments change,
- vendors change,

but the **claims the system makes about itself must remain explicit, stable, and auditable**.

By separating claims from tooling, this folder enables:

- independent verification,
- vendor-neutral assurance,
- secure handling of sensitive test configurations,
- and long-term auditability without exposing internal attack surfaces.


## Specifications vs verification artefacts

It is also important to distinguish clearly between **specifications** and the artefacts stored in this folder.

Specifications describe **what the system must do**.
They define intent, behaviour, and constraints, independent of how compliance is demonstrated.

The artefacts in this folder do something different.
They describe **how confidence is established** that the specifications are being met.

In other words:

- specifications state *what must be true*,
- verification artefacts state *how we know it is true*.

For this reason, verification artefacts are intentionally **not part of the specification layer**.
They sit downstream, translating normative intent into concrete, testable claims.

This separation allows specifications to remain stable and timeless,
while verification methods can evolve as tools, environments, and risk profiles change.

## Relationship to specifications

Every artefact in this folder SHOULD reference one or more specification identifiers from the `40-specifications/` layer.

This establishes a clear chain:

> **Specification → Test / Evidence → Report**

Automation may enforce this relationship.


## Relationship to CI/CD and reports

Tests and evidence defined here are typically:

- executed or validated by CI/CD pipelines,
- summarised into higher-level reports,
- consumed by engineers, architects, auditors, and executives.

The `70-reports/` folder contains **derived views** of this evidence. This folder contains the **source assertions**.

## A note on tone and intent

This folder is intentionally technology-agnostic.

Its purpose is not to prescribe *how* to test, but to make explicit **what claims are being made about the system** and **how those claims can be justified**.

In institutional projects, this clarity is often more valuable than any single test framework.


## Disclaimer

The contents of this folder are **illustrative and educational**.

They demonstrate how system-level assurance and traceability could be organised in a complex, multi-stakeholder project. They do not represent official test suites or audit requirements for the Digital Euro or any other real system.



