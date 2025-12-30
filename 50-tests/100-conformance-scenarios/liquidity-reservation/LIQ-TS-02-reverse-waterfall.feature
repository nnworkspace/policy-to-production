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
Feature: Reverse Waterfall (Automated Defunding)
  As a PSP Waterfall Engine (Zone A)
  I want to automatically defund Digital Euro holdings that exceed the user's limit
  So that I stay compliant with "Rule LIQ-02" (Reverse Waterfall)

  Background:
    Given the Access Gateway (COMP-EUR-05) is operational
    And I have a valid QWAC certificate

  @trace=REQ-LIQ-03 @trace=OP-LIQ-02 @trace=STEP-REV-01
  Scenario: Automated defunding on Limit Breach
    Given a user has a Holding Limit of 3000.00 EUR
    And an incoming payment brings the balance to 3500.00 EUR
    And the engine calculates an excess of 500.00 EUR
    When I send a "POST /defund" request with amount 50000 and reason "LIMIT_BREACH"
    Then the Access Gateway returns "200 OK"
    And the Digital Euro balance is reduced to 3000.00 EUR
    And I credit 500.00 EUR to the user's Commercial Bank Account

  @trace=Rule_LIQ-03 @trace=DAT-MSG-04
  Scenario: Immediate defunding for Zero-Holding Merchants
    Given a Merchant has a Holding Limit of 0.00 EUR
    When they receive a payment of 50.00 EUR
    Then I immediately send a "POST /defund" request with amount 5000 and reason "ZERO_HOLDING_CONFIG"
    And the Access Gateway returns "200 OK"
    And the Merchant's Digital Euro balance remains 0.00 EUR
    And the Merchant's Commercial Bank Account is credited with 50.00 EUR

  @trace=REQ-LIQ-FUNC-05
  Scenario: Handling Defund Failures
    # If we cannot burn the tokens, we must NOT credit the bank account
    Given an excess of 100.00 EUR detected
    When I send a "POST /defund" request
    But the Access Gateway returns "500 Internal Server Error"
    Then I must NOT credit the Commercial Bank Account
    And I must retry the defunding operation later
