---
artefact_type: specification
visibility: public
audience: everyone
form: text
role: specification
status: normative
owner: system-architecture
---

# Participant Onboarding — Data Model Specification

## Purpose

This document defines the **logical data model** for participant onboarding
used by the Digital Euro Service Platform (DESP).

It specifies the **minimum authoritative data** required to:

- support the onboarding lifecycle,
- enforce scheme rules,
- enable auditability,
- and realise the onboarding APIs.

This data model is **illustrative**, not an official ECB schema.

---

## Normative context

This specification derives from:

- the Digital Euro Scheme Rulebook (roles, obligations, lifecycle intent)
- Participant Onboarding — Functional Specification
- Participant Onboarding — Interface Behaviour Specification

Where the rulebook is silent, this model applies **conservative, privacy-preserving defaults**.

---

## Design principles

### DM-G-01 — Minimal authority

DESP stores **only authoritative platform data**.

It MUST NOT store:
- real-world identities,
- customer KYC documents,
- personal identifiers.

Those remain the responsibility of PSPs.

---

### DM-G-02 — Lifecycle-first modelling

All participant data MUST be attributable to a **well-defined lifecycle state**.

Lifecycle states and transitions are defined upstream in the onboarding specifications.

---

### DM-G-03 — Separation of concern

The data model distinguishes between:

- **identity references** (opaque, hashed, or pseudonymised),
- **operational status** (lifecycle),
- **audit metadata** (who, when, why).

---

## Core entity: Participant

### Logical definition

A **Participant** represents a supervised intermediary
that is authorised (or in the process of being authorised)
to participate in the digital euro scheme.

---

### Participant entity

| Field | Type | Description |
|------|------|-------------|
| `participant_id` | String | Globally unique identifier assigned by DESP |
| `psp_id` | String | Identifier of the PSP responsible for onboarding |
| `state` | Enum | Current lifecycle state |
| `created_at` | Timestamp | Creation time |
| `updated_at` | Timestamp | Last state change |
| `version` | Integer | Optimistic concurrency / audit version |

---

## Onboarding Lifecycle state

The onboarding lifecycle consists of the following states:
`DRAFT → SUBMITTED → VERIFIED → ACTIVE`

### State definitions

- **DRAFT**  
  The participant record exists but is incomplete.  
  No validation or verification has occurred.

- **SUBMITTED**  
  The participant has formally submitted onboarding information for verification.  
  Data is immutable except through explicit correction flows.

- **VERIFIED**  
  All mandatory checks and certifications have been completed successfully.  
  The participant is eligible for activation.

- **ACTIVE**  
  The participant is authorised to operate within the Digital Euro system.

State transitions are strictly controlled and auditable.


## Verification record

### Purpose

Captures the **fact of verification** without storing verification evidence.

---

### Verification entity

| Field | Type | Description |
|------|------|-------------|
| `verification_id` | String | Unique identifier |
| `participant_id` | String | Associated participant |
| `verified_by` | String | Authority or role performing verification |
| `verified_at` | Timestamp | Verification timestamp |
| `result` | Enum | `APPROVED` / `REJECTED` |
| `remarks` | String (optional) | Non-sensitive notes |

---

## Audit metadata

### Purpose

Ensures auditability **without exposing confidential content**.

---

### Audit event

| Field | Type | Description |
|------|------|-------------|
| `event_id` | String | Unique event identifier |
| `participant_id` | String | Affected participant |
| `event_type` | Enum | CREATE, SUBMIT, VERIFY, ACTIVATE |
| `performed_by` | String | Actor role (not personal identity) |
| `performed_at` | Timestamp | Event time |
| `source` | String | PSP Integration Layer / Access Gateway |

Audit events are **append-only**.

---

## Privacy considerations

- DESP data MUST NOT be sufficient to reconstruct real-world identities.
- All identifiers are opaque references.
- PSPs retain full responsibility for identity, KYC, and customer data.

This aligns with the scheme’s privacy-by-design principles.

---

## Mapping to API specification

| Data Model Element | OpenAPI Element |
|-------------------|-----------------|
| Participant | `Participant` schema |
| Lifecycle state | `state` enum |
| State transitions | POST lifecycle endpoints |
| Audit events | Non-exposed internal records |

---

## Mapping to downstream artefacts

This data model constrains:

- database schemas (illustrative)
- API payloads
- test fixtures
- lifecycle validation logic
- CI/CD checks for state integrity

Any downstream artefact MUST remain consistent with this model.

---

## Disclaimer

This data model is illustrative.

It demonstrates how onboarding intent expressed in rulebooks
can be realised as a coherent, auditable platform data model,
without asserting an official ECB implementation.
