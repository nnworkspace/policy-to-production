---
artefact_type: rulebook
visibility: public
audience: 
  - PSP
  - VENDOR
form: text
role: rule
status: normative
owner: rulebook-development-group
---

# Liquidity Management and Waterfall Functionality

## Source Reference
**Draft Digital Euro Scheme Rulebook V0.9** — Section 6 (Liquidity Management).

## Purpose
This document defines the automated funding and defunding mechanisms ("Waterfall" and "Reverse Waterfall") that ensure seamless payments and compliance with holding limits.

---

## 1. Core Concepts
### Funding & Defunding
- **Funding:** Converting commercial bank money (or cash) into digital euro.
- **Defunding:** Converting digital euro back into commercial bank money (or cash).
- These operations MUST be performed at par (1:1 conversion).

## 2. Waterfall Functionality (Automated Funding)
**Rule LIQ-01:** Transaction Completion.
- If a user attempts a payment exceeding their current digital euro balance, the Waterfall function MAY automatically pull the shortfall from their linked commercial bank account.
- **Condition:** The user must have explicitly consented to and configured this functionality.
- **Atomicity:** The funding and the payment MUST appear as a single atomic transaction to the user (no "top-up then pay" friction).

## 3. Reverse Waterfall (Automated Defunding)
**Rule LIQ-02:** Holding Limit Enforcement.
- If an incoming transaction causes a user's balance to exceed their **Holding Limit**, the excess amount MUST be automatically defunded.
- The excess is transferred immediately to the user's designated commercial bank account.

**Rule LIQ-03:** Zero-Holding Merchants.
- Merchants typically have a holding limit of **zero**.
- **Effect:** Every payment received by a merchant implies an immediate, automated reverse waterfall of the full amount to their commercial bank account.

## 4. Holding Limits
**Rule LIQ-04:** Enforcement.
- Holding limits apply to **natural persons**, not just accounts.
- Systems MUST check the aggregate balance of a user across all intermediaries (if multiple accounts are permitted) or enforce the limit per user identity.
- Incoming payments that would breach the limit without a configured Reverse Waterfall MUST be rejected.

