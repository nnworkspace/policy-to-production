---
artefact_type: governance
visibility: public
audience: everyone
form: text
role: governance
status: informative
owner: project-governance
---

# Project Governance

This folder contains the **governance documents** that define how this project is organised, controlled, and audited.

These documents establish the **rules of the workbench**: how artefacts are classified, how visibility is handled, how collaboration is governed, and how auditability is achieved in an institutional context.

They are **normative** by design.

---

## What belongs here

The documents in this folder define:

- how artefacts are classified and governed  
- how logical unity is maintained across distributed repositories and registries  
- how communication and project management are conducted within the workbench  
- how access rights are derived from declared intent  
- how auditability is achieved without unnecessary disclosure  

They do **not** describe business logic, technical implementations, or project-specific deliverables.


## Governance documents

The governance corpus currently includes:

- **`artefact-classification.md`**  
  Defines the unified artefact metadata schema and the classification model applied across the project.

- **`access-derivation-and-auditability.md`**  
  Describes how declared artefact metadata is used to derive access rights and support audits without default access to confidential content.

- **`logical-system-and-visibility.md`**  
  Explains how a single logical system is maintained despite physical distribution of artefacts due to visibility or contractual constraints.

- **`branching-strategy.md`**
  Defines the Git branching model (Feature Branch Workflow) used to maintain stability and agility in the central repository.

- **`communication-and-project-management.md`**  
  Defines how collaboration, coordination, and decision-making are conducted using the shared Git-based workbench.

- **`commit-message-conventions.md`**
  Defines the strict formatting and traceability rules for commit messages, enforced mechanically by `commitlint`.

- **`configuration-management.md`** 
  Defines the strategy for maintaining auditable system states through atomic baselines (Sets), manifest-based versioning, and version-aware traceability.

- **`glossary.md`**
  Defines the authoritative terminology (e.g. "Digital Euro", "Issuance Component") used throughout the project to ensure semantic consistency.

- **`linting-rules.md`**
  Defines the automated governance rules (e.g. `LINT-C1`, `LINT-T2`) that enforce classification, traceability, and consistency via CI/CD pipelines.

- **`issue-labels.md`**
  Defines the controlled vocabulary of issue labels (Type, Status, Impact) to ensure that the issue tracker serves as a reliable governance instrument.


Additional governance instruments (such as issue templates) may live in subfolders and are governed by the same principles.


## Normative status

All documents in this folder are **normative** unless explicitly stated otherwise.

They define constraints that are:

- expected to be followed
- enforced through automation where possible
- reviewed deliberately when changed

Changes to governance documents should therefore be treated as **governance decisions**, not routine edits.


## Audience

These documents are written for **everyone involved in the project**, including:

- legal and policy contributors  
- architects and engineers  
- auditors and security reviewers  
- project and programme managers  
- institutional decision-makers  

They are intended to provide a **shared frame of reference** across disciplines.

## Relationship to the rest of the repository

This folder does not stand alone.

Governance is effective only when it is:

- reflected in artefact structure  
- enforced by CI/CD pipelines  
- visible in day-to-day collaboration  

The purpose of this folder is to make those governing principles explicit, inspectable, and durable.

## Final note

Governance, in this project, is not an overlay.

It is part of the system itself.

By keeping governance explicit, minimal, and enforceable, the project avoids institutional amnesia and preserves the intent behind what is built — long after the first implementation has shipped.

## Disclaimer

The documents in this folder are **illustrative and educational**.

They do not represent official governance policies, legal mandates, or endorsed standards for the Digital Euro or any other real-world system.



