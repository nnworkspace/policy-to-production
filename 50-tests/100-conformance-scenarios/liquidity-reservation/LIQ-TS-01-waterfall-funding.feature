# artefact_type: evidence
# visibility: public
# audience: everyone
# form: text
# role: evidence
# status: normative
# owner: system-quality
# DISCLAIMER: This content is illustrative and for educational purposes only.
# It demonstrates a methodology for structure and traceability.
# It does not represent the test scenarios or requirements of the official Digital Euro project or any other real project.
@spec=SPEC-LIQ-FUNC @spec=SPEC-LIQ-INT @component=COMP-PSP-02
Feature: Liquidity Waterfall (Automated Funding)
  As a PSP Waterfall Engine (Zone A)
  I want to atomically fund a Digital Euro wallet using a Commercial Bank Money reservation
  So that the user can make payments without pre-funding
  And the scheme guarantees solvency ("No Funding at Risk")

  Background:
    Given the Access Gateway (COMP-EUR-05) is operational
    And I have a valid QWAC certificate
    And I have established a secure session

  @trace=TR-LIQ-04 @trace=TR-LIQ-05 @trace=OP-LIQ-01 @trace=STEP-WAT-02
  Scenario: Successful Atomic Waterfall
    # Happy Path: Lock -> Fund -> Capture
    Given a user initiates a payment requiring 10.00 EUR
    And I have successfully locked 10.00 EUR in the Core Banking System
    And I have generated a "reservation_proof" (Hash)
    When I send a "POST /fund" request with amount 1000 and the reservation proof
    Then the Access Gateway returns "200 OK"
    And the response payload contains a "settlement_ref"
    And the Internal Reservation transitions to "SETTLED"
    And I trigger "CaptureFunds" on the Core Banking System

  @trace=TR-LIQ-06 @trace=REQ-LIQ-02 @trace=Rule_LIQ-01
  Scenario: Atomic Rollback on Eurosystem Rejection
    # Critical Negative Path: Lock -> Fund Fail -> Void
    Given I have successfully locked 50.00 EUR in the Core Banking System
    When I send a "POST /fund" request with amount 5000
    But the Access Gateway returns "403 Forbidden" (Limit Breach)
    Then the Internal Reservation transitions to "ROLLING_BACK"
    And I immediately trigger "VoidLock" on the Core Banking System
    And the final Internal Reservation status is "FAILED"
    And the Commercial Funds are released to the user

  @trace=INT-LIQ-02
  Scenario: Idempotent Retry of Funding
    Given I have sent a funding request with Idempotency-Key "UUID-555"
    And the request timed out
    When I resend the exact same request with Idempotency-Key "UUID-555"
    Then the Access Gateway returns the original response
    And no double-funding occurs in the Settlement Engine
