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
@spec=SPEC-OB-DATA @spec=SPEC-OB-INT @component=COMP-EUR-05
Feature: Onboarding Security Controls & Privacy Firewall
  As the System Security Officer
  I want to verify that the Access Gateway enforces strict input sanitization and authentication
  So that PII never breaches Zone B and unauthenticated requests are dropped immediately

  Background:
    Given the Access Gateway (COMP-EUR-05) is active
    And the Security Firewall rules are loaded

  @trace=INT-OB-01 @trace=DM-OB-03 @trace=Zone_B_Firewall @security_control=DATA_SANITIZATION
  Scenario: Prevention of PII leakage (Privacy Firewall)
    # This tests that the Gateway acts as a firewall for Zone B
    Given I have a valid Identity Hash
    But I maliciously construct a payload containing the Zone A field "full_name"
    When I send the "POST /aliases" request
    Then the Access Gateway returns "400 Bad Request"
    And the error details indicate "Forbidden field: full_name"
    And the audit log shows a "PII_LEAK_ATTEMPT" warning
    And no data is forwarded to the DESP Platform

  @trace=DAT-MSG-01 @trace=REQ-OB-FUNC-02 @security_control=INPUT_VALIDATION
  Scenario: Rejection of malformed hash (Input Validation)
    # This tests protection against injection or fuzzing attacks
    Given I have a payload with identity_hash "Invalid_Non_Hex_String_!@#"
    When I send the "POST /aliases" request
    Then the Access Gateway returns "400 Bad Request"
    And the error details mention "Pattern mismatch"

  @trace=INT-OB-02 @trace=SEC-OB-01 @security_control=AUTHENTICATION
  Scenario: Enforcement of KYC Attestation (Missing Signature)
    # This tests that the JWS signature is mandatory, not optional
    Given I have a valid payload
    But I strip the "JWS-Signature" header from the request
    When I send the "POST /aliases" request
    Then the Access Gateway returns "401 Unauthorized"
    And the response indicates "Missing JWS Signature"
