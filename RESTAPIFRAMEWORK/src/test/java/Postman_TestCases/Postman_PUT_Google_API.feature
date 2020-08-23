Feature: Test Cases for PUT Google API

  @AllTestCases @Smoke
  Scenario Outline: Verify Positive Scenario Successfull for PUT Request
    Given User Reads a User payload <User_Payload> for <endpoint>
    When User sends a api request for method <Method>
    Then status code <Status_Code> should be displayed

    Examples: 
      | User_Payload                              | endpoint   | Method | Status_Code |
      | Put_Google_API_Payload.json;PayloadId_001 | Google_API | PUT    |         200 |

  @AllTestCases @Smoke
  Scenario Outline: Verify erroe message for wrong place id
    Given User Reads a User payload <User_Payload> for <endpoint>
    When User sends a api request for method <Method>
    Then status code <Status_Code> should be displayed
    And verify for field <fields> value <values> is generated in response

    Examples: 
      | User_Payload                              | endpoint   | Method | Status_Code | fields | values                                                              |
      | Put_Google_API_Payload.json;PayloadId_002 | Google_API | PUT    |         404 | msg    | Update address operation failed, looks like the data doesn't exists |
