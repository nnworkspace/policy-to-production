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
Feature: Participant Onboarding Submission
  
  As a PSP Integration Layer
  I want to submit a DRAFT participant application
  So that the Eurosystem can begin the verification process

  Background:
    Given the Onboarding Interface is available
    And I am authenticated as a valid PSP

  @trace=TR-03
  @trace=ONB-S-01
  @trace=OP-ONB-01
  Scenario: Successful submission of a valid draft
    Given a participant record exists with:
      | attribute | value           |
      | state     | DRAFT           |
      | bic       | DEUTDEFFXXX     |
      | role      | PSP             |
    And the record contains all mandatory fields defined in ONB-VAL-02
    When I request to SUBMIT the participant application
    Then the system accepts the request
    And the participant state transitions to SUBMITTED
    And an audit event is recorded with type "SUBMISSION"

  @trace=ONB-VAL-02
  @trace=INT-E-01
  Scenario: Rejection of incomplete application
    Given a participant record exists with:
      | attribute | value           |
      | state     | DRAFT           |
    But the record is missing the mandatory field "legal_name"
    When I request to SUBMIT the participant application
    Then the system rejects the request with error "VALIDATION_ERROR"
    And the participant state remains DRAFT

  @trace=ONB-GEN-02
  @trace=INT-E-01
  Scenario: Rejection of invalid state transition
    Given a participant record exists with:
      | attribute | value           |
      | state     | VERIFIED        |
    When I request to SUBMIT the participant application
    Then the system rejects the request with error "INVALID_TRANSITION"
    And the participant state remains VERIFIED

  @trace=ONB-GEN-03
  @trace=INT-G-04
  Scenario: Idempotent submission
    Given a participant record was successfully SUBMITTED
    And the client provides the same Idempotency Key
    When I request to SUBMIT the participant application again
    Then the system accepts the request
    But no new state transition occurs
    And the response matches the original successful result

