---
artefact_type: evidence
visibility: public
audience: everyone
form: text
role: evidence
status: informative
owner: system-quality
---

# Security Assurance

This folder contains **security assurance artefacts** that express
**claims about how the system behaves under security-relevant conditions**.

The focus is not on vulnerabilities in isolation, but on **verifiable guarantees**
about authentication, authorisation, abuse resistance, and auditability
across the system.

Security here is treated as a **first-class system property**,
not as an after-the-fact penetration exercise.

---

## Purpose

In institutional systems, security failures rarely stem from exotic exploits. They more often arise from:

- missing or inconsistent authorisation checks,
- unclear role separation,
- unauditable actions,
- or security rules that exist only implicitly.

The purpose of this folder is to make security expectations:

- **explicit** (clearly stated claims),
- **traceable** (linked to specifications and rules),
- **verifiable** (supported by concrete evidence),
- and **auditable over time**.


## Scope

Security assurance artefacts in this folder typically cover:

- authentication enforcement
- authorisation and role separation
- abuse and misuse cases
- rate limiting and throttling behaviour
- audit event generation and integrity
- rejection of unauthorised state transitions

They describe **observable system behaviour** under security-relevant scenarios.

They do **not** describe:
- cryptographic algorithms in detail,
- internal key management procedures,
- infrastructure hardening techniques,
- or tool-specific exploit payloads.

---

## Organisation

This folder is organised by **scope of applicability**:

```text
300-security/
├── system-level/     # Global security guarantees
├── onboarding/       # Feature-specific security behaviour
└── ...
```

- **`system-level`**
    Contains security assurances that apply across the entire system, regardless of feature (e.g. authentication, TLS enforcement, global rate limiting, audit logging).

- feature-specific folders (e.g. onboarding/)
    Contain security assurances tied to a particular capability, such as role separation, lifecycle transition rules, or feature-specific abuse cases.

## Format

Security assurances are typically expressed as **behavioural scenarios**, most often using **Gherkin (`.feature`) format**.

This format is chosen because it allows security expectations to be:

- reviewed by non-security specialists,
- discussed with legal and governance stakeholders,
- and executed by automation where appropriate.

However, the artefacts remain **tool-agnostic**. The choice of scanners, frameworks, or execution environments is deliberately left outside this folder.

## Traceability

Each security assurance artefact SHOULD declare, in its header comments:

- the **specification identifier(s)** it derives from,
- the **exact version** of each referenced specification,
- a unique **assurance identifier**,
- and the **scope** (system-level or feature-specific).

Security traceability is **version-aware by design**.

This ensures that:
- historical security guarantees remain auditable,
- changes in rules or specifications are visible,
- and security regressions can be detected systematically.


## Relationship to other assurance artefacts

Security assurance artefacts complement other categories:

- **Conformance scenarios (`100-conformance-scenarios/`)**  
  Focus on *what the system does* from a business perspective.

- **Contract definitions (`200-contract-definitions/`)**  
  Define *what interfaces allow or forbid* structurally.

- **Operational assurances (`400-operational/`)**  
  Address *how the system behaves under load or failure*.

Security scenarios often reference or build upon these artefacts, but remain focused on **protection, control, and auditability**.

## What does not belong in this folder

The following do **not** belong here:

- raw penetration testing scripts,
- exploit payloads or proof-of-concept attacks,
- tool-specific scanner configurations,
- infrastructure hardening checklists.

Those artefacts are operational or sensitive by nature and are typically managed in secured environments.

This folder captures **security claims and their verifiable expression**, not the mechanics of attacking the system.

## Intent

The intent of this folder is to demonstrate that security can be:

- reasoned about explicitly,
- verified systematically,
- and governed over time,

without relying on obscurity or ad-hoc testing.

In institutional projects, this form of security assurance is often more valuable than any single penetration report.

---

## Disclaimer

The contents of this folder are **illustrative and educational**.

They demonstrate how security assurance might be structured in a complex, multi-stakeholder system. They do not represent official security requirements, threat models, or audit procedures for the Digital Euro or any other real system.


