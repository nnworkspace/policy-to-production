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
It serves as the master inventory for the system. Every piece of code or infrastructure in the `50-code` layer must map to one of these components.

## Naming Convention
Components are identified by ID: `COMP-<DOMAIN>-<ID>`.
* `EUR`: Eurosystem (Central Infrastructure)
* `PSP`: Payment Service Provider (Intermediary)
* `USR`: User Domain

---

## 1. Eurosystem Domain (Central Infrastructure)

These components are operated by the Eurosystem. They see *transaction values* but not *real-world identities*.

| ID | Component Name | Responsibility | Upstream Rule |
| :--- | :--- | :--- | :--- |
| **COMP-EUR-01** | **Settlement Engine** | The core ledger. Validates digital signatures, prevents double-spending, and moves value between wallet addresses. | `actors-and-roles.md` |
| **COMP-EUR-02** | **Alias Service** | Maintains the registry of "Hashed User IDs" to enforce the Single Identity Rule. Checks holding limits across different PSPs without revealing PII. | `functional-onboarding.md` |
| **COMP-EUR-03** | **Dispute Management System** | Allows PSPs to flag fraudulent transactions or technical errors for resolution. | *N/A (Future Scope)* |

### Detailed Definition: Alias Service (`COMP-EUR-02`)
* **Input:** An anonymised hash of a user's national ID (provided by the PSP).
* **Logic:** Checks if this hash is already active. If yes, returns the existing Wallet ID (or error, depending on portability rules).
* **Privacy Constraint:** MUST NOT store plain-text names, addresses, or tax IDs.

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


