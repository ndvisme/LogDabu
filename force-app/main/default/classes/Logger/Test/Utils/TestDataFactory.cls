@isTest
public with sharing class TestDataFactory {


    public static Logger__c createLogger() {
        Logger__c logger = new Logger__c();
        insert logger;
        System.debug('Created this Logger__c: \n ' + logger);

        return logger;
    }

    public static HttpResponse createErrorHTTPJSONResponse() {
        HttpResponse response = new HttpResponse();
        response.setStatusCode(400);
        response.setHeader('content-type', 'json');
        response.setBody(TestJSONCreater.httpErrorResponse());
        System.debug('Created this HTTP response: \n' +  response);

		return response;
    }
}
