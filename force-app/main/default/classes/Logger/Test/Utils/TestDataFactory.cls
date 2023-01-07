@isTest
public with sharing class TestDataFactory {

    public static Logger__c createLoggerUsingDefaultValues() {
        LoggerWrapper wrapper = new LoggerWrapper(
            createPostJSONRequest(),
            createOKHTTPJSONResponse(),
            createDefultCOntroller()
        );
        System.debug('Created this default LoggerWrapper: \n ' + wrapper);

        return wrapper.logger;
    }


    public static Logger__c createLogger() {
        Logger__c logger = new Logger__c();
        insert logger;
        System.debug('Created this Logger__c: \n ' + logger);

        return logger;
    }

    public static Logger_Controller__c createDefultCOntroller() {
        Logger_Controller__c controller = new Logger_Controller__c();
        insert controller;
        controller = CustomSettingsControllerWrapper.queryCntrollerAllFields(
            controller.Id
            );
        System.debug(
            'This custom settgins Logger_Controller__c was created: ' +
            controller
            );

        return controller;
    }

    public static HttpResponse createOKHTTPJSONResponse() {
        HttpResponse response = new HttpResponse();
        response.setStatusCode(200);
        response.setHeader('content-type', 'json');
        response.setBody(TestJSONCreater.httpValidResponse());
        System.debug('Created this HTTP response: \n' +  response);

		return response;
    }

    public static HttpResponse createErrorHTTPJSONResponse() {
        HttpResponse response = new HttpResponse();
        response.setStatusCode(400);
        response.setHeader('content-type', 'json');
        response.setBody(TestJSONCreater.httpErrorResponse());
        System.debug('Created this HTTP response: \n' +  response);

		return response;
    }

    public static HttpRequest createPostJSONRequest() {
        String jsonAsString = '{"name" : "Jhon", "Last Name" : "Doe"}';
        HttpRequest request = new HttpRequest();
        request.setEndpoint('http://www.yahoo.com');
        request.setMethod('POST');
        request.setBody(jsonAsString);
        request.setHeader('content-type', 'json');
        System.debug('HTTP Request Created: \n' + request);

        return request;
    }

}
