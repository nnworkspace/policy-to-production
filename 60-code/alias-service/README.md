---
artefact_type: code
visibility: restricted
audience:
  - ECB
  - PSP
form: text
role: implementation
status: normative
owner: ECB
---

<!-- 
DISCLAIMER:
The code in this folder is **illustrative and educational**.
It does not represent official implementations, production-ready components,
or endorsed technical approaches for the Digital Euro or any other real-world system.

PURPOSE:
This component serves as a reference implementation to demonstrate how technical
specifications are refined into code while maintaining strict auditability,
traceability, and mechanical governance across distinct institutional boundaries.
This structure enables automated compliance verification and live impact analysis.
-->

# Digital Euro Alias Service

**Component ID:** `COMP-EUR-02`  
**Owner:** Eurosystem (ECB)  
**Stack:** Rust 1.75

## Overview
The Alias Service is a high-performance **Privacy Oracle**. It enables PSPs to route payments using end-user aliases (e.g., Email, Phone) without exposing the underlying account identifiers to the sender.

## Responsibilities
1.  **Blinded Lookup**: Resolves Hashed Aliases to Routing Information.
2.  **Privacy Protection**: Ensures that the oracle itself cannot reverse-engineer the aliases (via Salt/Pepper rotation).
3.  **High Throughput**: Designed for millions of lookups per second using Rust/Tokio.

## Traceability
*   `SPEC-ALIAS-LOOKUP`: The resolution protocol.
