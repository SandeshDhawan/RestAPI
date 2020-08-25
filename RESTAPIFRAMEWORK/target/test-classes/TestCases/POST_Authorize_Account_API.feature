Feature: Test Cases for POST Authorize Account API

  @Smoke
  Scenario Outline: Verify Positive Scenario for Authorize Account
    Given User Reads a User payload <User_Payload> for <endpoint>
    When User sends a api request for method <Method>
    Then status code <Status_Code> should be displayed

    Examples: 
      | User_Payload                                      | endpoint      | Method | Status_Code |
      | Authorized_Account_API_Payload.json;PayloadId_003 | Bookstore_API | POST   |         200 |

  @Regression
  Scenario Outline: Verify User Not Found error is displayed for wrong UserName and Password
    Given User Reads a User payload <User_Payload> for <endpoint>
    When User sends a api request for method <Method>
    Then status code <Status_Code> should be displayed
    And verify for field <fields> value <values> is generated in response

    Examples: 
      | User_Payload                                      | endpoint      | Method | Status_Code | fields        | values               |
      | Authorized_Account_API_Payload.json;PayloadId_001 | Bookstore_API | POST   |         404 | code; message | 1207;User not found! |

  @Regression
  Scenario Outline: Verify error message is displayed when Username and Password is not passed in body
    Given User Reads a User payload <User_Payload> for <endpoint>
    When User sends a api request for method <Method>
    Then status code <Status_Code> should be displayed
    And verify for field <fields> value <values> is generated in response

    Examples: 
      | User_Payload                                      | endpoint      | Method | Status_Code | fields        | values                               |
      | Authorized_Account_API_Payload.json;PayloadId_002 | Bookstore_API | POST   |         400 | code; message | 1200;UserName and Password required. |
