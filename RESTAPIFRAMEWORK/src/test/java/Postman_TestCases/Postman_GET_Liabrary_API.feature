Feature: Test Cases for POST Liabrary API

  @AllTestCases @Smoke
  Scenario Outline: Verify user is able get a book details by author name
    Given User Reads a User payload <User_Payload> for <endpoint>
    When User sends a api request for method <Method>
    Then status code <Status_Code> should be displayed
    And verify for field <fields> value <values> is generated in response

    Examples: 
      | User_Payload                                | endpoint     | Method | Status_Code | fields    | values   |
      | Get_Liabrary_API_Payload.json;PayloadId_001 | Liabrary_API | GET    |         200 | book_name | Book_Two |

  @AllTestCases @Smoke
  Scenario Outline: Verify book details is not diaplyed for wrong author name
    Given User Reads a User payload <User_Payload> for <endpoint>
    When User sends a api request for method <Method>
    Then status code <Status_Code> should be displayed
    And verify for field <fields> value <values> is generated in response

    Examples: 
      | User_Payload                                | endpoint     | Method | Status_Code | fields | values                                                      |  |
      | Get_Liabrary_API_Payload.json;PayloadId_002 | Liabrary_API | GET    |         404 | msg    | The book by requested bookid / author name does not exists! |  |

  @AllTestCases @Smoke
  Scenario Outline: Verify user is able get a book details by ID
    Given User Reads a User payload <User_Payload> for <endpoint>
    When User sends a api request for method <Method>
    Then status code <Status_Code> should be displayed
    And verify for field <fields> value <values> is generated in response

    Examples: 
      | User_Payload                                | endpoint     | Method | Status_Code | fields                      | values                         |
      | Get_Liabrary_API_Payload.json;PayloadId_003 | Liabrary_API | GET    |         200 | book_name;isbn;aisle;author | 1111;T111one;111100;Tes111tOne |

  @AllTestCases @Smoke
  Scenario Outline: Verify book details is not diaplyed for wrong ID
    Given User Reads a User payload <User_Payload> for <endpoint>
    When User sends a api request for method <Method>
    Then status code <Status_Code> should be displayed
    And verify for field <fields> value <values> is generated in response

    Examples: 
      | User_Payload                                | endpoint     | Method | Status_Code | fields | values                                                      |
      | Get_Liabrary_API_Payload.json;PayloadId_004 | Liabrary_API | GET    |         404 | msg    | The book by requested bookid / author name does not exists! |
