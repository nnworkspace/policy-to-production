---
artefact_type: governance
visibility: public
audience: everyone
form: text
role: governance
status: informative
owner: system-architect
---

# Technical Specifications

## Why Specifications Matter (and why they are not tickets)

In many projects, detailed system behaviour is often documented inside project management tickets (e.g., Jira, GitHub Issues). This is a **fundamental anti-pattern** that this repository explicitly rejects.

**Tickets are ephemeral; Specifications are durable.**

- **Tickets describe "Work":** A ticket captures a moment in time—who is doing what, when, and the conversation surrounding a specific change. Once closed, a ticket fades into history.
- **Specifications describe "Truth":** A specification defines the current, binding state of the system. It must remain accurate and accessible long after the original developer has left.

When logic is defined in tickets, the system's "truth" becomes fragmented across thousands of closed tasks. No one knows how the system works without digital archaeology. In this repository, tickets (`00-project-governance/issue-templates`) manage the *process* of change, but this folder manages the *definition* of the result.

**Code implements Specs, not Tickets.**

---

## Acknowledgement of Methodology

The structure, rigour, and standardisation process adopted in this folder are explicitly modelled after the **European Commission's EUDI Wallet Technical Specifications**.

We acknowledge and cite the following reference as the gold standard for institutional technical documentation:
* [EUDI Wallet - Standards and Technical Specifications](https://github.com/eu-digital-identity-wallet/eudi-doc-standards-and-technical-specifications/blob/main/docs/technical-specifications/README.md)

---

## ⚠️ LEGAL NOTICE: FICTIONAL & ILLUSTRATIVE CONTENT

> **IMPORTANT:** The technical specifications contained in this folder are **FICTIONAL**.
>
> At the time of writing, the European Central Bank (ECB) has not published detailed open technical specifications or OpenAPI definitions for the Digital Euro back-end interfaces.
>
> The documents below (e.g., `TS-PSP-001`) have been created by the author of this repository solely to **demonstrate how rigorous specifications should be structured** within a governed project. They utilize official concepts (like the "Intermediated Model") but the specific API endpoints, data models, and attribute names are inventions of the author.
>
> **Do not use these specifications to build actual software for the Digital Euro.**

---

## Standardisation Process

To bridge the gap between abstract rules and executable code, this project follows a structured standardisation process.

Each artefact in this folder is treated as a **Standard**, not merely documentation. This means:

1.  **Normative Nature:** The use of keywords such as "MUST", "SHOULD", and "MAY" strictly follows [RFC 2119](https://www.ietf.org/rfc/rfc2119.txt).
2.  **Machine-Readability:** Where applicable, normative definitions are provided as machine-readable schemas (OpenAPI, JSON Schema) rather than ambiguous prose.
3.  **Strict Traceability:** Every technical requirement must trace back to a Rulebook requirement (`20-rulebook`).

## List of Specifications

| Spec ID | Title | Scope (Component) |
| :--- | :--- | :--- |
| **TS-PSP-001** | **Onboarding & Alias Management** | `COMP-EUR-02` (Alias Service) |
| **TS-PSP-002** | **Payment Initiation Standard** | `COMP-PSP-01` (Gateway) |

## Governance & Linting

* **LINT-T2 (Traceability):** All specifications MUST include a "Normative References" clause linking to the Rulebook.
* **LINT-V1 (Visibility):** Public specifications cannot reference Confidential internal documents.