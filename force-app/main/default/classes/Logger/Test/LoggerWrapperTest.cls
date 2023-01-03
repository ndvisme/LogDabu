@isTest
public with sharing class LoggerWrapperTest {


    @isTest
    public static void test_createJsonFile() {
        test_createRequestJsonFile();
    }

    public static void test_createRequestJsonFile() {
        // make json
        // make request
        // call func
        // soql file
        // check amount of lines
        System.debug('Start test: \'test_createRequestJsonFile\'');
        String jsonAsString = '{"name" : "Jhon", "Last Name" : "Doe"}';
        HttpRequest request = new HttpRequest();
        request.setEndpoint('http://www.yahoo.com');
        request.setMethod('POST');
        request.setBody(jsonAsString);
        request.setHeader('content-type', 'json');
        LoggerWrapper logger = new LoggerWrapper(request);

        // [SELECT ]
    }
}