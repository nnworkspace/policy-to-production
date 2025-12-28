---
artefact_type: specification
visibility: public
audience: everyone
form: text
role: specification
status: informative
owner: system-architecture
---

# Onboarding Specifications — Folder Map

This folder contains the **participant onboarding specification set**.

Each file has a distinct role. Together they form a complete, layered specification.

## Files in this folder

### `onboarding-specification-overview.md`
Provides **scope, intent, and traceability context** for the onboarding specification set.

This file explains:
- why these specifications exist
- how they relate to rulebooks and architecture
- how they are intended to be used downstream

### `onboarding-functional-spec.md`
Defines **what must happen** during participant onboarding.

- lifecycle states and transitions
- functional rules and constraints
- scheme-level obligations

### `onboarding-interfaces-spec.md`
Defines **how system components interact** to realise onboarding.

- responsibilities of intermediaries and platform components
- interaction flows
- error handling and idempotency rules

### `onboarding-data-model-spec.md`
Defines the **logical data model** required to support onboarding.

- authoritative participant entity
- lifecycle-related data
- verification and audit records
- privacy-preserving constraints


## Disclaimer

The specifications contained in this folder are **illustrative and educational**.

They are **not** official Digital Euro specifications and **do not represent**:
- an ECB position,
- a Eurosystem design decision,
- or any agreed technical implementation.

All content is derived from **publicly available information** (e.g. scheme rulebooks, policy documents) and from **reasonable technical assumptions** made solely for the purpose of demonstrating methodology, structure, and traceability.

No confidential, proprietary, or insider information is included.

These documents exist to show *how* complex institutional requirements **could be structured, governed, and automated** — not *what* the Digital Euro system will implement.

Readers should not interpret this material as normative or binding for any real Digital Euro project.



