---
artefact_type: rulebook
visibility: public
audience: everyone
form: text
role: rule
status: normative
owner: rulebook-development-group
---

# Scheme Rulebook

In rigorous institutional projects, the **Rulebook** serves as the definitive operational logic of the system. It translates abstract legal mandates and high-level policy into concrete, binding obligations for all participants.

While legislation defines *rights*, the Rulebook defines *rules*. It is the authoritative reference against which all technical specifications and implementations must be validated.

To make this concept concrete and tangible, this folder contains small parts from the **Digital Euro Scheme Rulebook** as an illustrative example.

## Purpose

The Rulebook layer acts as the **bridge** between the Legislative Framework (`10-legal-framework`) and the Technical Specifications (`40-specifications`).

Its primary goals in this repository are:

1.  **Decomposition:** Breaking down complex operational requirements into granular, addressable domains (e.g., Onboarding, Liquidity).
2.  **Addressability:** Ensuring that every rule can be referenced by a unique identifier or file path, allowing downstream engineering artefacts to link directly to the specific logic they implement.
3.  **Machine-Readability:** Presenting rules in a structured text format (Markdown) that integrates seamlessly with version control and automated governance pipelines.

## Source Material

The artefacts in this folder are derived from the official **Draft Digital Euro Scheme Rulebook V0.9** (published July 2025).

* **Official Source:** [Draft Digital Euro Scheme Rulebook V0.9 (PDF)](https://www.ecb.europa.eu/euro/digital_euro/timeline/profuse/shared/pdf/ecb.derdgp250731_Draft_digital_euro_scheme_rulebook_v0.9.en.pdf)

> **Note:** This repository contains excerpts formatted for demonstration purposes. In a live production environment, this folder or the rulebook's own repository should represent the official release versions of the Rulebook.

## Contents

The Digital Euro Rulebook is organised by functional domain in this demonstration:

| Artefact | Description | Key Concepts |
| :--- | :--- | :--- |
| [`actors-and-roles.md`](./actors-and-roles.md) | Defines the "Who" of the system. | Eurosystem, Intermediaries (PSPs), Users, Merchants. |
| [`functional-onboarding.md`](./functional-onboarding.md) | Rules for entry and identity. | One Person/One Identity, KYC responsibilities, Portability. |
| [`liquidity-and-waterfall.md`](./liquidity-and-waterfall.md) | Rules for funding and defunding. | Manual funding, Automated Waterfall, Reverse Waterfall, Holding Limits. |

## Traceability Relationships

This folder sits at the center of the traceability chain:

- **Upstream (`10-legal-framework`):** Rules here derive their authority from the Legal Framework.
    * *Example:* The "Reverse Waterfall" rule derives from the legal mandate to prevent excessive capital flight from commercial banks.
- **Downstream (`30-architecture` & `40-specifications`):**
    * Technical specifications MUST reference specific Rulebook artefacts to justify their existence.
    * **Linting Rule `LINT-T2`** enforces that every Specification anchors to a Rule.

## Governance

- **Owner:** Rulebook Development Group (RDG) / Scheme Manager.
- **Status:** Normative.
- **Change Management:** Changes to these files represent changes to the Scheme itself, not just software updates. They typically require multi-stakeholder approval.

## Final Note

Code does not implement "policy"; code implements "rules."

By formalising the Rulebook as a set of versioned technical documents, we ensure that the engineering team builds exactly what the scheme defines—nothing more, nothing less.

