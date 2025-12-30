---
artefact_type: report
visibility: public
audience: everyone
form: text
role: evidence
status: informative
owner: project-governance
---

# Reports (Derived Project Evidence)

This folder contains **derived reports** generated from the artefacts, activities, and automation of the project workbench.

Reports are **not primary artefacts**. They are *views*, *summaries*, and *evidence snapshots* produced from the authoritative sources elsewhere in the repository.

Their purpose is to make progress, coverage, and compliance **legible at a glance**, especially for non-technical stakeholders.

## Purpose

In large institutional projects, decision-makers rarely need to read:

- every specification,
- every issue discussion,
- or every line of code.

What they need is **confidence**:
- that work is progressing,
- that obligations are covered,
- and that risks are visible.

The purpose of this folder is to provide that confidence through **automatically derived, auditable reports**.

## Nature of reports

Reports in this folder are:

- **generated**, not authored manually,
- **derived**, not sources of truth,
- **time-bound**, not continuously edited.

They may summarise, for example:

- specification coverage by tests,
- feature progress across components,
- security and operational assurance status,
- recent activity across multiple workstreams,
- outstanding gaps or risks.


## Typical contents

This folder may contain:

- periodic status summaries (e.g. weekly or milestone reports),
- coverage matrices derived from traceability metadata,
- assurance dashboards rendered as static artefacts,
- audit-ready snapshots of project state at a given point in time.

The exact format may vary, but reports should remain **readable without specialised tooling**.

## Relationship to automation

Reports are typically produced by:

- CI/CD pipelines,
- scheduled jobs,
- or administrative tooling.

They are generated from:

- specifications,
- manifests,
- code metadata,
- test results,
- and governance artefacts.

No report should introduce new requirements or interpretations. If a report reveals a problem, the corrective action must occur in the upstream artefacts.

## What does not belong in this folder

The following do **not** belong here:

- manually curated project documentation,
- working notes or drafts,
- raw logs or test outputs,
- configuration files for report generation.

Those artefacts belong in governance, code, or tooling locations.

This folder contains **results**, not mechanisms.

## Traceability and auditability

Each report SHOULD clearly state:

- what inputs it was derived from,
- the point in time or version it represents,
- and the automation or process that produced it.

Because reports are derived, they remain auditable even if underlying artefacts are restricted or distributed across repositories.

## Intent

The intent of this folder is to demonstrate that **institutional transparency does not require manual reporting**.

When artefacts are structured, classified, and traceable, meaningful reports can be generated automatically — reducing friction, increasing trust, and allowing leaders to focus on decisions rather than data collection.

## Disclaimer

The reports in this folder are **illustrative and educational**.

They demonstrate how project evidence might be summarised in a complex institutional system. They do not represent official reporting formats, audit deliverables, or management dashboards for the Digital Euro or any other real-world project.


