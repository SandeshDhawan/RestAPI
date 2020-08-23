package utility;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONObject;

import io.restassured.RestAssured;
import io.restassured.http.ContentType;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;

public class CommonRest {

	static HashMap<String, String> dictionary = new HashMap<String, String>();
	static HashMap<String, String> properties = new HashMap<String, String>();
	static JSONArray arrPayloadAttr = null;
	static RequestSpecification request = null;
	static Response response;

	static Logger logger = LogManager.getLogger(CommonRest.class);
	
	public void readPropertiesFile() {

		logger.info("***************************************Started Execution of Test Cases****************************************");
		
		Properties prop = new Properties();
		FileInputStream file;
		try {
			file = new FileInputStream(
					System.getProperty("user.dir") + "\\src\\main\\java\\utility\\config.properties");
			prop.load(file);
			for (String key : prop.stringPropertyNames()) {
				logger.info(key+":"+prop.getProperty(key));
				properties.put(key, prop.getProperty(key));

			}
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	public JSONArray getPayloadData(String payloadData) throws IOException {

		BufferedReader br = null;
		try {
			// Reading Json Data object file
			String dataFileName = payloadData.split(";")[0];
			String dataId = payloadData.split(";")[1];

			String testDataFile = System.getProperty("user.dir") + "\\src\\test\\java\\TestData\\" + dataFileName;
			br = new BufferedReader(new FileReader(testDataFile));

			String sCurrentLine, fileContent = "";
			while ((sCurrentLine = br.readLine()) != null) {
				fileContent = fileContent + sCurrentLine;
			}

			JSONObject jsonTestObject = new JSONObject(fileContent);
			// Get testdata
			JSONArray arrPayloads = jsonTestObject.getJSONArray("Payload");
			int payloadCount = arrPayloads.length();

			for (int iData = 0; iData < payloadCount; iData++) {

				JSONObject jsonPayload = arrPayloads.getJSONObject(iData);

				String payloadId = (String) jsonPayload.keys().next();

				if (payloadId.equalsIgnoreCase(dataId))
					arrPayloadAttr = jsonPayload.getJSONArray(payloadId);
			}

			logger.info("JSON Converted in to array is=" + arrPayloadAttr);

		} catch (Exception e) {
			System.out.println("Exception in Get Payload Data :" + e);
		} finally {
			br.close();
			br = null;
		}
		return arrPayloadAttr;
	}

	public static void createrequestToSend(String endpoint) {

		logger.info("Array Payload attribute is=" + arrPayloadAttr);

		String reqType = null;
		String reqEndpoint = null;
		logger.info("Endpoint is="+endpoint);
		
		if (endpoint.equalsIgnoreCase("Google_API"))
			request = RestAssured.given().baseUri(properties.get("Google_API"));
		else if (endpoint.equalsIgnoreCase("Liabrary_API"))
			request = RestAssured.given().baseUri(properties.get("Liabrary_API"));
		else
			request = RestAssured.given().baseUri(properties.get("user_payload_endpoint"));

		for (int iAttr = 0; iAttr < arrPayloadAttr.length(); iAttr++) {
			JSONObject jsonDataAttr = arrPayloadAttr.getJSONObject(iAttr);

			String dataAttribute = (String) jsonDataAttr.keys().next();

			if (dataAttribute.equalsIgnoreCase("ContentType")) {
				logger.info(jsonDataAttr.getString(dataAttribute));

				if (jsonDataAttr.getString(dataAttribute).equalsIgnoreCase("x-www-form-urlencoded"))
					request.contentType(ContentType.URLENC.withCharset("UTF-8"));
				else
					request.contentType(jsonDataAttr.getString(dataAttribute).toString());
				dictionary.put("Content Type", jsonDataAttr.getString(dataAttribute));

			} else if (dataAttribute.equalsIgnoreCase("Endpoint")) {
				reqEndpoint = jsonDataAttr.getString("Endpoint");
				dictionary.put("EndPoint", reqEndpoint);
				logger.info("Endpoint is=" + dictionary.get("EndPoint"));
			}

			else if (dataAttribute.equalsIgnoreCase("Headers")) {
				// Iterating list of Headers data
				JSONArray arrHeaders = jsonDataAttr.getJSONArray("Headers");

				for (int iHeader = 0; iHeader < arrHeaders.length(); iHeader++) {

					JSONObject header = arrHeaders.getJSONObject(iHeader);
					String headerName = (String) header.keys().next();
					dictionary.put(headerName, header.getString(headerName));
					request.header(headerName, header.getString(headerName));

				}
			}

			else if (dataAttribute.equalsIgnoreCase("Parameters")) {
				// Iterating list of Params data
				// pass this paramerter when using content type as
				// "x-www-form-urlencoded"
				JSONArray arrParams = jsonDataAttr.getJSONArray("Parameters");

				for (int iParams = 0; iParams < arrParams.length(); iParams++) {

					JSONObject parameter = arrParams.getJSONObject(iParams);
					String parameterName = (String) parameter.keys().next();
					dictionary.put(parameterName, parameter.getString(parameterName));
					request.param(parameterName, parameter.getString(parameterName));

				}
			} else if (dataAttribute.equalsIgnoreCase("QueryParameters")) {
				// Iterating list of query Params data
				JSONArray arrParams = jsonDataAttr.getJSONArray("QueryParameters");

				for (int iParams = 0; iParams < arrParams.length(); iParams++) {

					JSONObject parameter = arrParams.getJSONObject(iParams);
					String parameterName = (String) parameter.keys().next();
					dictionary.put(parameterName, parameter.getString(parameterName));
					request.queryParam(parameterName, parameter.getString(parameterName));

				}
			} else if (dataAttribute.equalsIgnoreCase("Body")) {

				String reqBody = jsonDataAttr.optString("Body");
				dictionary.put("ReqBody", reqBody);
				request.body(reqBody);
			} else if (dataAttribute.equalsIgnoreCase("RequestType")) {
				reqType = jsonDataAttr.getString("RequestType");
				dictionary.put("ReqType", reqType);
			}

		}

		logger.info("Data in Dictionary is=" + dictionary);
		
		logger.info("ContentType is=" + dictionary.get("Content Type"));
		logger.info("Request Endpoint =" + dictionary.get("ReqType"));
		logger.info("Request Body is=" + dictionary.get("ReqBody"));
	}

	public Object updateAllDynamicAttributes() {

		try {
			String payload = arrPayloadAttr.toString();

			for (int index = payload.indexOf("<"); index >= 0; index = payload.indexOf("<", index + 1)) {

				String extractedKey = payload.substring(index, payload.indexOf(">", index + 1));
				extractedKey = extractedKey.substring(1);

				for (Map.Entry property : properties.entrySet()) {
					String key = (String) property.getKey();
					String newValue = (String) property.getValue();

					if (property.getKey().equals(extractedKey)) {
						extractedKey = "<" + extractedKey + ">";
						payload = payload.replace(extractedKey, newValue);
					}

				}
			}

			arrPayloadAttr = new JSONArray(payload);
			dictionary.put("PAYLOAD", arrPayloadAttr.toString());
			logger.info("Array after updating a value is=" + arrPayloadAttr);
			return arrPayloadAttr;

		} catch (Exception e) {

		}
		return null;
	}

	public void sendAPIRequest(String method) {
		String endpoint = dictionary.get("EndPoint");
		if (method.equalsIgnoreCase("POST"))
			response = request.log().all().post(endpoint).then().log().all().extract().response();
		else if (method.equalsIgnoreCase("GET"))
			response = request.log().all().get(endpoint).then().log().all().extract().response();
		else if (method.equalsIgnoreCase("PUT"))
			response = request.log().all().put(endpoint).then().log().all().extract().response();
		else if (method.equalsIgnoreCase("DELETE"))
			response = request.log().all().delete(endpoint).then().log().all().extract().response();
		else if (method.equalsIgnoreCase("PATCH"))
			response = request.log().all().patch(endpoint).then().log().all().extract().response();
	}

	public void verifyStatusCode(int Expected_status_code) {

		int Actual_status_code = response.getStatusCode();


		logger.info("Response is=" + response);
		logger.info("Status Code is=" + Actual_status_code);

		org.junit.Assert.assertEquals(Expected_status_code, Actual_status_code);

	}

	public void valueGeneratedInResponse(String fields, String values) {
		String response_converted_in_string = response.asString();
		logger.info("Response Converted in String Format is="+response_converted_in_string);
		JsonPath js = new JsonPath(response_converted_in_string);
		String splitted_fields[];
		String splitted_values[];

		if (fields.contains(";")) {
			splitted_fields = fields.split(";");
			splitted_values = values.split(";");

			for (int i = 0; i < splitted_fields.length; i++) {
				
				logger.info(splitted_fields[i] + " Value is=" + js.get(splitted_fields[i]));
				org.junit.Assert.assertEquals(js.get(splitted_fields[i]).toString().replace("[", "").replace("]", ""),
						splitted_values[i].toString());
			}
		} else {
			
			logger.info(fields + " Value is=" + js.get(fields));
			logger.info("Value Passed from Featutre File is=" + values);
			org.junit.Assert.assertEquals(js.get(fields).toString().replace("[", "").replace("]", ""), values);
		}

	}

}
