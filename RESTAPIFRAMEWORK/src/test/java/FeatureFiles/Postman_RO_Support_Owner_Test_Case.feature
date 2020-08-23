Feature: Test Cases for Ro Support Owner Scope

  @AllTestCases @Smoke
  Scenario Outline: Verify user is able to generate access token for ROSupportOwner scope
   Given User Reads a User payload <User_Payload>
    When User sends a api request for method <Method>
    Then status code <Status_Code> should be displayed

    Examples: 
      | User_Payload                                | Method | Status_Code |
      | RO_Support_owner_Payload.json;PayloadId_001 | POST   |         200 |

  @AllTestCases @Regression
  Scenario Outline: Verify error message is displayed for ROSupportOwner scope with wrong Grant Type
    Given User Reads a User payload <User_Payload>
    When User sends a api request for method <Method>
    Then status code <Status_Code> should be displayed
    And verify for field <fields> value <values> is generated in response

    Examples: 
      | User_Payload                                | Method | Status_Code | fields | values                 |
      | RO_Support_owner_Payload.json;PayloadId_002 | POST   |         400 | error  | unsupported_grant_type |

  @AllTestCases @Regression
  Scenario Outline: Verify error message is displayed for ROSupportOwner scope without Grant Type
    Given User Reads a User payload <User_Payload>
    When User sends a api request for method <Method>
    Then status code <Status_Code> should be displayed
    And verify for field <fields> value <values> is generated in response

    Examples: 
      | User_Payload                                | Method | Status_Code | fields | values          |
      | RO_Support_owner_Payload.json;PayloadId_003 | POST   |         400 | error  | invalid_request |

  @AllTestCases @Regression
  Scenario Outline: Verify error message is displayed for wrong scope
    Given User Reads a User payload <User_Payload>
    When User sends a api request for method <Method>
    Then status code <Status_Code> should be displayed
    And verify for field <fields> value <values> is generated in response

    Examples: 
      | User_Payload                                | Method | Status_Code | fields | values        |
      | RO_Support_owner_Payload.json;PayloadId_004 | POST   |         400 | error  | invalid_scope |
