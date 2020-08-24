Feature: Test Cases for Generate Token API

  @Smoke
  Scenario Outline: Verify Positive Scenario for Generate Token
    Given User Reads a User payload <User_Payload> for <endpoint>
    When User sends a api request for method <Method>
    Then status code <Status_Code> should be displayed
    And verify for field <fields> value <values> is generated in response

    Examples: 
      | User_Payload                                  | endpoint      | Method | Status_Code | fields        | values                                |
      | Generate_Token_API_Payload.json;PayloadId_001 | Bookstore_API | POST   |         200 | status;result | Success;User authorized successfully. |

  @Smoke
  Scenario Outline: Verify error message is displayed for wrong UserName
    Given User Reads a User payload <User_Payload> for <endpoint>
    When User sends a api request for method <Method>
    Then status code <Status_Code> should be displayed
    And verify for field <fields> value <values> is generated in response

    Examples: 
      | User_Payload                                  | endpoint      | Method | Status_Code | fields        | values                            |
      | Generate_Token_API_Payload.json;PayloadId_002 | Bookstore_API | POST   |         200 | status;result | Failed;User authorization failed. |

  @Smoke
  Scenario Outline: Verify error message is displayed for wrong Password
    Given User Reads a User payload <User_Payload> for <endpoint>
    When User sends a api request for method <Method>
    Then status code <Status_Code> should be displayed
    And verify for field <fields> value <values> is generated in response

    Examples: 
      | User_Payload                                  | endpoint      | Method | Status_Code | fields        | values                            |
      | Generate_Token_API_Payload.json;PayloadId_003 | Bookstore_API | POST   |         200 | status;result | Failed;User authorization failed. |

  @Smoke
  Scenario Outline: Verify error message is displayed for Body Without UserName and Password
    Given User Reads a User payload <User_Payload> for <endpoint>
    When User sends a api request for method <Method>
    Then status code <Status_Code> should be displayed
    And verify for field <fields> value <values> is generated in response

    Examples: 
      | User_Payload                                  | endpoint      | Method | Status_Code | fields       | values                               |
      | Generate_Token_API_Payload.json;PayloadId_004 | Bookstore_API | POST   |         400 | code;message | 1200;UserName and Password required. |
