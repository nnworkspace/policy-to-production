# Artefact Classification Model

## Purpose

This document defines the **Artefact Classification Model** used throughout this repository.

Its purpose is to make explicit how different project artefacts are:

* governed
* shared
* delivered
* audited

The model applies uniformly to **all artefacts**, regardless of whether they are legal texts, specifications, source code, binaries, or hosted services.

---

## Why classification is necessary

Large, multi‑stakeholder institutional projects inevitably produce artefacts with **different audiences, sensitivities, and delivery forms**.

Treating all artefacts as if they were equally public, equally open, or equally distributable leads to:

* accidental disclosure of sensitive information
* unclear responsibilities
* fragile governance
* loss of trust between institutions and vendors

This classification model does **not** aim to restrict transparency unnecessarily. Its aim is to:

> **Make constraints explicit, auditable, and enforceable.**

---

## Scope

The model applies to:

* legislative and policy documents
* scheme rulebooks
* architectural descriptions
* technical specifications
* source code
* binary deliverables (e.g. SDKs)
* hosted services (e.g. simulators, test environments)
* CI/CD artefacts and reports

No artefact is exempt.

---

## Classification axes

Each artefact is classified along **four independent axes**:

1. Visibility
2. Audience
3. Form
4. Traceability role

All four axes **must** be declared.

---

## 1. Visibility

Visibility defines **who is allowed to read or access** an artefact.

### Values

#### PUBLIC

* Freely publishable
* No contractual, legal, or security restriction
* Suitable for public repositories and documentation

Typical examples:

* legislation
* public policy documents
* scheme rulebooks
* high‑level architecture descriptions

---

#### RESTRICTED

* Access limited by institutional role
* Not publicly distributed
* Shared with clearly defined stakeholder groups

Typical examples:

* PSP integration specifications
* operational procedures
* internal architecture details

---

#### CONFIDENTIAL

* Access limited by contract or NDA
* Visibility restricted to explicitly named parties
* May involve platform security or vendor‑specific constraints

Typical examples:

* platform‑specific offline components
* secure element integrations
* cryptographic implementation details

> **Note:**
> CONFIDENTIAL does not imply secrecy by choice, but constraint by necessity.

---

## 2. Audience

Audience defines **who the artefact is written for** or who must act upon it.

Multiple audiences may be listed.

### Common audience categories

* ECB
* NCB
* PSP
* VENDOR
* PLATFORM_PROVIDER
* AUDITOR
* PUBLIC

Audience classification clarifies responsibility and expectation, even when visibility is restricted.

---

## 3. Form

Form defines **how the artefact is delivered**.

### Values

#### TEXT

* Human‑readable documentation
* Markdown, PDF, legal text, specifications

---

#### SOURCE

* Human‑readable source code
* Intended for inspection and modification by authorised parties

---

#### BINARY

* Non‑human‑readable deliverables
* SDKs, libraries, firmware, signed packages

Binary artefacts are legitimate first‑class deliverables when required by security, platform, or contractual constraints.

---

#### SERVICE

* Hosted or network‑accessible components
* Simulators, test endpoints, shared environments

Service artefacts are versioned and governed even if no source is distributed.

---

## 4. Traceability role

Traceability role defines **how the artefact fits into the chain from intent to operation**.

### Values

* POLICY
* LEGAL
* RULE
* ARCHITECTURE
* SPECIFICATION
* IMPLEMENTATION
* TEST
* EVIDENCE
* DELIVERY

Every artefact must contribute to at least one traceability role.

---

## Declaring classification

Each artefact must explicitly declare its classification.

How classification is embedded depends on the **form of the artefact**.

### Embedding rules

To balance auditability with repository clarity, this project uses a **hybrid embedding model**:

* **Textual artefacts** (documents, source code, configuration files)
  declare classification **inline**.
* **Non-textual artefacts** (binaries, archives, hosted services)
  declare classification via a **sidecar metadata file**.

An artefact must declare its classification in **exactly one place**:

* Inline **or** sidecar — never both, never neither.

These rules are enforced by automation.

---

### Inline classification (textual artefacts)

Textual artefacts include:

* Markdown documents
* source code (any language)
* configuration files
* scripts
* CI/CD definitions

Classification metadata is embedded directly in the artefact.

#### Example (Markdown front-matter)

```yaml
---
artefact:
  visibility: RESTRICTED
  audience:
    - PSP
    - NCB
  form: TEXT
  role: SPECIFICATION
---
```

#### Example (source code header)

```text
/* artefact:
 *   visibility: CONFIDENTIAL
 *   audience:
 *     - ECB
 *     - VENDOR
 *   form: SOURCE
 *   role: IMPLEMENTATION
 */
```

---

### Sidecar metadata (non-textual artefacts)

Non-textual artefacts include:

* binary deliverables (SDKs, libraries, firmware)
* archives
* hosted services or simulators

These artefacts cannot reliably carry structured metadata.

In these cases, classification is declared in a **sidecar metadata file** with the same base name.

#### Example

```
sdk/offline-wallet-sdk.zip
sdk/offline-wallet-sdk.meta.yaml
```

```yaml
artefact:
  visibility: CONFIDENTIAL
  audience:
    - ECB
    - PLATFORM_PROVIDER
    - VENDOR
  form: BINARY
  role: IMPLEMENTATION
```

---

### Validation and enforcement

Automation enforces the following rules:

* textual artefacts **must** declare inline classification
* textual artefacts **must not** have sidecar metadata files
* non-textual artefacts **must** have a sidecar metadata file
* non-textual artefacts **must not** declare inline classification
* all declared values must conform to this model

Artefacts that violate these rules are rejected by design.

---

```yaml
artefact:
  visibility: RESTRICTED
  audience:
    - PSP
    - NCB
  form: TEXT
  role: SPECIFICATION
```

---

## Enforcement

Classification is not advisory.

Automation enforces compliance through:

* linting rules
* CI checks
* review requirements

Artefacts that:

* lack classification
* declare invalid values
* violate visibility or traceability rules

are rejected by design.

---

## Auditability

This model enables auditors to:

* understand what artefacts exist
* understand why some artefacts are restricted
* verify that constraints are respected
* trace decisions from policy to delivery

Auditability is achieved **without requiring access to confidential content**.

---

## Relationship to tools

This classification model is **tool‑agnostic**.

It can be:

* enforced manually
* enforced through custom automation
* encoded in opinionated frameworks (e.g. DoorStop)

The model defines *what* must be governed. Tools define *how*.

---

## Final note

A civilised system does not pretend that all artefacts are equal.

It acknowledges differences openly, governs them explicitly, and enforces discipline consistently.

This model exists to support that goal.

