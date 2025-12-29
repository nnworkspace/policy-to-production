# artefact_type: evidence
# visibility: public
# audience: everyone
# form: text
# role: evidence
# status: normative
# owner: system-quality

@spec=SPEC-OB-FUNC
@spec=SPEC-OB-INT
@component=COMP-EUR-05
Feature: User Identity Registration
  
  As a PSP Adapter (Zone A)
  I want to register an anonymised User Identity Hash
  So that I can onboard a customer while respecting the "One Person / One Identity" rule

  Background:
    Given the Access Gateway (COMP-EUR-05) is available
    And I have a valid QWAC certificate for "PSP-DE-001"

  @trace=TR-OB-03
  @trace=TR-OB-04
  @trace=OP-OB-01
  @trace=STEP-REG-01
  Scenario: Successful registration of a new user
    Given I have completed KYC for a user with National ID "PASSPORT:DE:123456789"
    And I have computed the deterministic Identity Hash according to Algo 6.1
    When I send a "POST /aliases" request with the Identity Hash
    Then the Access Gateway returns "201 Created"
    And the response payload contains a valid "alias_id"
    And the User State transitions from "CHECKING_ALIAS" to "ACTIVE"

  @trace=TR-OB-05
  @trace=REQ-OB-FUNC-05
  @trace=STEP-DUP-04
  @trace=Rule_ONB-01
  Scenario: Rejection of a duplicate identity
    Given the Identity Hash for "PASSPORT:FR:987654321" already exists in the Registry
    When I send a "POST /aliases" request with this existing Identity Hash
    Then the Access Gateway returns "409 Conflict"
    And the error code is "DUPLICATE_IDENTITY"
    And the User State transitions from "CHECKING_ALIAS" to "REJECTED"

  @trace=OP-OB-02
  @trace=INT-OB-04
  Scenario: Idempotent replay of registration
    Given I have successfully registered a user with Idempotency-Key "UUID-1234"
    When I resend the exact same "POST /aliases" request with Idempotency-Key "UUID-1234"
    Then the Access Gateway returns "201 Created"
    And the response body matches the original successful response
    And no new record is created in the Registry

    