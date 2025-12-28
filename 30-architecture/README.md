---
artefact_type: governance
visibility: public
audience: everyone
form: text
role: governance
status: informative
owner: system-architect
---

# System Architecture

In complex institutional systems, architecture is not merely a diagram of services and databases. It is the definition of **boundaries, responsibilities, and constraints**.

A rigorous architectural definition ensures that:
1.  **Logical boundaries** align with legal and regulatory mandates (e.g., privacy firewalls).
2.  **Responsibility** is clearly assigned to specific actors (who runs the ledger? who holds the keys?).
3.  **Components** are decoupled to allow independent evolution of policy and technology.

This folder defines the **Logical Architecture** of the system. It describes *what* must be built and *how* parts relate, separate from the specific code implementations found in later layers.

## Digital Euro Context

To provide a concrete example, this architecture reflects the **High-Level Design of the Digital Euro** as communicated by the Eurosystem.

The architecture is characterized by a strict **Intermediated Model**:
- The **Eurosystem** acts as the settlement infrastructure provider and issuer.
- **Supervised Intermediaries (PSPs)** act as the gatekeepers, managing user authentication, KYC, and the "waterfall" links to commercial bank money.

This design enforces a "privacy partition": the central settlement engine processes transactions pseudonymously, while the mapping to real-world identities remains strictly within the domain of the Intermediaries.

> **Note on Accuracy:** The architectural descriptions in this folder represent our best understanding of the official ECB design choices based on public documentation available as of late 2025. They are structured to support the "fictional" specifications in this repository and should be viewed as illustrative of a compliant implementation.

## Contents

The architecture is defined through three primary views:

| Artefact | Purpose | Key Question Answered |
| :--- | :--- | :--- |
| [`system-context.md`](./system-context.md) | High-level ecosystem view. | How do the Eurosystem, PSPs, and Users interact? |
| [`component-inventory.md`](./component-inventory.md) | Logical blocks and services. | What specific engines (e.g., Waterfall, Settlement, Alias) must be built? |
| [`security-and-privacy-zones.md`](./security-and-privacy-zones.md) | Data boundaries and trust. | How is the "Privacy Firewall" between the ECB and User Identity architected? |

## Traceability Relationships

- **Upstream (`20-rulebook`):** Every architectural component exists to satisfy a Rule.
    - *Example:* The **Alias Service** component exists to satisfy the *Single Identity Principle* (`functional-onboarding.md`).
    - *Example:* The **Waterfall Engine** component exists to satisfy the *Liquidity Management* rules (`liquidity-and-waterfall.md`).

- **Downstream (`40-specifications`):**
    - Specifications define the *interfaces* (APIs) for the components listed here.
    - Code (`50-code`) implements the components defined here.

## Governance

- **Owner:** Lead System Architect.
- **Status:** Normative.
- **Review:** Architectural changes (e.g., moving a boundary, merging components) require a **Design Decision** issue (`[DESIGN]`) and broad stakeholder review.

## Final Note

A good architecture is a contract. It tells the builders what to build, the auditors what to verify, and the policy-makers how their rules are enforced in silicon.