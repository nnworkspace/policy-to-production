/*
 * artefact_type: governance
 * visibility: public
 * audience: everyone
 * form: source
 * role: governance
 * status: normative
 * owner: eurosystem
 *
 * DISCLAIMER:
 * The code in this folder is **illustrative and educational**.
 * It does not represent official implementations, production-ready components,
 * or endorsed technical approaches for the Digital Euro or any other real-world system.
 */

extern crate proc_macro;
use proc_macro::TokenStream;

/// Declares an explicit, version-aware traceability link between a code element
/// and a normative specification artefact.
///
/// This attribute does not alter the runtime behavior of the code. It serves as
/// a machine-readable marker for governance tooling, audits, and drift detection.
///
/// # Arguments
///
/// * `spec_id` - The Global ID of the Specification Document (e.g., "SPEC-LEDGER-001").
/// * `ref_id` - The Specific Requirement or Step ID (e.g., "REQ-SETTLEMENT-05").
/// * `version` - (Optional) The version of the spec being implemented. Defaults to "current".
///
/// # Example
///
/// ```rust,ignore
/// #[spec_link(spec_id = "SPEC-LEDGER-001", ref_id = "REQ-01", version = "1.0.0")]
/// struct Ledger;
/// ```
#[proc_macro_attribute]
pub fn spec_link(_attr: TokenStream, item: TokenStream) -> TokenStream {
    // In a production implementation, this macro could:
    // 1. Parse the `_attr` to validate that `spec_id` and `ref_id` are provided.
    // 2. Emit compile-time checks or generate sidecar metadata.
    //
    // For this illustrative workbench, we implement it as a "Governance Marker".
    // We return the `item` (the annotated code) exactly as is.
    //
    // This ensures the code compiles and runs normally, while the source code
    // retains the structured metadata for static analysis tools (linters)
    // to enforce traceability rules.
    
    item
}