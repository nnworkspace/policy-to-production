---
artefact_type: specification
visibility: public
audience: everyone
form: text
role: documentation
status: informative
owner: system-design
---

# Participant Onboarding Specification Set

## 1. Identity and Scope

This folder contains the **Participant Onboarding Specification Set** (`SPEC-SET-ONB`).

It defines the technical requirements, interfaces, data models, and state machines required to onboard a new Participant (PSP) onto the Digital Euro infrastructure.

### Versioning Strategy
**This folder is versioned as an atomic unit.**
The current normative version of this set is defined in the **[`manifest.yaml`](./manifest.yaml)** file. Individual Markdown files do not carry independent version numbers.

## 2. ⚠️ LEGAL NOTICE: FICTIONAL CONTENT

> **IMPORTANT:** The technical specifications contained in this folder are **FICTIONAL**.
>
> They have been created by the authors of this repository solely to **demonstrate how rigorous specifications can/should be structured** within a governed project. They do **NOT** represent actual Digital Euro project. 
>
> **Do not use these specifications to build actual software for the Digital Euro.**


## 3. The Specification Set

The set consists of the following modular components.
Each component has a unique **Global ID** to allow precise citation in code and tests (e.g., `Ref: SPEC-OB-FUNC`).

| Global ID | File | Role |
| :--- | :--- | :--- |
| **SPEC-OB-ROOT** | [`onboarding-spec-overview.md`](./onboarding-spec-overview.md) | **Root Document**<br>Defines the Scope, Document Map, and Traceability rules. |
| **SPEC-OB-FUNC** | [`onboarding-functional-spec.md`](./onboarding-functional-spec.md) | **Functional Spec**<br>Defines the State Machine (`DRAFT` → `ACTIVE`) and business rules. |
| **SPEC-OB-INT** | [`onboarding-interfaces-spec.md`](./onboarding-interfaces-spec.md) | **Interface Spec**<br>Defines the interaction flows between PSP and Platform. |
| **SPEC-OB-DATA** | [`onboarding-data-model-spec.md`](./onboarding-data-model-spec.md) | **Data Model Spec**<br>Defines the authoritative entities and privacy constraints. |
| **SPEC-OB-API** | [`openapi.yaml`](./openapi.yaml) | **OpenAPI Definition**<br>Machine-readable contract implementing the above specs. |


## 4. Traceability Strategy & Chain of Custody

This Specification Set acts as the bridge between high-level mandates and concrete verification. To ensure auditability, every requirement in this folder follows a strict **Chain of Custody**:

### 4.1 Origin (Upstream Mandates)
Every requirement must trace back to a specific **Rule ID**. This anchors technical behavior to the legal and operational framework.

- **Mandate:** We implement the *Participant Onboarding Rules* defined in:
    - `@rule=SET-RULEBOOK:0.9.0` (specifically [`functional-onboarding.md`](../../20-rulebook/functional-onboarding.md))
- **Enforcement:** **LINT-T2** validates that every spec file contains valid `@rule` references.

### 4.2 Constraint (Architectural Boundary)
Every requirement must apply to a specific **Component ID**. This prevents "Architecture Drift" by ensuring specifications respect the system boundaries and security zones.

- **Constraint:** We adhere to the *System Context* and *Security Zones* defined in:
    - `@arch=SET-ARCH:0.1.0` (specifically mapping to `COMP-EUR-02` Alias Service and `COMP-EUR-05` Access Gateway)
- **Enforcement:** **LINT-T1** (Validation of implementation traces) and architectural review.

### 4.3 Verification (Downstream Consumers)
Every requirement must be verifiable. Downstream artefacts rely on the **exact version** of this specification set to prove compliance.

- **Test Suite:** The logic here is verified by the Conformance Test Suite:
    - `@test=TEST-SET-ONB:0.1.1` (located in `50-tests/100-conformance-scenarios/onboarding/`)
    - *Enforcement:* **LINT-T3** checks that every spec ID is covered by a test.
- **Implementation:** The Reference Implementation derives its logic from here:
    - `60-code/adapter-service` (Must declare compliance to `SPEC-SET-ONB:0.1.1`)

> **Note on Drift:** Mismatches between the version defined in `manifest.yaml` and the versions cited by consumers will be flagged by **LINT-T5 (Spec Drift)**.


## 5. Governance & Linting

This folder is subject to the following automated governance rules:

- **LINT-T2 (Anchoring):** Every specification file must reference a Rulebook ID.
- **LINT-T4 (Version Syntax):** References must include the version suffix (e.g., `:0.1.0`).
- **LINT-T5** (Spec Drift): Referenced versions must match the `RELEASED` version in the target manifest.
- **LINT-C1 (Classification):** All files must carry valid YAML metadata headers.
