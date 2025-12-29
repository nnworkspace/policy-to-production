---
artefact_type: code
visibility: public
audience: everyone
form: text
role: implementation
status: informative
owner: engineering
---

# Code (Illustrative Implementations)

This folder contains **illustrative source code** that demonstrates how
technical specifications are realised across **multiple cooperating components**
in a large institutional system.

It is not a single application.  
It is not a complete implementation.  
It is a **workbench**.

The purpose of this folder is to make visible how real-world institutional
software is *assembled*, governed, and evolved over time.

---

## A note on institutional reality

Large public-sector systems are not built as one cohesive codebase.

They emerge from collaboration between:

- central institutions,
- national operators,
- external vendors,
- and regulated participants.

Each party owns **components**, not features.

Each component:
- has its own lifecycle,
- its own technology stack,
- its own delivery cadence,
- and its own contractual and governance boundaries.

This folder is structured to reflect that reality.

---

## Organisation principle

### Components first — not features

The top-level folders under `50-code/` represent **technical components**,
not business features.

```text
50-code/
├── access-gateway/
├── alias-service/
├── desp/
├── psp-1/
└── README.md
```
This mirrors how responsibilities are assigned in practice:

- components are owned by specific organisations,
- features cut across multiple components,
- no single team “owns” a feature end-to-end.

## Where features appear

Features (such as onboarding or liquidity reservation) **do not get their own top-level folders**.

Instead, feature-related logic appears **inside each component**, in locations dictated by that component’s technology stack.

For example, onboarding-related behaviour may exist in:

- the access gateway,
- the alias service,
- a central processing component,
- and a PSP-side adapter,

each expressed differently, but all traceable to the same specifications.

## A note on repositories and boundaries

In a real institutional programme, each component shown here would **almost always live in its own repository**, often hosted on:

- separate GitLab or GitHub instances,
- with access controls aligned to contractual, regulatory, or security constraints,
- and with independent release and approval processes.

It reflects organisational reality and enables clear ownership.

This repository deliberately uses **subfolders under `50-code/`** to illustrate those components **side by side**, for pedagogical purposes.

The goal is to allow readers to:

- understand the full system without navigating dozens of repositories,
- see how specifications map to multiple implementations,
- and observe how traceability is preserved across organisational boundaries.

The folder structure here represents **logical structure**, not deployment topology.


## Technology stacks

Each component is free to choose a technology stack appropriate to its role:

- performance-critical services may use JVM or native stacks,
- integration-facing components may use web-oriented stacks,
- PSP-side components may reflect vendor or market preferences.

For this repository, stacks are chosen **illustratively**. The goal is not realism of implementation, but realism of **structure and governance**.


## Relationship to specifications and tests

Code in this folder is always **downstream** of specifications.

Every meaningful piece of source code SHOULD be traceable to:

- one or more specification identifiers,
- the exact version of those specifications,
- and the assurance artefacts that validate it.

This folder does not define behaviour; it **realises behaviour defined elsewhere**.

## What belongs in this folder

This folder may contain:

- minimal source files illustrating component responsibilities,
- interface adapters corresponding to published APIs,
- skeletal business logic tied to specific specifications,
- README files explaining component scope and ownership.

The code is intentionally partial. Completeness is not the goal — traceability is.

## What does not belong in this folder

The following do **not** belong here:

- full production implementations,
- environment-specific configuration,
- deployment scripts,
- large unit test suites,
- operational tooling.

Those artefacts exist in real projects, but are outside the educational scope of this repository.

## Intent

The intent of this folder is to show that:

- large systems are composed, not coded monolithically,
- governance matters as much as technology,
- and clarity of structure enables collaboration across institutions.

When code is organised in this way, it becomes easier to audit, evolve, and trust.


## Disclaimer

The code in this folder is **illustrative and educational**.

It does not represent official implementations, production-ready components, or endorsed technical approaches for the Digital Euro or any other real-world system.



