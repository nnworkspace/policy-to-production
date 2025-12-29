# artefact_type: test
# visibility: public
# audience: everyone
# form: source
# role: test
# status: informative
# owner: system-quality

@spec=SPEC-FUNC
@spec=SPEC-INT
@component=COMP-EUR-04
Feature: Participant Activation and Key Exchange
  
  As a Eurosystem Operator or Authorised System
  I want to ACTIVATE a verified participant
  So that they can begin operational connectivity

  Background:
    Given the Onboarding Interface is available
    And I am authenticated as an Administrator

  @trace=TR-06
  @trace=ONB-A-01
  @trace=OP-ONB-03
  Scenario: Successful activation with valid keys
    Given a participant record exists with:
      | attribute | value           |
      | state     | VERIFIED        |
      | jwks_url  | https://psp.com/jwks |
    And the external JWKS endpoint is reachable and valid
    When I request to ACTIVATE the participant
    Then the system performs a technical reachability check
    And the system accepts the request
    And the participant state transitions to ACTIVE
    And the participant's public keys are cached for operations

  @trace=ONB-VAL-03
  @trace=INT-E-01
  Scenario: Activation blocked by unreachable keys
    Given a participant record exists with:
      | attribute | value           |
      | state     | VERIFIED        |
      | jwks_url  | https://psp.com/404  |
    But the external JWKS endpoint returns 404 Not Found
    When I request to ACTIVATE the participant
    Then the system rejects the request with error "KEY_FETCH_FAILED"
    And the participant state remains VERIFIED

  @trace=ONB-GEN-02
  @trace=INT-E-01
  Scenario: Rejection of activation for unverified participant
    Given a participant record exists with:
      | attribute | value           |
      | state     | SUBMITTED       |
    When I request to ACTIVATE the participant
    Then the system rejects the request with error "INVALID_LIFECYCLE_STATE"
    And the participant state remains SUBMITTED

    