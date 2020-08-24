Feature: Test Cases for GET Google API

  @AllTestCases @Smoke
  Scenario Outline: Verify Positive Scenario Successfull for GET Request
    Given User Reads a User payload <User_Payload> for <endpoint>
    When User sends a api request for method <Method>
    Then status code <Status_Code> should be displayed

    Examples: 
      | User_Payload                              | endpoint   | Method | Status_Code |
      | GET_Google_API_Payload.json;PayloadId_001 | Google_API | GET    |         200 |

  @AllTestCases @Regression
  Scenario Outline: Verify error message is displayed for wrong place id
    Given User Reads a User payload <User_Payload> for <endpoint>
    When User sends a api request for method <Method>
    Then status code <Status_Code> should be displayed

    Examples: 
      | User_Payload                              | endpoint   | Method | Status_Code |
      | GET_Google_API_Payload.json;PayloadId_002 | Google_API | GET    |         404 |
