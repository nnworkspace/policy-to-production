---
artefact_type: governance
visibility: public
audience: everyone
form: text
role: governance
status: normative
owner: project-governance
---

# Git Branching Strategy

## Scope

This strategy applies strictly to the **Central Governance Repository**.

Other components of the project (such as specific microservices, mobile apps, or gateways) are free to adopt branching strategies that fit their specific engineering lifecycles and deployment needs, provided they respect the release governance defined here.

## Introduction: What is Branching?

For those new to Git, it is helpful to think of a **branch** as a "parallel universe" for your work.

Imagine a shared document that hundreds of people need to edit. If everyone typed into the same master file at the same time, the result would be chaos. You would see half-finished sentences, typo corrections, and conflicting ideas appearing and disappearing in real-time.

Git solves this with **branches**.

1.  **The Main Timeline (`main`)**: This is the official, clean, "published" version of the project. It is always stable.
2.  **A Draft Timeline (Your Branch)**: When you want to make a change, you create a new branch. This is your personal sandbox—a copy of the world where you can make messy edits, break things, fix them, and polish your work without affecting anyone else.

Only when your draft is perfect and has been reviewed do you "merge" it back into the main timeline.

## The Strategy: Protected Main + Feature Branches

We adopt a simplified **Feature Branch Workflow** (often called GitHub Flow).

### 1. The `main` Branch

*   **Role**: The single source of truth.
*   **Status**: Always deployable (or "publishable").
*   **Protection**: Direct pushes to `main` are **forbidden**. All changes must come via Pull Request (Merge Request).

### 2. Feature Branches

*   **Role**: Temporary workspaces for specific tasks.
*   **Naming Convention**:
    *   `feat/<short-description>` (New content or logic)
    *   `fix/<short-description>` (Corrections)
    *   `docs/<short-description>` (Documentation updates)
    *   `chore/<short-description>` (Maintenance)
*   **Lifespan**: Short-lived. Deleted after merge.

### 3. The Release Mechanism

We do not use long-lived `release` branches. Instead, we use **Git Tags** to mark specific points in history as "Ratified Versions".

*   **Draft**: The tip of `main` is always the current "Working Draft".
*   **Release**: A signed tag (e.g., `v1.0.0`) marks a specific commit as a stable, normative release.

## Workflow

1.  **Branch Off**: `git checkout -b feat/add-audit-policy`
2.  **Commit**: Make changes and commit (following [Commit Conventions](./commit-message-conventions.md)).
3.  **Push**: Push the branch to the remote.
4.  **Open PR**: Open a Pull Request targeting `main`.
5.  **Review**: Discuss and refine the change.
6.  **Merge**: Once approved, merge into `main` (Squash & Merge is preferred to keep history linear).

## Traceability

Every branch and Pull Request must ultimately trace back to an **Issue**.
This link is enforced at the commit level (via `refs: #id`), but the branch name should also reflect the intent of the work.


