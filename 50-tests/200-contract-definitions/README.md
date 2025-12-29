---
artefact_type: evidence
visibility: public
audience: everyone
form: text
role: evidence
status: informative
owner: system-quality
---

# Contract Definitions (Interface Assurance)

This folder contains **contract definitions** that express **interface-level assurances** for the system.

Contract definitions specify what is allowed and what is forbidden at **system boundaries**, independent of any particular backend implementation or test runner.

They are the authoritative source for validating that interfaces conform to the specifications.


## Purpose

In complex, multi-stakeholder systems, many failures occur not because business logic is wrong, but because **interfaces drift**:

- payloads change subtly,
- required fields become optional,
- error semantics diverge,
- compatibility assumptions break across vendors.

Contract definitions exist to prevent this class of failure.

They answer the question:

> *“Does this interface still conform to the specification?”*


## Scope

Contract definitions in this folder typically cover:

- request and response schemas
- required vs optional fields
- data type constraints
- structural invariants
- error object formats
- versioning and compatibility rules

They apply to:
- APIs exposed between components
- APIs exposed to external integrators (e.g. PSPs)
- shared message or data models

They do **not** describe:
- business workflows,
- sequencing of calls,
- performance characteristics,
- or security policy enforcement.


## Format

Contract definitions are expressed in **machine-readable schema formats**,
such as:

- JSON Schema
- PACT-style contract definitions

These formats are chosen because they are:

- precise and unambiguous,
- directly enforceable by automation,
- tool-agnostic at the conceptual level.


## Organisation

This folder is organised by **domain or feature**, mirroring the structure used in specifications and conformance scenarios.

Typical subfolders include:

- `common/`  
  Shared types and models used across multiple interfaces (e.g. error structures, identifiers, pagination).

- feature-specific folders (e.g. `onboarding/`)  
  Interface contracts relevant to a particular capability.

This structure supports:
- reuse without duplication,
- clear ownership,
- and incremental evolution.

## Traceability

Each contract definition MUST be traceable to:

- one or more **specification identifiers**,
- the **exact version** of those specifications,
- the interfaces it constrains,
- and the features that rely on it.

Traceability in this project is **version-aware by design**. Traceability without versioning is treated as incomplete and non-auditable.

A reference to an upstream artefact is only meaningful when the **specific version of that artefact** is known. This ensures that:

- historical conformance can be audited,
- past decisions remain intelligible,
- and changes in specifications do not silently invalidate existing assurance.

Contract definitions therefore trace to upstream artefacts using both **identifier** and **version**, not identifier alone.

This enables:

- automated detection of contract–spec drift,
- impact analysis when a new specification version is introduced,
- and reproducible assurance results over time.

## Relationship to other assurance artefacts

Contract definitions are complementary to other assurance categories:

- **Conformance scenarios (`100-conformance-scenarios/`)**  
  Validate *behaviour* across interfaces and components.

- **Security scenarios (`300-security/`)**  
  Validate *who* may invoke interfaces and under what conditions.

- **Operational assurances (`400-operational/`)**  
  Validate *how well* interfaces behave under load or failure.

- **Test vectors (`900-test-vectors/`)**  
  Provide canonical data used to exercise schema constraints.

Together, these artefacts ensure that interfaces are:
- correct,
- stable,
- and fit for long-term interoperability.


## Intent

The intent of this folder is to make interface correctness **explicit, verifiable, and durable**.

By separating interface contracts from behaviour and tooling, the system gains:

- clearer governance,
- stronger interoperability guarantees,
- and lower long-term integration risk.

---

## Disclaimer

The contract definitions in this folder are **illustrative and educational**.

They demonstrate how interface assurances may be expressed in a complex institutional project. They do not represent official API contracts or binding specifications for the Digital Euro or any other real system.


