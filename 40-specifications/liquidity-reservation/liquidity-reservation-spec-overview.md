---
artefact_type: specification
visibility: public
audience: everyone
form: text
role: specification
status: normative
owner: system-design
---

# Specification Overview: Liquidity Reservation & Waterfall

## 1. Identification
- **Global ID:** `SPEC-LIQ-ROOT`
- **Part of Set:** `SPEC-SET-LIQ`
- **Version:** Inherits from `manifest.yaml`

## 2. Purpose and Scope
This document defines the **technical scope** for the automated liquidity management mechanisms known as "Waterfall" and "Reverse Waterfall".

It translates the high-level policy rules defined in the **Scheme Rulebook** into concrete technical requirements, ensuring that the bridge between Commercial Bank Money and Central Bank Money functions atomically and securely.

### 2.1 In Scope
- **Waterfall (Funding):** The logic to detect a payment shortfall, reserve funds in the Commercial Bank Core (`COMP-PSP-02`), and instruct the Eurosystem to **fund** the difference (`Rule LIQ-01`).
- **Reverse Waterfall (Defunding):** The logic to detect a Holding Limit breach, **defund** the excess Digital Euro, and credit the Commercial Bank Core (`Rule LIQ-02`).
- **Zero-Holding Logic:** The specific configuration for Merchants who opt to automatically defund all incoming payments immediately (`Rule LIQ-03`).
- **Double-Spending Prevention (Liquidity Side):** Ensuring that commercial funds reserved for a Digital Euro funding cannot be spent elsewhere during the transition.

### 2.2 Out of Scope
- **Inter-PSP Settlement:** The actual movement of Digital Euro between wallets (covered in `SPEC-SET-STL`).
- **Offline Limits:** Management of offline secure element limits (covered in `SPEC-SET-OFF`).
- **Manual Top-Ups:** User-initiated funding via the mobile app UI (treated as a standard Waterfall event, but triggered differently).

## 3. Normative References (Upstream Traceability)

The requirements in this specification set are derived **exclusively** from the following mandated baselines.

### 3.1 Legal & Rulebook Basis
This specification satisfies the mandates of **Rulebook Set v0.9.0** (`@rule=SET-RULEBOOK:0.9.0`).

| Rule ID | Rule Name | Upstream Source |
| :--- | :--- | :--- |
| **LIQ-01** | **Waterfall (Auto-Funding)** | [`liquidity-and-waterfall.md`](../../20-rulebook/liquidity-and-waterfall.md) |
| **LIQ-02** | **Reverse Waterfall (Defunding)** | [`liquidity-and-waterfall.md`](../../20-rulebook/liquidity-and-waterfall.md) |
| **LIQ-03** | **Zero-Holding Option** | [`liquidity-and-waterfall.md`](../../20-rulebook/liquidity-and-waterfall.md) |
| **LIQ-04** | **Holding Limits** | [`functional-onboarding.md`](../../20-rulebook/functional-onboarding.md) |

### 3.2 Architectural Basis
This specification adheres to the components and security zones defined in **Architecture Set v0.1.0** (`@arch=SET-ARCH:0.1.0`).

| Component ID | Name | Role in Liquidity |
| :--- | :--- | :--- |
| **COMP-PSP-02** | **Waterfall Engine** | The orchestrator of the "Two-Phase Commit" between Commercial and Central systems. |
| **COMP-PSP-01** | **PSP Adapter** | The interface layer sending the Funding/Defunding instructions to the Gateway. |
| **COMP-EUR-01** | **Settlement Engine** | The target system executing the funding/defunding (Zone B). |
| **COMP-EUR-05** | **Access Gateway** | The API entry point for all Eurosystem services. |

## 4. Document Map (The Set)

The specification is split into three orthogonal views to ensure clarity and linting enforcement.

| View | Document | Global ID | Purpose |
| :--- | :--- | :--- | :--- |
| **Behavior** | [`liquidity-reservation-functional-spec.md`](./liquidity-reservation-functional-spec.md) | **SPEC-LIQ-FUNC** | **"The Logic"**<br>Defines the Reservation State Machine (e.g., `RESERVING` -> `LOCKED`) and shortfall calculations. |
| **Data** | [`liquidity-reservation-data-model-spec.md`](./liquidity-reservation-data-model-spec.md) | **SPEC-LIQ-DATA** | **"The Schema"**<br>Defines the `LiquidityLock` and `FundingInstruction` entities. |
| **Interfaces** | [`liquidity-reservation-interfaces-spec.md`](./liquidity-reservation-interfaces-spec.md) | **SPEC-LIQ-INT** | **"The Flow"**<br>Sequence diagrams for `I_Funding` and `I_Settlement`. |

## 5. Design Principles

### 5.1 Atomicity & Safety
In accordance with `Rule LIQ-01`, the conversion between Commercial Money and Digital Euro must be atomic.
- **Mechanism:** A "Reservation and Commit" pattern.
- **Constraint:** Funds MUST be strictly locked in the Commercial Core *before* the request to **Fund** is sent to the Eurosystem.

### 5.2 Priority of Defunding
In accordance with `Rule LIQ-02`, Holding Limits are hard constraints.
- **Mechanism:** If an incoming payment causes a limit breach, the system MUST accept the payment and *immediately* trigger a Reverse Waterfall for the excess amount.
- **Constraint:** User balances must never exceed the holding limit at the end of a transaction processing cycle.

---

## Appendix: How to Parse This Specification

**For Automation Engineers:**

1.  **Suite Discovery:**
    - Parse **Section 4 (Document Map)**.
    - Extract the `Global ID` and `Document` path for each row.
    - *Usage:* This allows your CI tools to dynamically discover all files belonging to `SPEC-SET-LIQ` without hardcoding filenames.

2.  **Dependency Validation (Linting):**
    - Parse **Section 3.1** to find the `@rule` tag.
    - Check that this version matches the `version` field in `20-rulebook/manifest.yaml`.
    - Parse **Section 3.2** to find the `@arch` tag.
    - Check that this version matches the `version` field in `30-architecture/manifest.yaml`.
    - *Alert:* If versions mismatch, fail the build with `SpecDriftError`.

3.  **Traceability Auditing:**
    - Extract all **Rule IDs** (e.g., `LIQ-01`, `LIQ-02`) listed in the table in **Section 3.1**.
    - Scan the child specifications (`SPEC-LIQ-FUNC`, `SPEC-LIQ-INT`) defined in the Document Map.
    - *Validation:* Warn if any Rule listed in the Overview is **not** referenced in the child specifications (indicating a missing requirement implementation).

    