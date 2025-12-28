---
artefact_type: specification
visibility: public
audience: everyone
form: text
role: specification
status: normative
owner: system-architecture
---

# Participant Onboarding — Functional Specification

## Purpose

This document defines the **normative functional requirements** governing participant onboarding.

It specifies:

- required system behaviour  
- permitted and forbidden state transitions  
- mandatory validations  
- audit and traceability obligations  

It does **not** define technical protocols or data formats.  
Those are addressed by interface and API specifications.


## Normative language

The keywords **MUST**, **MUST NOT**, **SHALL**, **SHOULD**, and **MAY** are to be interpreted as described in RFC 2119.


## Lifecycle states

The onboarding lifecycle consists of four states:

`DRAFT → SUBMITTED → VERIFIED → ACTIVE`


No other states are permitted in this specification.


## General principles

### ONB-G-01 — Single participant record

Each participant **MUST** be represented by exactly one participant record.

Duplicate records for the same legal entity **MUST NOT** exist.


### ONB-G-02 — State integrity

A participant record **MUST** always be in exactly one lifecycle state.

Concurrent or ambiguous states **MUST NOT** occur.


### ONB-G-03 — Idempotency

Repeated submission of identical onboarding data **MUST NOT** result in duplicate state transitions or side effects.


## State-specific requirements

### DRAFT state

#### ONB-D-01 — Draft creation

The system **MUST** allow the creation of a participant record in state `DRAFT`.

Mandatory information **MAY** be incomplete in this state.


#### ONB-D-02 — Draft mutability

While in `DRAFT`, participant data **MAY** be modified freely by the submitting party.

No external validation **SHALL** be triggered.


### SUBMITTED state

#### ONB-S-01 — Submission

Transition from `DRAFT` to `SUBMITTED` **MUST** require an explicit submission action.

Implicit or automatic submission **MUST NOT** occur.

#### ONB-S-02 — Submission immutability

Once a participant record enters `SUBMITTED`, submitted data **MUST NOT** be modified except through an explicit correction process.

#### ONB-S-03 — Submission validation

Upon transition to `SUBMITTED`, the system **MUST** perform completeness checks on mandatory data elements.

Failure **MUST** prevent further progression.

### VERIFIED state

#### ONB-V-01 — Verification checks

Transition from `SUBMITTED` to `VERIFIED` **MUST** require successful completion of:

- eligibility verification  
- certification validation  
- identity and role checks  

The exact checks are defined by the rulebook and certification authorities.

#### ONB-V-02 — Verification authority

Only authorised verification processes or actors **MAY** initiate the transition to `VERIFIED`.

#### ONB-V-03 — Verification traceability

Each verification decision **MUST** generate an auditable record, including:

- verifier identity  
- timestamp  
- outcome  

### ACTIVE state

#### ONB-A-01 — Activation

Transition from `VERIFIED` to `ACTIVE` **MUST** require an explicit activation action.

Activation **MUST NOT** occur automatically upon verification.


#### ONB-A-02 — Operational eligibility

Only participants in state `ACTIVE` **MAY**:

- access operational APIs  
- participate in settlement or liquidity processes  
- interact with other active participants  

#### ONB-A-03 — Irreversibility (within scope)

This specification defines no backward transitions from `ACTIVE`.

Deactivation, suspension, or termination are **out of scope**

## Invalid transitions

The following transitions are **explicitly forbidden**:

- `DRAFT → VERIFIED`  
- `DRAFT → ACTIVE`  
- `SUBMITTED → ACTIVE`  
- `ACTIVE → any other state`  

Attempted invalid transitions **MUST** be rejected and logged.

## Audit requirements

### ONB-AUD-01 — State change logging

Every lifecycle state transition **MUST** be logged with:

- previous state  
- new state  
- triggering action  
- timestamp  

### ONB-AUD-02 — Decision provenance

Verification and activation decisions **MUST** be attributable to a responsible actor or process.

Anonymous or untraceable decisions **MUST NOT** occur.

## Security requirements

### ONB-SEC-01 — Access control

Only authorised roles **MAY**:

- submit participant records  
- perform verification  
- activate participants  

Role definitions are derived from the scheme rulebook.


### ONB-SEC-02 — Confidentiality

Onboarding data **MUST** be protected according to its declared visibility and classification.


## Relationship to downstream specifications

This functional specification constrains:

- interface behaviour specifications  
- API definitions (e.g. OpenAPI)  
- test cases and conformance suites  

No downstream artefact may contradict the requirements defined herein.


## Disclaimer

This specification is illustrative.

It demonstrates a method for translating rulebook obligations into functional technical requirements and does not represent an official ECB technical specification.
