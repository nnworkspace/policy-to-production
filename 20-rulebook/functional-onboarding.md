---
artefact_type: rulebook
visibility: public
audience: 
  - PSP
  - NCB
  - VENDOR
form: text
role: rule
status: normative
owner: rulebook-development-group
---

# User Onboarding and Identity Rules

## Source Reference
**Draft Digital Euro Scheme Rulebook V0.9** — Section 5 (User Management).

## Purpose
This document defines the rules for identifying users and establishing digital euro relationships. These rules determine the logic for the **Onboarding API** and **User Registry**.

---

## 1. Single Identity Principle
**Rule ONB-01:** One User, One Identity.
- A user is identified uniquely across the ecosystem, regardless of which Intermediary they use.
- The scheme ensures that the **Holding Limit** is enforced across all intermediaries held by the same natural person.

## 2. Onboarding Process
**Rule ONB-02:** Intermediary Responsibility.
- Onboarding MUST be performed by an authorized Intermediary.
- The Intermediary MUST perform KYC/AML checks in compliance with relevant EU regulations before a digital euro account is activated.

**Rule ONB-03:** Digital Euro Account Creation.
- Upon successful verification, the Intermediary provisions a **Digital Euro Account** (wallet).
- This account MUST be linked to the user's unique digital euro identifier.

## 3. Account Switching & Portability
**Rule ONB-04:** Portability.
- Users MUST be able to switch Intermediaries or hold accounts with multiple Intermediaries (subject to the aggregate holding limit).
- Onboarding a user at a new Intermediary triggers a check against the central limit repository to ensure compliance.

## 4. Offboarding
**Rule ONB-05:** Termination.
- Users have the right to close their digital euro account at any time.
- Intermediaries MUST process offboarding by defunding any remaining balance to the user's commercial bank account before closure.

