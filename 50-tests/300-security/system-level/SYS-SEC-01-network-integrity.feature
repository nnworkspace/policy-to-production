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
@spec=ARCH-SEC-01 @spec=ARCH-SEC-02 @component=COMP-EUR-05 @component=COMP-EUR-04
Feature: System-Wide Network Integrity & Zone Isolation
  As the Chief Information Security Officer (CISO)
  I want to verify that the fundamental network segmentations and transport securities are enforcing boundaries
  So that a compromise in one zone does not trivially escalate to another

  Background:
    Given the Digital Euro Service Platform (DESP) is deployed in Production Mode
    And the Network Firewalls are active

  @trace=ARCH-SEC-02 @trace=NIST-SP-800-52 @security_control=TRANSIT_PROTECTION
  Scenario: Enforcement of Strict mTLS on Gateway
    # Verifies that NO connection is possible without a valid QWAC
    Given an external client attempting to connect to "api.access-gateway.eurosystem.eu"
    When the client presents a valid TLS 1.3 Client Hello
    But the client does NOT present a client certificate
    Then the Access Gateway (COMP-EUR-05) immediately terminates the TCP connection
    And no HTTP 4xx/5xx error page is served (Connection Reset)

  @trace=ARCH-SEC-01 @trace=Zone_B_Firewall @security_control=NETWORK_SEGMENTATION
  Scenario: Verification of Zone B Isolation (Dark Subnet)
    # Verifies that Zone B components are not routable from the public internet
    Given the "Alias Service" (COMP-EUR-02) is running in Zone B
    When an external scanner attempts to ping or connect to the Zone B IP range directly
    Then all packets are dropped silently
    And the Zone B components are ONLY accessible via the DESP Platform (COMP-EUR-04)

  @trace=ARCH-AUD-01 @trace=GDPR-Art-32 @security_control=AUDIT_INTEGRITY
  Scenario: Immutable Audit Trail Generation
    # Verifies that every write operation, regardless of feature, leaves a trace
    Given I perform a generic "State Changing Operation" (e.g., Onboarding or Funding)
    When the operation completes successfully
    Then a corresponding "Audit Record" is synchronously written to the SIEM
    And the Audit Record contains the "Subject_DN" (Distinguished Name) of the calling PSP
