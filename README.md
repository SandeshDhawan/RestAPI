# End To End RestAPI Framework using Cucumber Java

This is basic level test automation framework created using Cucumber - Java

Framework include below dependency in POM.xml

1)maven-surefire-plugin

2)maven-cucumber-reporting

3)testng

4)cucumber-java

5)cucumber-testng

6)rest-assured

7)json

8)groovy-all

9)log4j-api

10)log4j-core


In testng.xml provided cucumberOptions.TestRunner

# src/main/java includes below Packages:-

## cucumberOptions:-
  1)Consist of TestRunner Class where Feature,glue path is provided. 
  
  2)provided path for generating cucumber-report.json in plugin parameter.
  
## utility:-
  1)CommonRest.java consist of all common methods which are necessary for reading JSON,creating endpoint,sending API Request,verifying status code and verifying all fields generated in Response
  
  2)Config.prperties consist of all different endpoint for all services.
  
  3)log4j2.properties have details in which format logs should be generated 

# src/test/java includes below Packages:-

## StepDefinations:-
  Common_Step_definations includes all step definations that we have defined in our feature file

## TestCases:-
  1)All Feature Files are added in this package
  
  2)In Feature File passing path of parameter and which payload to read.
  
  3)Endpoint name as per Config.prperties.
  
  4)which Method(POST,PUT,GET,DELETE) to peroform.
  
  5)Status Code after processing endpoint
  
  6)generated fields in response can be passed in fields section
  
  7)Expected values are passed in values section.

## TestData:-
  Different Payload File and metntioned all required test data

## Logs
  propertieslogs.log will have all logs generated while execution of test cases

## target
  Cucumber report will be generated in cucumber-html-reports folder
  
  
Integrated with jenkins so that we can run our all Test Cases from jenkins
