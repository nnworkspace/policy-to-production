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

## What is linting?

In this project, **linting** serves as an **automated compliance check**.

Just as a spell-checker automatically identifies errors in a document, a "linter" scans every file in the project to ensure it strictly adheres to our governance, security, and traceability rules.

This replaces manual policing with instant, mechanical enforcement. It ensures that complex compliance requirements are met continuously, rather than being discovered only during an audit.

## Purpose

This document defines the **automated governance rules** enforced by the CI/CD pipeline. These rules ensure that the project's classification, traceability, and versioning strategies are applied consistently.

These rules are **normative** and derive directly from the [Artefact Classification Model](artefact-classification.md) and [Configuration Management Strategy](configuration-management.md).

## Enforcement Principles

1.  **Fail Fast:** Violations are detected immediately in the pipeline.
2.  **Explicit:** All metadata must be declared, never inferred.
3.  **Deterministic:** A rule either passes or fails; ambiguity is treated as failure.
4.  **Constructive Feedback:** Linting output must be **precise and actionable**. It must explain *what* is wrong and *how* to fix it, treating validation errors as guidance rather than blame.

---

## Rule Definitions

### A. Classification & Form

| ID | Rule Name | Level | Requirement |
| :--- | :--- | :--- | :--- |
| **LINT-C1** | Mandatory classification | **MUST** | Every artefact must declare classification metadata. |
| **LINT-C2** | Single source | **MUST** | Classification must be declared in exactly one place (inline OR sidecar), never both. |
| **LINT-C3** | Valid values | **MUST** | All metadata values must match the allowed list in the Artefact Classification Model. |
| **LINT-F1** | Textual form | **MUST** | Artefacts of form `TEXT` or `SOURCE` must use **inline** metadata. |
| **LINT-F2** | Binary form | **MUST** | Artefacts of form `BINARY` or `SERVICE` must use **sidecar** metadata (`.meta.yaml`). |

### B. Traceability & Versioning

| ID | Rule Name | Level | Requirement |
| :--- | :--- | :--- | :--- |
| **LINT-T1** | Implementation trace | **MUST** | `IMPLEMENTATION` artefacts must reference at least one `SPECIFICATION`. |
| **LINT-T2** | Spec anchoring | **MUST** | `SPECIFICATION` artefacts must reference at least one `RULE` or `LEGAL` source. |
| **LINT-T3** | Test coverage | **MUST** | `SPECIFICATION` artefacts must be referenced by at least one `TEST` artefact. |
| **LINT-T4** | **Version-aware syntax** | **MUST** | References to governed Sets must include the version suffix (e.g., `@spec=SPEC-SET-ONB:1.2.0`). |
| **LINT-T5** | **Spec Drift detection** | **SHOULD** | Referenced versions should match the current `RELEASED` version in the target's `manifest.yaml`. Mismatches trigger a warning. |

### C. Visibility & Justification

| ID | Rule Name | Level | Requirement |
| :--- | :--- | :--- | :--- |
| **LINT-V1** | Visibility monotonicity | **MUST** | An artefact must **not** depend on another artefact with more restrictive visibility (e.g., `PUBLIC` cannot depend on `CONFIDENTIAL`). |
| **LINT-V2** | Binary justification | **MUST** | `BINARY` artefacts must reference a document explaining why source code is not provided. |

### D. API Specification (OpenAPI)

| ID | Rule Name | Level | Requirement |
| :--- | :--- | :--- | :--- |
| **LINT-API-01** | Operation traceability | **MUST** | Every API operation must reference a Specification ID. |
| **LINT-API-02** | Non-empty references | **MUST** | Specification reference blocks must not be empty. |
| **LINT-API-03** | Reference validity | **MUST** | Referenced specification IDs must exist in the project. |

### E. Hygiene

| ID | Rule Name | Level | Requirement |
| :--- | :--- | :--- | :--- |
| **LINT-H1** | Audience declaration | **SHOULD** | Every artefact should explicitly declare its target audience. |
| **LINT-H2** | Orphan detection | **SHOULD** | Artefacts not referenced by any other artefact should be flagged for review. |

---

## Linting Feedback

Automation output must be actionable.

**Example Failure:**
> ❌ **LINT-T4 Violation** in `ONB-TS-01.feature`:
> Reference `@spec=SPEC-SET-ONB` is missing version suffix.
> **Fix:** Update to `@spec=SPEC-SET-ONB:1.0.0` to match the target manifest.


## Final note

Linting is not bureaucracy.

It is the mechanical expression of judgement, ensuring that discipline is applied consistently as the system evolves.

