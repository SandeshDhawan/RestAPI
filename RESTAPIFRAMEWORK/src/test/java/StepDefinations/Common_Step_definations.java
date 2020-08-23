package StepDefinations;

import java.io.IOException;
import org.apache.logging.log4j.*;

import org.json.JSONArray;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.cucumber.java.en.And;
import utility.CommonRest;

public class Common_Step_definations {

	private static Logger log = LogManager.getLogger(Common_Step_definations.class);

	CommonRest commonrest = new CommonRest();
	static JSONArray arrPayloadAttr = null;

	@Given("^User Reads a User payload (.*) for (.*)$")
	public void verifyUserGenerateAccessToken(String userPayload, String endpoint) {
		commonrest.readPropertiesFile();
		try {
			arrPayloadAttr = commonrest.getPayloadData(userPayload);
		} catch (IOException e) {
			e.printStackTrace();
		}

		commonrest.updateAllDynamicAttributes();
		commonrest.createrequestToSend(endpoint);
	}

	@When("^User sends a api request for method (.*)$")
	public void verifyUserSendsAPIRequest(String method) {
		commonrest.sendAPIRequest(method);
	}

	@Then("^status code (.*) should be displayed$")
	public void verifyStatusCode(int status_code) {
		commonrest.verifyStatusCode(status_code);
	}

	@And("^verify for field (.*) value (.*) is generated in response$")
	public void verifyValueGeneratedInResponse(String fields, String values) {
		commonrest.valueGeneratedInResponse(fields, values);
	}

}
