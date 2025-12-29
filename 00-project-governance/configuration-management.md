---
artefact_type: governance
visibility: public
audience: everyone
form: text
role: governance
status: normative
owner: project-governance
---

# Configuration Management and Versioning

## Purpose

This document defines the **Configuration Management Strategy** for the project.

It establishes how the project creates, identifies, and maintains **auditable baselines** across its diverse artefacts.

Its purpose is to ensure that:

- the state of the system at any past moment is retrievable
- specifications and tests remain synchronised
- dependencies between artefacts are explicit and version-aware
- auditors can verify the exact definition of a release

## The Philosophy: Atomic Baselines

In a rigorous institutional project, **individual file versioning is considered an anti-pattern**.

Trying to track whether "Functional Spec v1.2" is compatible with "Data Model v1.4" creates a combinatorial explosion of uncertainty.

Instead, this project adopts the **Atomic Baseline** strategy:

> **We do not version files. We version Sets.**

A **Set** (or Product) is a coherent collection of files—usually a specific folder—that is released, referenced, and governed as a single unit.

## Scope and Versioning Mechanisms

Different artefact types require different versioning mechanisms to align with their respective toolchains.

| Artefact Domain | Mechanism | Granularity | Traceability Handle |
| :--- | :--- | :--- | :--- |
| **Governance & Rules** (`00`, `20`) | **Manifest File** | Folder (Domain) | `GOV-SET:1.0.0` |
| **Architecture** (`30`) | **Manifest File** | Folder (System) | `ARCH-SET:2.1.0` |
| **Specifications** (`40`) | **Manifest File** | Folder (Feature) | `SPEC-SET-ONB:1.2.0` |
| **Source Code** (`50`) | **Git Tags / SemVer** | Repository / Component | `mvn:eu.eurosystem:desp-core:1.2.0` |
| **Tests & Evidence** (`60`) | **Git Tags** | Repository | 'TEST-SET-ONB:1.2.0' |

## The Manifest System

For documentation-heavy domains (Governance, Rulebook, Specifications), we utilise a **Manifest File** (`manifest.yaml`) to define the version.

This file acts as the **Single Source of Truth** for the folder's version. Individual Markdown files within the folder **inherit** this version and must not declare their own.

### Manifest Schema

The manifest MUST be placed at the root of the released folder.

```yaml
# artefact_type: governance
# role: manifest

meta:
  # Unique Identifier for this Set (The "Product ID")
  id: <ID>
  
  # Human-readable title
  title: <TITLE>
  
  # The Normative Version (Semantic Versioning)
  version: <MAJOR.MINOR.PATCH>[-<PRE-RELEASE>]
  
  # The Lifecycle State
  status: <DRAFT | RELEASED | DEPRECATED>
  
  # The Freeze Date (ISO 8601)
  date: <YYYY-MM-DD>

# The explicit list of files that constitute this release
contains:
  - <FILENAME>
  - <FILENAME>
```

**Example: Onboarding Specification Manifest**

**Location:** `40-specifications/onboarding/manifest.yaml`

```yaml
meta:
  id: SPEC-SET-ONB
  title: "Participant Onboarding Specification Set"
  version: "0.1.0"
  status: FICTIONAL
  date: 2025-12-29

contains:
  - onboarding-spec-overview.md 
  - onboarding-functional-spec.md
  - onboarding-interfaces-spec.md
  - onboarding-data-model-spec.md
  - openapi.yaml
```

## Lifecycle States

Every versioned Set exists in one of three states:

### 1. DRAFT (Snapshot)

- **Version Suffix:** `-DRAFT` or `-SNAPSHOT` (e.g. `1.3.0-DRAFT`)
- **Immutability:** No. Content changes frequently.
- **Usage:** Development, internal review, work-in-progress testing.
- **Traceability:** Downstream artefacts may reference `LATEST` or the specific draft version, but risk instability.

### 2. RELEASED
- **Version Suffix:** None (e.g. `1.3.0`)
- **Immutability:** **Strict.** Once a manifest is marked `RELEASED`, the content of the folder **MUST NOT** change.
- **Correction:** Any change, even a typo fix, requires a new version (e.g. `1.3.1`).
- **Usage:** Formal audit, binding implementation, contract signing.

### 3. FICTIONAL-RELEASED
- **Version Suffix:** `-FICTIONAL` (e.g. `1.0.0-FICTIONAL`)
- **Immutability:** Strict.
- **Usage:** Educational demonstration and public samples.
- **Disclaimer:** Explicitly indicates that while the artefact is technically complete and rigorous, it is **not an official release from the ECB** and carries no legal or operational weight.

### 4. DEPRECATED
- **Usage:** The artefact is valid but superseded. New implementations should not use it.



## Traceability and Dependencies

Traceability in this project is **version-aware**.

A downstream artefact (like a Test) does not merely reference a Specification; it references a **specific version** of that Specification Set.

### Declaration Format

Downstream artefacts MUST declare their dependencies using the format:
`@<TYPE>=<ID>:<VERSION>`

#### Example: Gherkin Test Scenario

```gherkin
# Location: 50-tests/100-conformance/onboarding/ONB-TS-01.feature

# -----------------------------------------------------------
# DEPENDENCY: SPEC-SET-ONB
# VERSION:    0.1.0  <-- This test validates exactly v0.1.0
# -----------------------------------------------------------

@spec=SPEC-SET-ONB:0.1.0
Feature: Participant Onboarding Submission
...
```

### The "Drift" Rule

Automation or Audit processes MUST flag any mismatch where:
1.  A Test references `SPEC-SET-ONB:1.2.0`
2.  But the actual Manifest in `40-specifications/onboarding/` is `1.3.0`

This indicates **Spec Drift**: The specification has moved forward, but the test has not yet been updated to verify the new rules.

## Folder Structure and Granularity

To balance rigour with manageability, manifests are applied at the **Product Boundary**.

```text
policy-to-production/
├── 00-project-governance/
│   └── manifest.yaml             # Version: 1.0.0 (Governance is one unit)
│
├── 20-rulebook/
│   └── manifest.yaml             # Version: 2.1.0 (Rulebook is one unit)
│
├── 40-specifications/
│   ├── onboarding/
│   │   └── manifest.yaml         # Version: 1.2.0 (Atomic Feature Release)
│   │
│   └── liquidity-reservation/
│       └── manifest.yaml         # Version: 0.9.0 (Atomic Feature Release)
│
└── 50-code/                      # Standard Git/Maven versioning
```

## Summary

A civilised system requires a shared understanding of time and state.

By versioning **Sets** rather than files, and by enforcing **version-aware traceability**, we ensure that the project remains auditable, coherent, and reconstructible at any point in its history.

