---
artefact_type: specification
visibility: public
audience: everyone
form: text
role: specification
status: normative
owner: system-architecture
---

# Participant Onboarding — Specification Overview

## Purpose

This specification defines the **participant onboarding process** for the Digital Euro system.

It describes how an eligible participant progresses from initial registration to active participation, in accordance with the Scheme Rulebook and the system architecture.

This document is **illustrative**.  
It demonstrates how rulebook obligations can be transformed into a technical specification suitable for downstream implementation, testing, reporting, and automation.


## Scope

This specification covers **participant onboarding up to activation**.

Specifically, it defines:

- onboarding lifecycle states  
- mandatory validations and checks  
- responsibilities of participating system components  
- traceability to rulebook rules and architectural components  


## Out of scope

This specification explicitly does **not** cover:

- suspension or termination of participants  
- re-certification or renewal processes  
- sanctions or fraud investigations  
- end-user (wallet holder) onboarding  
- platform-specific or vendor-specific integration details  

These topics may be addressed by separate specifications.


## Normative references

This specification derives from the following rulebook artefacts:

- *Scheme Rulebook — Actors and Roles*  
- *Scheme Rulebook — Functional Onboarding Rules*  

All normative requirements in this specification are traceable to rulebook rules governing:

- participant eligibility  
- certification and verification  
- lifecycle state transitions  
- auditability and accountability  


## Architectural context

These specifications are written against the **Digital Euro Service Platform (DESP)** architecture and its canonical **Digital Euro Access Gateway**.

They assume an intermediated model in which:

- PSPs operate their own internal integration layers (implementation-specific and not standardised),
- all authoritative onboarding state is maintained within DESP,
- all platform interactions occur via the Access Gateway.

This folder does not prescribe PSP internal architecture. It defines the contractual, behavioural, and data expectations at the boundary between intermediaries and the Eurosystem platform.

## Traceability

Each requirement defined in this specification:

- traces back to a rulebook rule  
- constrains one or more architectural components  
- is designed to be testable and auditable  

Downstream artefacts (code, tests, CI/CD pipelines) are expected to reference this specification explicitly.


## Relationship to downstream artefacts

This specification is intended to support the creation of:

- functional interface specifications  
- API definitions (e.g. OpenAPI)  
- conformance tests  
- audit evidence and reports  

The presence of this specification enables automation and governance, but does not mandate specific technologies.


## Disclaimer

This document is **not an official ECB specification**.

It uses publicly available information and reasonable architectural assumptions to demonstrate a **methodology**, not an institutional decision.

Its purpose is educational and illustrative.


