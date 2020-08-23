Feature: Test Cases for Self Manage Scope

  @AllTestCases @Smoke
  Scenario Outline: Verify user is able to generate access token for SelfManage scope
    Given User Reads a User payload <User_Payload>
    When User sends a api request for method <Method>
    Then status code <Status_Code> should be displayed

    Examples: 
      | User_Payload                           | Method | Status_Code |
      | Self_Manage_Payload.json;PayloadId_001 | POST   |         200 |

  @AllTestCases @Regression
  Scenario Outline: Verify error is displayed for wrong Grant Type
    Given User Reads a User payload <User_Payload>
    When User sends a api request for method <Method>
    Then status code <Status_Code> should be displayed
    And verify for field <fields> value <values> is generated in response

    Examples: 
      | User_Payload                           | Method | Status_Code | fields | values                 |
      | Self_Manage_Payload.json;PayloadId_002 | POST   |         400 | error  | unsupported_grant_type |

  @AllTestCases @Regression
  Scenario Outline: Verify error is displayed without Grant Type
    Given User Reads a User payload <User_Payload>
    When User sends a api request for method <Method>
    Then status code <Status_Code> should be displayed
    And verify for field <fields> value <values> is generated in response

    Examples: 
      | User_Payload                           | Method | Status_Code | fields | values          |
      | Self_Manage_Payload.json;PayloadId_003 | POST   |         400 | error  | invalid_request |

  @AllTestCases @Regression
  Scenario Outline: Verify error is displayed for Wrong Scope
    Given User Reads a User payload <User_Payload>
    When User sends a api request for method <Method>
    Then status code <Status_Code> should be displayed
    And verify for field <fields> value <values> is generated in response

    Examples: 
      | User_Payload                           | Method | Status_Code | fields | values        |
      | Self_Manage_Payload.json;PayloadId_004 | POST   |         400 | error  | invalid_scope |

  @AllTestCases @Regression
  Scenario Outline: Verify token type and expires in value generated in response
    Given User Reads a User payload <User_Payload>
    When User sends a api request for method <Method>
    Then status code <Status_Code> should be displayed
    And verify for field <fields> value <values> is generated in response

    Examples: 
      | User_Payload                           | Method | Status_Code | fields                | values      |
      | Self_Manage_Payload.json;PayloadId_001 | POST   |         200 | expires_in;token_type | 3600;Bearer |
