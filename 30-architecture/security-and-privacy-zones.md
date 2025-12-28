---
artefact_type: architecture
visibility: public
audience: everyone
form: text
role: architecture
status: normative
owner: system-architect
---

# Security and Privacy Zones

## Purpose
This document defines the **Trust Boundaries** and **Data Visibility Zones** within the Digital Euro ecosystem.

Its primary purpose is to strictly enforce the **"Privacy Firewall"** mandated by the Regulation: ensuring that the central settlement infrastructure cannot infer private user behavior, while allowing Intermediaries to perform full AML/CFT checks.



## 1. The Three Security Zones

The architecture is partitioned into three distinct zones with different security models and data visibility rules.

### Zone A: The Intermediary Zone (PSP)
- **Trust Model:** High Confidentiality (GDPR + Banking Secrecy).
- **Data Sensitivity:** **HIGH** (Contains PII).
- **Actors:** Commercial Banks, Payment Institutions.
- **Data Visibility:**
    - **Can see:** Real-world identities (Names, Tax IDs), Commercial bank account numbers (IBANs), Transaction history of *their* customers.
    - **Cannot see:** Transaction history of users at *other* PSPs (except for the counterparty data required for the specific payment).

### Zone B: The Eurosystem Zone (Settlement)
- **Trust Model:** High Integrity & Availability (Critical Infrastructure).
- **Data Sensitivity:** **PSEUDONYMOUS** (No PII).
- **Actors:** ECB, NCBs.
- **Data Visibility:**
    - **Can see:** Wallet Addresses, Transaction Amounts, Settlement Timestamps, Aggregate Flows.
    - **Cannot see:** Real-world identities, User location data, Commercial bank account details.
    - **Constraint:** The Eurosystem MUST NOT be technically capable of linking a Wallet Address to a Natural Person without the cooperation of the PSP (e.g., via a legal warrant).

### Zone C: The User Zone (Device)
- **Trust Model:** Local Control (Zero Trust).
- **Actors:** Mobile App, Secure Element.
- **Data Visibility:**
    - **Can see:** Own balance, Own transaction history (locally stored).



## 2. The Privacy Firewall (Unlinking Mechanism)

The "Privacy Firewall" is not a physical box, but a set of cryptographic and architectural constraints that separate Zone A from Zone B.

### Mechanism 1: Identity Hashing (Alias Service)
- **Requirement:** The Eurosystem needs to enforce holding limits across multiple PSPs.
- **Implementation:**
    - The PSP computes a **One-Way Hash** of the user's stable national identifier (e.g., `SHA-256(Salt + TaxID)`).
    - This hash is sent to the Eurosystem's **Alias Service** (`COMP-EUR-02`).
    - The Eurosystem sees only the hash `a1b2c3...`. It knows "Hash `a1b2c3` owns 2000 EUR," but not who `a1b2c3` is.

### Mechanism 2: Tokenisation of Settlement Instructions
- **Requirement:** Settlement must occur without revealing the "Reason for Payment."
- **Implementation:**
    - Payment instructions sent to `COMP-EUR-01` (Settlement Engine) contain only technical addressing: `SenderWalletID`, `ReceiverWalletID`, `Amount`.
    - Remittance information (e.g., "For Invoice #1234") is End-to-End Encrypted (E2EE) between Payer PSP and Payee PSP, or stripped entirely and handled out-of-band. The Settlement Engine treats this field as an opaque blob.



## 3. Data Visibility Matrix

This matrix defines the *Maximum Knowledge* allowed for each actor.

| Data Element | PSP (Intermediary) | Eurosystem (Central) | End User |
| :--- | :--- | :--- | :--- |
| **User Real Name** | ✅ Visible | ❌ **FORBIDDEN** | ✅ Visible |
| **National ID / Tax ID** | ✅ Visible | ❌ **FORBIDDEN** | ✅ Visible |
| **User Identity Hash** | ✅ Visible | ✅ Visible (Opaque) | ❌ N/A |
| **Wallet Address** | ✅ Visible | ✅ Visible | ✅ Visible |
| **Transaction Amount** | ✅ Visible | ✅ Visible | ✅ Visible |
| **Commercial IBAN** | ✅ Visible | ❌ **FORBIDDEN** | ✅ Visible |
| **Counterparty Name** | ✅ Visible | ❌ **FORBIDDEN** | ✅ Visible |



## 4. Key Management & Custody

Security relies on who holds the keys to sign transactions.

### Online Scenario (Custodial / Hybrid)
- **Zone:** Intermediary Zone (`COMP-PSP-03`).
- **Model:** The PSP typically manages the cryptographic keys on behalf of the user for usability and recovery.
- **Constraint:** Operations must be authenticated by the user (e.g., via 2-Factor Authentication) before the PSP signs the settlement instruction.

### Offline Scenario (Non-Custodial)
- **Zone:** User Zone (`COMP-USR-02`).
- **Model:** Keys are stored in a **Secure Element** (Hardware) on the user's device.
- **Constraint:** Neither the PSP nor the Eurosystem has access to these keys. Value is transferred peer-to-peer.

