---
artefact_type: architecture
visibility: public
audience: everyone
form: text
role: architecture
status: normative
owner: system-architect
---

# Component Inventory

## Purpose
This document lists the mandatory **Logical Components** of the Digital Euro architecture.
It serves as the master inventory for the system. Every piece of code or infrastructure in the `50-code` layer must map to at least one of these components.

## Naming Convention
Components are identified by ID: `COMP-<DOMAIN>-<ID>`.
- `EUR`: Eurosystem (Central Infrastructure)
- `PSP`: Payment Service Provider (Intermediary)
- `USR`: User Domain


## 1. Eurosystem Domain (Central Infrastructure)

These components are operated by the Eurosystem (ECB and NCBs).  
They may process *transaction values* and *system-level identifiers*, but they do **not** process or store *real-world identities (PII)*.

The **Digital Euro Service Platform (DESP)** is the central technical platform that enables issuance, redemption, settlement and platform services which individual intermediaries cannot accomplish alone. The DESP provides core services (e.g. settlement, alias/participant registries, onboarding repositories) and exposes them via an access surface for supervised intermediaries. 

| ID | Component Name | Responsibility | Upstream Rule |
| :--- | :--- | :--- | :--- |
| **COMP-EUR-01** | **Settlement Engine** | The core ledger within DESP. Validates digital signatures, prevents double-spending, and moves value between wallet addresses. | `actors-and-roles.md` |
| **COMP-EUR-02** | **Alias Service** | A DESP service that maintains the registry of hashed user identifiers to enforce the Single Identity Rule across PSPs without revealing PII. | `functional-onboarding.md` |
| **COMP-EUR-03** | **Dispute Management System** | A DESP service that allows PSPs to flag fraudulent transactions or technical errors for investigation and resolution. | *N/A (Future Scope)* |
| **COMP-EUR-04** | **Digital Euro Service Platform (DESP)** | The platform domain: hosts core services (settlement engine, alias service, onboarding repository, simulation and test APIs) and provides platform governance, observability, and operator controls. | `actors-and-roles.md`, `functional-onboarding.md` |
| **COMP-EUR-05** | **Digital Euro Access Gateway** | The canonical access point / API surface of DESP. Authenticates and authorises PSPs, validates and routes requests to DESP services, enforces platform-level controls (rate limiting, schemas, audit), and provides a single integration contract for intermediaries. | `actors-and-roles.md`, `functional-onboarding.md` |


### Detailed Definition: Digital Euro Service Platform (DESP) (`COMP-EUR-04`)

- **Role:** The DESP is the central technical platform enabling issuance/redemption and providing functions (e.g. settlement, registries, test environments) that cannot be carried out by a single intermediary alone. Public experimentation materials and technical documentation describe DESP as the platform that stakeholders will connect to for prototyping and validation. 

- **Privacy constraint:** DESP services operate on system and participant identifiers (hashed or pseudonymised where appropriate). DESP must not persist plain-text personal identifiers unless explicitly required and authorised by law.


### Detailed Definition: Digital Euro Access Gateway (`COMP-EUR-05`)

- **Role:** The Access Gateway is the canonical API surface of DESP. It acts as the single (or federated) entry point for supervised intermediaries to access DESP services. Public documentation and experimentation APIs describe DESP access via standard RESTful interfaces; the Access Gateway is the integration plane for those APIs.

- **Responsibilities:**
  - Authenticate and authorise intermediaries (PSPs/NCBs) and their system identities.
  - Validate request structure and semantics; enforce schema and policy checks.
  - Route authorised calls to appropriate DESP services (e.g. Alias Service, Settlement Engine, onboarding repo).
  - Provide platform-level controls: rate limiting, observability, audit logging, and request mediation.
  - Optionally expose sandbox or experimentation endpoints for prototype testing (DESP experimentation portals do this today). 

- **Non-responsibilities:**
  - MUST NOT perform customer-level KYC or store PII.
  - MUST NOT implement PSP-specific business logic; PSPs retain client-facing responsibilities (pre-validation, idempotency handling, user KYC).
  - MUST NOT become a data sink for personal data without legal authority.

- **Operational note:** The Access Gateway may be implemented and hosted by NCBs or contracted providers under Eurosystem authority; public materials discuss both central platform operation and experimentation setups for DESP. 


---

## 2. Intermediary Domain (PSP Infrastructure)

These components are operated by private sector banks/fintechs. They are the **only** components that see clear-text user data.

| ID | Component Name | Responsibility | Upstream Rule |
| :--- | :--- | :--- | :--- |
| **COMP-PSP-01** | **Digital Euro Gateway** | The main API gateway. Authenticates users, performs KYC, and acts as the secure connector to the Eurosystem Settlement Engine. | `actors-and-roles.md` |
| **COMP-PSP-02** | **Waterfall Engine** | Automates liquidity. Monitors wallet balance; triggers debits/credits to the commercial bank core when limits are breached (funding/defunding). | `liquidity-and-waterfall.md` |
| **COMP-PSP-03** | **Key Management System (KMS)** | Securely manages the cryptographic keys required to sign transactions on behalf of the user (if using a custodial model). | `security-and-privacy-zones.md` |

### Detailed Definition: Waterfall Engine (`COMP-PSP-02`)
* **Trigger:** Incoming payment > Holding Limit OR Outgoing payment > Current Balance.
* **Logic:**
    1.  Calculate shortfall or excess.
    2.  Lock commercial funds (atomic reservation).
    3.  Instruct Settlement Engine to fund/defund.
    4.  Confirm transaction.
* **Criticality:** High. Failure here causes "funding at risk" or "limit breach."

---

## 3. User Domain (End-User Device)

| ID | Component Name | Responsibility |
| :--- | :--- | :--- |
| **COMP-USR-01** | **Mobile Wallet App** | The UI for the citizen. Displays balance, scans QR codes, authorizes payments (biometrics). |
| **COMP-USR-02** | **Secure Element Applet** | (Optional) Hardware-based applet for offline storage and peer-to-peer transfer. |

---

## Traceability Matrix

| Component | Implements Logic From |
| :--- | :--- |
| `COMP-EUR-01` | **Rules:** Settlement finality, Integrity. |
| `COMP-EUR-02` | **Rules:** One Person/One Identity, Holding Limits. |
| `COMP-PSP-02` | **Rules:** Waterfall, Reverse Waterfall, Zero-Holding Merchant logic. |

## Spec-ready interfaces

The following interfaces are expected to be specified downstream:

- I_Onboarding → Alias Service
- I_Settlement → Settlement Engine
- I_Liquidity → Waterfall Engine
- I_Wallet → PSP Gateway

These interfaces are illustrative and non-authoritative.

