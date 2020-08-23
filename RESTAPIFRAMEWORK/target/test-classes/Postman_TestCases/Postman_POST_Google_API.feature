Feature: Test Cases for POST Google API

  @AllTestCases @Smoke
  Scenario Outline: Verify Positive Scenario Successfull for POST Request
    Given User Reads a User payload <User_Payload> for <endpoint>
    When User sends a api request for method <Method>
    Then status code <Status_Code> should be displayed
    And verify for field <fields> value <values> is generated in response

    Examples: 
      | User_Payload                               | endpoint   | Method | Status_Code | fields       | values |
      | Post_Google_API_Payload.json;PayloadId_001 | Google_API | POST   |         200 | status;scope | OK;APP |
      | Post_Google_API_Payload.json;PayloadId_002 | Google_API | POST   |         200 | status;scope | OK;APP |
      | Post_Google_API_Payload.json;PayloadId_003 | Google_API | POST   |         200 | status;scope | OK;APP |
