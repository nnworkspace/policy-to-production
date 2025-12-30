---
artefact_type: code
visibility: restricted
audience:
  - NCB
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

# Digital Euro Service Platform (DESP)

**Component ID:** `COMP-EUR-04`  
**Owner:** Eurosystem Development Team  
**Stack:** Java 17 / Spring Boot 3

## Overview
The DESP is the "Backend of Backends." It is the central technical platform that coordinates the issuance, settlement, and redemption of the Digital Euro.

It hosts the **Settlement Engine** (`COMP-EUR-01`), which is the authoritative ledger for all value movements.

## Boundaries
*   **Protected**: This component **NEVER** communicates directly with the public internet. All traffic MUST be mediated by the **Access Gateway** (`COMP-EUR-05`).
*   **Privacy**: This component processes `System IDs` and `Hash Aliases`. It **MUST NOT** process or persist clear-text citizen identities (PII).

## Architecture
This implementation uses a standard Hexagonal (Ports & Adapters) architecture:

*   `api`: Inbound adapters (gRPC/REST controllers).
*   `domain`: Pure business logic (Settlement, Liquidity Rules).
*   `infrastructure`: Outbound adapters (Database, Messaging).

## Traceability
This code realizes requirements defined in:
*   `SPEC-SET-CORE`: Settlement Logic
*   `SPEC-LIQ-FUNC`: Liquidity/Waterfall Logic

See `manifest.yaml` for the complete machine-readable contract.
