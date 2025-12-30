---
artefact_type: documentation
visibility: public
audience: everyone
form: text
role: governance
status: informative
owner: ci-cd-automation
---

<!--
# ------------------------------------------------------------------------------
# DISCLAIMER:
# This file is an ILLUSTRATIVE EXAMPLE of "AI Governance".
# ------------------------------------------------------------------------------
-->

# AI Governance Oracle (Prototype)

This directory contains the prototypes for an **AI-driven Compliance Assistant**.

## Philosophy

Institutional projects are complex. Developers cannot memorize 1,000 pages of rules.
We use AI not to write code, but to **navigate bureaucracy**.

## Components

### `knowledge_indexer.py`
- Scans `20-rulebook`, `30-architecture`, `40-specifications`.
- Chunks text by headers.
- Builds a `knowledge_base.json` (Mock Vector Store).

### `policy_bot.py`
- CLI Interface for developers.
- Usage: `python policy_bot.py "Can I use public cloud?"`
- Logic: Retrieves relevant chunks from the Knowledge Base and analyzes compliance.

## Usage

1. **Train**:
   ```bash
   python3 knowledge_indexer.py
   ```

2. **Ask**:
   ```bash
   python3 policy_bot.py "Can I store PII in headers?"
   ```
