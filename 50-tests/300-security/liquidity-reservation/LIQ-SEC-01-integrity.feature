# artefact_type: evidence
# visibility: public
# audience: everyone
# form: text
# role: evidence
# status: normative
# owner: system-security
# DISCLAIMER: This content is illustrative and for educational purposes only.
# It demonstrates a methodology for structure and traceability.
# It does not represent the test scenarios or requirements of the official Digital Euro project or any other real project.
@spec=SPEC-LIQ-FUNC @spec=SPEC-LIQ-DATA @component=COMP-PSP-02
Feature: Liquidity Integrity & Security Controls
  As a Security Auditor
  I want to verify that the Waterfall Engine enforces strict financial integrity and privacy boundaries
  So that double-spending is impossible and internal banking IDs are never exposed

  Background:
    Given the Access Gateway (COMP-EUR-05) is active
    And I am monitoring the API traffic to the Eurosystem

  @trace=INT-LIQ-02 @trace=REQ-LIQ-01 @security_control=INTEGRITY
  Scenario: Prevention of Double-Funding (Reservation Reuse)
    # Attack: An attacker tries to use one bank lock to fund TWO digital wallets
    # Technique: Replay a valid reservation_proof with a NEW Idempotency Key
    Given I have successfully funded 10.00 EUR using reservation_proof "HASH_A"
    When I send a NEW "POST /fund" request with the SAME reservation_proof "HASH_A"
    And I provide a FRESH Idempotency-Key "UUID-NEW"
    Then the Access Gateway returns "409 Conflict"
    And the error code indicates "RESERVATION_ALREADY_USED"
    And no new Digital Euro liability is created

  @trace=DAT-PRI-01 @trace=SEC-LIQ-01 @security_control=DATA_MINIMIZATION
  Scenario: Privacy Firewall Enforcement (Internal ID Leakage)
    # Attack: The PSP Adapter implementation is lazy and sends the raw CBS ID
    Given I construct a Funding Payload
    But I include a forbidden field "cbs_reference": "DE-INTERNAL-123"
    When I send the "POST /fund" request
    Then the Access Gateway returns "400 Bad Request"
    And the error detail mentions "Forbidden field: cbs_reference"
    And the Security Audit Log records "PII_LEAK_ATTEMPT"

  @trace=ARCH-SEC-02 @security_control=AUTHORIZATION
  Scenario: Role-Based Access Control (Wrong Certificate)
    # Attack: Use a valid QWAC, but one that is only authorized for Onboarding
    Given I authenticate using a valid QWAC with role "ONBOARDING_AGENT"
    When I attempt to call "POST /fund"
    Then the Access Gateway returns "403 Forbidden"
    And the error indicates "Insufficient Role: LIQUIDITY_MANAGER required"
