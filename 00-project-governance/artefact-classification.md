---
artefact_type: governance
visibility: public
audience: everyone
form: text
role: governance
status: normative
owner: project-governance
---


# Artefact Classification Model

## Purpose

This document defines the **Artefact Classification Model** used throughout this repository.

Its purpose is to make explicit how different project artefacts are:

- governed
- shared
- delivered
- audited

The model applies uniformly to **all artefacts**, regardless of whether they are legal texts, specifications, source code, binaries, or hosted services.

---

## Why classification is necessary

Large, multi-stakeholder institutional projects inevitably produce artefacts with **different audiences, sensitivities, and delivery forms**.

Treating all artefacts as if they were equally public, equally open, or equally distributable leads to:

- accidental disclosure of sensitive information
- unclear responsibilities
- fragile governance
- loss of trust between institutions and vendors

This classification model does **not** aim to restrict transparency unnecessarily. Its aim is to:

> **Make constraints explicit, auditable, and enforceable.**

---

## Scope

The model applies to:

- legislative and policy documents
- scheme rulebooks
- architectural descriptions
- technical specifications
- source code
- binary deliverables (e.g. SDKs)
- hosted services (e.g. simulators, test environments)
- CI/CD artefacts and reports
- governance instruments (e.g. issue templates)

No artefact is exempt.

---

## Classification axes

Each artefact is classified along **four semantic axes**:

1. Visibility  
2. Audience  
3. Form  
4. Role  

In addition, each artefact declares governance attributes (artefact type, status, and owner) to establish authority and responsibility.

All declared fields are mandatory.

---

## Canonical schema

```yaml
---
artefact_type: <TYPE>
visibility: <VISIBILITY>
audience: <AUDIENCE | LIST>
form: <FORM>
role: <ROLE>
status: <STATUS>
owner: <OWNER>
---

```

### Field definitions

|Field|Meaning|Allowed values|
|---|---|---|
|artefact_type|Kind of artefact|governance,governance-instrument,policy,rulebook,specification,implementation,test,evidence,delivery|
|visibility|Who may access the artefact|public,restricted,confidential|
|audience|Who the artefact is written for|everyone,ECB,NCB,PSP,VENDOR,PLATFORM_PROVIDER,AUDITOR|
|form|How the artefact is delivered|text,source,binary,service|
|role|Traceability position|policy,legal,rule,architecture,specification,implementation,test,evidence,delivery,governance|
|status|Normative weight|normative,operative,informative|
|owner|Institutional responsibility|free text (organisation or role)|


### Example: Markdown document (inline metadata)

```yaml
---
artefact_type: specification
visibility: restricted
audience:
  - PSP
  - NCB
form: text
role: specification
status: normative
owner: eurosystem
---
```
This form is used for:
- Markdown documents
- specifications
- governance texts
- configuration expressed as text

### Applying the schema in source code

For source code, the **same schema** is embedded as a structured comment at the top of the file.

The syntax of the comment must respect the language, but the **content must remain identical**.

#### Example: C / C++ / Java / JavaScript (block comment)

```c
/*
 * artefact_type: implementation
 * visibility: confidential
 * audience:
 *   - ECB
 *   - VENDOR
 * form: source
 * role: implementation
 * status: operative
 * owner: vendor-xyz
*/

```

#### Example: Python / Shell / YAML (line comments)

```python
# artefact_type: implementation
# visibility: restricted
# audience:
#   - PSP
# form: source
# role: implementation
# status: operative
# owner: eurosystem

```

#### Example: SQL

```sql
-- artefact_type: test
-- visibility: restricted
-- audience: AUDITOR
-- form: source
-- role: test
-- status: informative
-- owner: project-governance

```

---

### Folder-level metadata (tool-constrained artefacts)

Some artefacts are governed by external tools that impose fixed file formats or headers
(e.g. issue templates in GitHub or GitLab).

In such cases, classification MUST be declared once at the **folder level** using a dedicated metadata file.

Folder-level metadata applies uniformly to all artefacts in that folder unless explicitly overridden.

#### Example

```sh

00-project-governance/issue-templates/
├── _metadata.yaml
├── requirement.md
├── clarification.md

```
```yaml
artefact:
  visibility: PUBLIC
  audience: everyone
  form: TEXT
  role: GOVERNANCE_INSTRUMENT

```

### 3. Sidecar metadata (non-textual artefacts)

**Non-textual artefacts** MUST declare classification via a sidecar metadata file.

This includes:

- binary deliverables (SDKs, libraries, firmware)
- archives
- hosted services or simulators

#### Example

```sh
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

## Declaring classification

Each artefact must explicitly declare its classification.

How classification is declared depends on the **nature of the artefact** and any **tooling constraints** that apply.

---

## Precedence rules

1. Sidecar metadata overrides folder-level metadata
2. Folder-level metadata overrides inline defaults
3. Inline metadata applies only to the artefact in which it appears

Exceptions must be explicit and intentional.

---

### Notes on consistency

- The **keys and values MUST NOT be renamed**
- Capitalisation of values should be consistent across the repository
- Each artefact MUST resolve to exactly one effective metadata declaration.

Metadata MAY be defined at multiple levels (inline, folder-level, or sidecar),
but precedence rules MUST result in a single, unambiguous set of metadata
that applies to the artefact.

Conflicting or ambiguous declarations are rejected by design.

---

## Validation and enforcement

Automation enforces the following rules:

- every artefact MUST be classifiable via one mechanism
- artefacts MUST NOT declare classification in multiple places
- declared values MUST conform to this model
- violations are rejected by design

---

## Auditability

This model enables auditors to:

- understand what artefacts exist
- understand why some artefacts are restricted
- verify that constraints are respected
- trace decisions from policy to delivery

The project can be audited by inspecting metadata, structure, and traceability, without automatically granting access to sensitive content.

---

## Relationship to tools

This classification model is **tool-agnostic**.

It can be:

- enforced manually
- enforced through custom automation
- encoded in opinionated frameworks (e.g. DoorStop)

The model defines _what_ must be governed.
Tools define _how_.

---

## Final note

A civilised system does not pretend that all artefacts are equal.

It acknowledges differences openly, governs them explicitly, and enforces discipline consistently.

This model exists to support that goal.

