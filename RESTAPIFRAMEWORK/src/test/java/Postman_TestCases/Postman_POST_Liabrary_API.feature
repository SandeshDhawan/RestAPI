Feature: Test Cases for POST Liabrary API

  @AllTestCases @Smoke
  Scenario Outline: Verify user is able to add a book successfully
    Given User Reads a User payload <User_Payload> for <endpoint>
    When User sends a api request for method <Method>
    Then status code <Status_Code> should be displayed
    And verify for field <fields> value <values> is generated in response

    Examples: 
      | User_Payload                                 | endpoint     | Method | Status_Code | fields | values             |
      | Post_Liabrary_API_Payload.json;PayloadId_001 | Liabrary_API | POST   |         200 | Msg    | successfully added |

  @AllTestCases @Smoke
  Scenario Outline: Verify error message is displayed if book is alrady present
    Given User Reads a User payload <User_Payload> for <endpoint>
    When User sends a api request for method <Method>
    Then status code <Status_Code> should be displayed
    And verify for field <fields> value <values> is generated in response

    Examples: 
      | User_Payload                                 | endpoint     | Method | Status_Code | fields | values                                                        |
      | Post_Liabrary_API_Payload.json;PayloadId_002 | Liabrary_API | POST   |         404 | msg    | Add Book operation failed, looks like the book already exists |
