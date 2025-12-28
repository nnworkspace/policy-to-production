---
artefact_type: rulebook
visibility: public
audience: everyone
form: text
role: rule
status: normative
owner: rulebook-development-group
---

# Scheme Actors and Roles

## Source Reference
**Draft Digital Euro Scheme Rulebook V0.9** — Sections 2.3 (Scheme Actors) & 3 (Participants).

## Purpose
This document defines the primary actors and roles within the Digital Euro ecosystem. All technical specifications for authentication, authorization, and access control must align with these definitions.

---

## 1. Governance Authority

### The Eurosystem
The Eurosystem (comprising the ECB and National Central Banks of the euro area) acts as the **Scheme Owner** and **Issuer**.
- **Role:** Defines the rules, issues the digital euro, and safeguards the stability of the system.
- **Responsibilities:**
    - Setting holding limits.
    - Overseeing scheme integrity.
    - Providing settlement services.

## 2. Intermediaries (Participants)
Intermediaries are the primary interface for end users. They are typically **Payment Service Providers (PSPs)** authorized under PSD2/PSR.

### Role: Digital Euro Service Provider
- **User Management:** Responsible for onboarding, Know Your Customer (KYC), and Anti-Money Laundering (AML) checks.
- **Account Management:** managing the digital euro payment accounts (wallets) on behalf of users.
- **Interface:** Providing the mobile app, online banking interface, or physical device for users to interact with the digital euro.
- **Liquidity:** Facilitating funding and defunding operations via commercial bank money.

## 3. End Users
### Private Individuals
Natural persons acting for private purposes.
- **Capabilities:** Person-to-Person (P2P), Person-to-Merchant (P2M), and funding/defunding operations.
- **Constraints:** Subject to standard holding limits.

### Merchants / Businesses
Legal entities or individuals accepting payments for goods and services.
- **Capabilities:** Receiving payments (P2M).
- **Constraints:** Typically operate with a **zero holding limit** (automated defunding), meaning funds are instantly swept to a commercial account.

### Public Sector
Government bodies accepting or making payments (e.g., taxes, welfare).

## 4. Technical Actors
### Offline Solution Provider
Entities providing the secure hardware or software components required for offline digital euro bearer instruments.