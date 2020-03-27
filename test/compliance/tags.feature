Feature: Tags should be used and align with our Tagging Strategy
  In order to provide good governance capabilities 
  As module developers
  We'll use AWS Tagging to provide good governance 

Scenario: Ensure all resources have tags
  Given I have resource that supports tags defined
  Then it must contain tags
  And its value must not be null
