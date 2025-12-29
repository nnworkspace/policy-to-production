---
artefact_type: evidence
visibility: public
audience: everyone
form: text
role: evidence
status: informative
owner: system-quality
---

# Conformance Scenarios

This folder contains **conformance scenarios** that express **system-level behavioural assurances** in an executable, human-readable form.

Conformance scenarios encode *claims about system behaviour* as concrete scenarios that can later be executed by automation tools, without binding the project to a specific test runner or framework.

## Purpose

Conformance scenarios serve as the bridge between:

- **normative intent** (rules and specifications), and
- **executable assurance** (automated system verification).

They answer the question:

> *“Given the rules and specifications, how should the system behave in a concrete, observable situation?”*


## Scope

Scenarios in this folder focus on **feature-level and cross-component behaviour**.

They typically cover:

- end-to-end business flows (e.g. onboarding, liquidity reservation),
- interactions across multiple components,
- expected system responses under normal and exceptional conditions.

They do **not** describe:
- component-internal logic,
- performance or availability guarantees,
- or implementation-specific details.

## Format

Scenarios are written in **Gherkin (`.feature`) format**.

This format is chosen because it is:

- readable by non-engineers,
- widely understood in industry,
- and supported by multiple execution frameworks.

However, the scenarios are intentionally written to remain **agnostic of any specific test runner** (e.g. Cucumber, Behave, SpecFlow).

For a detailed guide on the grammar and syntax used herein:

- [**The Gherkin Reference**](https://cucumber.io/docs/gherkin/reference/)

## Traceability

Each conformance scenario SHOULD declare, in its header comments:

- one or more **specification identifiers** it derives from,
- the **exact version** of each referenced specification,
- the **feature or capability** it covers,
- and a unique **assurance identifier**.

Traceability in this project is **version-aware by design**. A reference to a specification is only meaningful when the specific version of that specification is known.

This enables:

- automated, version-aware traceability checks,
- coverage analysis across specification versions,
- reproducible assurance results over time,
- and clear linkage to reports and audits.



## Relationship to other assurance artefacts

Conformance scenarios are one part of a broader assurance model:

- **Contract definitions** (`200-contract-definitions/`)  
  Provide machine-checkable interface constraints that scenarios rely on when invoking APIs or validating responses.

- **Test vectors** (`900-test-vectors/`)  
  Provide canonical inputs and expected outputs used by scenarios to validate invariants and interoperability.

Together, these artefacts provide complementary views of system assurance.


## Intent

The intent of this folder is not to prescribe *how* tests are implemented, but to make system behaviour **explicit, reviewable, and executable**.

By expressing assurance as scenarios rather than code, this folder supports collaboration across disciplines while remaining ready for automation as the system matures.


## Disclaimer

The scenarios in this folder are **illustrative and educational**.

They demonstrate how conformance scenarios may be structured in a complex institutional project. They do not represent official conformance tests or certification criteria for the Digital Euro or any other real system.


