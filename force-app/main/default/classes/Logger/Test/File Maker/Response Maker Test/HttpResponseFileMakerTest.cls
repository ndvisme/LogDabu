@isTest
public with sharing class HttpResponseFileMakerTest {


    @isTest
    public static void test_makeTxtFileFromJSONResponse() {
        System.debug('Start test: \'test_makeTxtFileFromJSONResponse\'');
        HttpResponse response = createHTTPJSONResponse();
        HttpResponseFileMaker fileMaker = new HttpResponseFileMaker(response);

        System.assertNotEquals(null, fileMaker.jsonFile);
    }

    @isTest
    public static void test_checkJSONFilePrettyFormat() {
        // check lines in created file
    }

    @isTest
    public static void test_responseFileName() {
        // check that name fits wanted name
    }

	private static HttpResponse createHTTPJSONResponse(){
        HttpResponse response = new HttpResponse();
        // make error status code
        // make error message
        response.setStatusCode(400);
        response.setBody('TODO from test utils');
		return response;
	}
}
