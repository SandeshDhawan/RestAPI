Feature: Test Cases for GET Book Details

  @Smoke
  Scenario Outline: Verify all details of Books
    Given User Reads a User payload <User_Payload> for <endpoint>
    When User sends a api request for method <Method>
    Then status code <Status_Code> should be displayed
    And verify for field <fields> value <values> is generated in response

    Examples: 
      | User_Payload                                    | endpoint      | Method | Status_Code | fields                                                                                                            | values                                                                                                                                                                  |
      | Get_Book_Details_API_Payload.json;PayloadId_001 | Bookstore_API | GET    |         200 | books[7].isbn;books[7].title;books[7].subTitle;books[7].author;books[7].publisher;books[7].pages;books[7].website | 9781593277574;Understanding ECMAScript 6;The Definitive Guide for JavaScript Developers;Nicholas C. Zakas;No Starch Press;352;https://leanpub.com/understandinges6/read |

  @Smoke
  Scenario Outline: Verify user is able to retrive book details based on ISBN number
    Given User Reads a User payload <User_Payload> for <endpoint>
    When User sends a api request for method <Method>
    Then status code <Status_Code> should be displayed
    And verify for field <fields> value <values> is generated in response

    Examples: 
      | User_Payload                                    | endpoint      | Method | Status_Code | fields                                             | values                                                                                                                         |
      | Get_Book_Details_API_Payload.json;PayloadId_002 | Bookstore_API | GET    |         200 | isbn;title;subTitle;author;publisher;pages;website | 9781449365035;Speaking JavaScript;An In-Depth Guide for Programmers;Axel Rauschmayer;O'Reilly Media;460;http://speakingjs.com/ |
