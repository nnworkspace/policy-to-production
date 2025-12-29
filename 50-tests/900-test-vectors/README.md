---
artefact_type: evidence
visibility: public
audience: everyone
form: text
role: evidence
status: informative
owner: system-quality
---

# Test Vectors (Invariant Data)

This folder contains **test vectors**: canonical data sets used to verify **invariants and interoperability properties** of the system.

Test vectors are **data**, not executable tests. They provide stable reference inputs and expected outputs that can be consumed by multiple implementations, test frameworks, and assurance scenarios.


## Purpose

In multi-vendor and multi-component systems, correctness often fails not because logic is wrong, but because **assumptions about data diverge**.

Test vectors exist to eliminate ambiguity by providing a shared, authoritative reference for:

- valid and invalid inputs,
- boundary conditions,
- canonical representations,
- and expected outcomes for invariant checks.

They answer the question:

> *“Given the same input data, do all implementations behave consistently?”*

## Scope

Test vectors typically cover:

- canonical identifiers and formats
- boundary values and edge cases
- cryptographic reference values
- lifecycle state combinations
- error and rejection cases
- interoperability reference datasets

They are intentionally **feature-agnostic where possible**, but may be grouped by feature or domain when necessary.


## Organisation

This folder is organised by **feature or domain**:

```text
900-test-vectors/
├── onboarding/
├── liquidity-reservation/
└── ...
```

## Format

Test vectors are stored in **simple, widely supported data formats**, such as:

- JSON
- CSV

These formats are chosen to ensure that vectors are:

- easy to inspect and review,
- stable under version control,
- consumable by a wide range of tooling.

Vectors MUST NOT embed executable logic.

## Traceability

Each test vector set SHOULD be traceable to:

- the **specification identifier(s)** that define the invariant,
- the **exact version** of each referenced upstream artefact,
- and the assurance sets that consume the vector.

Traceability is **version-aware by design**.

This allows vectors to be:

- audited historically,
- reused safely across versions,
- and updated without breaking existing assurance baselines.

## Relationship to other assurance artefacts

Test vectors are consumed by other assurance categories:

- **Conformance scenarios (`100-conformance-scenarios/`)**  
  Use vectors as inputs to validate feature behaviour.

- **Security assurance (`300-security/`)**  
  Use vectors to test rejection paths and abuse cases.

- **Operational assurance (`400-operational/`)**  
  Use vectors to exercise boundary conditions under load.

Test vectors themselves do not assert behaviour; they enable other artefacts to do so consistently.

## What does not belong in this folder

The following do **not** belong here:

- executable test scripts,
- assertions or test logic,
- framework-specific fixtures,
- environment-specific data.

Those artefacts belong in test execution environments or component-level repositories.

This folder contains **authoritative reference data only**.

## Intent

The intent of this folder is to make **data-level assumptions explicit** and to ensure interoperability across implementations.

By governing invariant data separately from behaviour and tooling, the system gains:

- stronger consistency guarantees,
- clearer audit trails,
- and lower long-term integration risk.

## Disclaimer

The contents of this folder are **illustrative and educational**.

They demonstrate how invariant test data might be governed in a complex institutional project. They do not represent official reference datasets for the Digital Euro or any other real system.



