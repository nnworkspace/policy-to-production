/*
 * artefact_type: implementation
 * visibility: public
 * audience: everyone
 *   - ECB
 *   - VENDOR
 * form: source
 * role: implementation
 * status: normative
 * owner: eurosystem
 *
 * DISCLAIMER: 
 * The code in this folder is **illustrative and educational**.
 * It does not represent official implementations, production-ready components,
 * or endorsed technical approaches for the Digital Euro or any other real-world system.
 */
package eu.digitaleuro.governance.tracing;

import java.lang.annotation.*;

/**
 * Declares an explicit, version-aware traceability link between a code element
 * and a normative specification artefact.
 *
 * <p>
 * This annotation is part of the <b>Governance SDK</b>. It allows automated
 * tooling to:
 * </p>
 *
 * <ul>
 *   <li>establish bidirectional traceability between specifications and code,</li>
 *   <li>detect implementation gaps and specification drift,</li>
 *   <li>enforce governance rules (e.g. no orphan code),</li>
 *   <li>and derive audit and compliance evidence without inspecting business logic.</li>
 * </ul>
 *
 * <p>
 * {@code @SpecLink} is a governance primitive. It does not define behaviour;
 * it declares intent and accountability.
 * </p>
 */
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.TYPE, ElementType.METHOD, ElementType.FIELD})
@Repeatable(SpecLinks.class)
public @interface SpecLink {

    /**
     * The Global ID of the Specification Document.
     * Example: "SPEC-OB-FUNC"
     */
    String specId();

    /**
     * The Specific Requirement, Step, or Transition ID.
     * Example: "REQ-OB-FUNC-04" or "STEP-REG-05"
     */
    String refId();

    /**
     * The version of the spec being implemented.
     */
    String version() default "current";
}

