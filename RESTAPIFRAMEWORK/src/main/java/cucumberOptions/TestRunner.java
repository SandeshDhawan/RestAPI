package cucumberOptions;

import io.cucumber.testng.AbstractTestNGCucumberTests;
import io.cucumber.testng.CucumberOptions;

//@RunWith(Cucumber.class)
@CucumberOptions(features = "src/test/java/Postman_TestCases", plugin = "json:target/jsonReports/cucumber-report.json", glue = "StepDefinations")
public class TestRunner extends AbstractTestNGCucumberTests {

}
