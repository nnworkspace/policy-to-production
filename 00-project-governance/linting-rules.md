---
artefact_type: governance
visibility: public
audience: everyone
form: text
role: governance
status: normative
owner: project-governance
---

# Linting Rules

## Purpose

This document defines the **linting rules** enforced in this repository.

Linting exists to ensure that the project’s governance principles are **applied consistently and mechanically**, rather than relying on manual policing or informal conventions.

Linting rules enforce:

* artefact classification discipline
* traceability from policy to production
* visibility and access boundaries
* structural coherence across artefacts

Linting does **not** judge business logic or implementation quality. Its role is governance, not optimisation.

---

## Relationship to other documents

These rules are normative.

They derive directly from, and must be read together with:

* `docs/artefact-classification.md`

If a conflict appears to exist, the Artefact Classification Model takes precedence.

---

## General principles

1. **Explicit over implicit**
   All required information must be declared, not inferred.

2. **Deterministic enforcement**
   A rule either passes or fails. Ambiguity is treated as failure.

3. **Fail fast**
   Violations are detected as early as possible in CI.

4. **Explain, do not shame**
   Linting feedback must be precise and actionable.

---

## Rule groups

Linting rules are grouped by intent:

* Classification rules
* Form consistency rules
* Traceability rules
* Visibility rules
* Hygiene rules

Rules marked **MUST** are hard failures.
Rules marked **SHOULD** may initially be warnings and later upgraded.

---

## A. Classification rules

### LINT-C1 — Mandatory classification

**MUST**: Every artefact must declare classification metadata.

* Textual artefacts: inline classification
* Non-textual artefacts: sidecar metadata

Artefacts without classification are rejected.

---

### LINT-C2 — Single source of classification

**MUST**: An artefact must declare classification in exactly one place.

* Inline **or** sidecar
* Never both
* Never neither

---

### LINT-C3 — Valid classification values

**MUST**: All classification fields must use values defined in the Artefact Classification Model.

Ad-hoc or misspelled values are rejected.

---

## B. Form consistency rules

### LINT-F1 — Textual artefacts

**MUST**: Artefacts of form `TEXT` or `SOURCE` must:

* declare classification inline
* not have sidecar metadata files

---

### LINT-F2 — Non-textual artefacts

**MUST**: Artefacts of form `BINARY` or `SERVICE` must:

* declare classification via sidecar metadata
* not declare inline classification

---

## C. Traceability rules

### LINT-T1 — Implementation traceability

**MUST**: Every artefact with role `IMPLEMENTATION` must reference at least one artefact with role `SPECIFICATION`.

This applies to:

* source code
* binaries (via metadata)
* services

---

### LINT-T2 — Specification anchoring

**MUST**: Every artefact with role `SPECIFICATION` must reference at least one artefact with role `RULE` or `LEGAL`.

Specifications without mandate are rejected.

---

### LINT-T3 — Test coverage

**MUST**: Every artefact with role `SPECIFICATION` must be referenced by at least one artefact with role `TEST`.

This enforces acceptance discipline, not test completeness.

---

## D. Visibility rules

### LINT-V1 — Visibility monotonicity

**MUST NOT**: An artefact may not reference another artefact with more restrictive visibility.

Examples:

* `PUBLIC` → `RESTRICTED` ❌
* `PUBLIC` → `CONFIDENTIAL` ❌
* `RESTRICTED` → `CONFIDENTIAL` ❌

Allowed:

* `CONFIDENTIAL` → `RESTRICTED` or `PUBLIC`
* `RESTRICTED` → `PUBLIC`

---

### LINT-V2 — Binary justification

**MUST**: Every artefact with form `BINARY` must reference at least one artefact explaining why binary delivery is required.

Justification may reference:

* security constraints
* platform requirements
* contractual obligations

---

## E. Hygiene rules

### LINT-H1 — Audience declaration

**SHOULD**: Every artefact should declare at least one audience.

Initially a warning; may become a hard requirement.



### LINT-H2 — Orphan artefacts

**SHOULD**: Artefacts not referenced by any other artefact should be reviewed.

This helps identify:

* obsolete documents
* dead code
* abandoned deliverables

## API specification linting rules

The following rules apply to OpenAPI specifications:

- LINT-API-01 — Every operation must reference at least one specification ID
- LINT-API-02 — Spec reference blocks must not be empty
- LINT-API-03 — Referenced spec files should exist
- LINT-API-04 — Spec IDs should follow defined conventions


## Linting feedback

Linting feedback must:

* identify the violated rule
* name the artefacts involved
* explain why the violation matters
* describe how to resolve it

Example:

> LINT-V1 violation: PUBLIC artefact `architecture/overview.md` references CONFIDENTIAL artefact `offline/secure-element-spec.md`. PUBLIC artefacts may not depend on more restrictive artefacts.

---

## Final note

Linting is not bureaucracy.

It is the mechanical expression of judgement, ensuring that discipline is applied consistently as the system evolves.


