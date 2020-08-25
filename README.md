# End To End RestAPI Framework using Cucumber Java

This is basic level test automation framework created using Cucumber - Java

Framework include below dependency in POM.xml

maven-surefire-plugin
maven-cucumber-reporting
testng
cucumber-java
cucumber-testng
rest-assured
json
groovy-all
log4j-api
log4j-core

In testng.xml provided cucumberOptions.TestRunner

src/main/java includes below Packages:-

1)cucumberOptions:-
  .Consist of TestRunner Class where Feature,glue path is provided. 
  .provided path for generating cucumber-report.json in plugin parameter.
  
2)utility:-
  .CommonRest.java consist of all common methods which are necessary for reading JSON,creating endpoint,sending API Request,verifying status code and verifying all fiedls generated
   in Response
  .Config.prperties consist of all different endpoint for all services.
  .log4j2.properties have details in which format logs should be generated 

src/test/java includes below Packages:-

1)StepDefinations:-
  .Common_Step_definations includes all step definations

2)TestCases:-
  .All Feature Files are added in this package
  .In Feature File passing path of parameter and which payload to read.
  .Endpoint name as per Config.prperties.
  .which Method(POST,PUT,GET,DELETE) to peroform.
  .Status Code after processing endpoint
  .generated fields in response can be passed in fields section
  .Expected values are passed in values section.

3) TestData:-
  .Different Payload File and metntioned all required test data

4) Logs
  .propertieslogs.log will have all logs generated while execution of test cases

5) target
  .Cucumber report will be generated in cucumber-html-reports folder
  
  
