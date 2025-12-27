# policy-to-production

## From policy intent to running systems — with discipline

This repository is a **demonstrative reference project**.

Its purpose is not to deliver a runnable system, but to show **how large, complex, multi-stakeholder institutional IT projects can be organised end-to-end** in a way that is auditable, comprehensible, and sustainable.

The Digital Euro project is used throughout this repository to **bring the workflow and methodology to life**. However, the structure and principles presented here are **domain-agnostic** and applicable to any large-scale project involving regulation, governance, multiple institutions, and long-lived systems.

_All references to the Digital Euro project in this repository are derived solely from publicly available sources, such as published legislative drafts, official communications, and openly accessible documentation. This repository does not contain, and does not rely upon, any confidential, restricted, or non-public information._

---

## Why this repository exists

Institutional IT projects often struggle not because of a lack of expertise, but because:

* policy intent is separated from technical implementation
* legislative and regulatory constraints are detached from engineering reality
* requirements are implicit rather than explicit
* code evolves faster than shared understanding

This repository demonstrates an alternative approach:

> **Every artefact — from policy text to source code and delivery — is explicit, versioned, classified, and traceable.**

Governance is enforced mechanically through automation, not informally through process documents.

---

## What this repository is (and is not)

### This repository **is**

* a Markdown-first, Git-based reference structure
* an educational template for policy-to-production traceability
* a demonstration of how automation enforces governance discipline
* readable by engineers, architects, auditors, managers, and executives

### This repository **is not**

* a production-ready system
* a full implementation of the Digital Euro
* a replacement for legal, regulatory, or procurement processes

---

## A note on scope and realism

To support learning, **all artefacts are presented within a single repository using folders**.

This is a **didactic choice**.

In real-world projects, artefacts with different visibility or contractual constraints **must not** live in the same repository.

GitHub and GitLab provide access control at the repository level, not at the file level. As a result:

* PUBLIC artefacts should live in public repositories
* RESTRICTED artefacts should live in access-controlled repositories
* CONFIDENTIAL artefacts should live in NDA-bound repositories

In practice, teams should **promote the folder structure shown here into multiple repositories**, each with appropriate access control.

This repository demonstrates *how to organise the work* — not how to bypass security or contractual boundaries.

---

## Artefact classification and visibility

All artefacts in this repository are classified according to an explicit **Artefact Classification Model**.

Each artefact declares:

* its visibility (PUBLIC, RESTRICTED, CONFIDENTIAL)
* its intended audience
* its delivery form (text, source, binary, service)
* its role in the policy-to-production chain

See:

* `docs/artefact-classification.md`

Classification is not advisory. It is enforced by automation.

---

## Traceability and automation

Traceability is enforced end-to-end:

* policy and legal artefacts anchor requirements
* specifications derive from explicit mandates
* implementations reference specifications
* tests validate specifications
* delivery artefacts are justified and auditable

Automation replaces manual policing:

* linting validates classification and references
* CI enforces governance rules
* violations fail fast and visibly

See:

* `docs/linting-rules.md`

---

## Repository structure (conceptual)

```
policy-to-production/
├── 00-docs/                    # Governance, conventions, classification, glossary
├── 01-stakeholders/            # Institutions, roles, responsibilities
├── 02-legislative-framework/   # Policy and legal context
├── 03-rulebook/                # Scheme rules, obligations, governance
├── 04-architecture/            # High-level system design
├── 05-specifications/          # Technical specifications
├── 06-code/                    # Illustrative implementations
├── 07-tests/                   # Acceptance criteria and evidence
├── 08-ci-cd/                   # Pipeline and deployment concepts
├── README.md
└── LICENSE
```

Each directory represents a **layer of intent**, ordered deliberately from abstract mandate to concrete delivery.

The numeric prefixes make the progression explicit and discourage accidental inversion (for example, writing code before mandate or tests before specification).

---

## Relationship to restricted and confidential artefacts

Some artefacts — particularly those related to security-sensitive components, platform integrations, or vendor-specific implementations — **cannot be public by design**.

In this repository, such artefacts are represented by:

* manifests
* interface descriptions
* metadata
* explicit placeholders

The actual content would live in separate repositories with appropriate access control.

This makes constraints visible **without violating them**.

---

## Relationship to `policy-to-production-doorstop`

This repository represents the **flexible, tool-light** approach.

For teams at an earlier stage of maturity, see:

👉 [**`policy-to-production-doorstop`**](https://github.com/nnworkspace/policy-to-production-doorstop)

That repository uses an opinionated requirements framework to reduce degrees of freedom and provide additional guidance.

A typical progression is:

1. Start with DoorStop (guided discipline)
2. Graduate to this repository (earned flexibility)

---

## Intended audience

This repository is written for:

* engineers working in regulated or public-sector environments
* architects designing long-lived systems
* programme managers and technical leads
* auditors and compliance functions
* decision-makers responsible for technology governance

---

## How to read this repository

* Executives: start with this README and `architecture/`
* Architects: start with `architecture/` and `specifications/`
* Engineers: start with `specifications/` and `code-examples/`
* Auditors: focus on `legislative-framework/`, `tests/`, and `docs/`

---

## Status

This repository is a **living educational reference**.

Its value lies in structure, clarity, and discipline — not completeness.

---

## Licence

This repository is published for educational and demonstrative purposes.

No warranty is provided.
