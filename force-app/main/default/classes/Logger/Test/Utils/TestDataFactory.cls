@isTest
public with sharing class TestDataFactory {

    public static LoggerWrapper createDefaultLoggerWrapper() {
        LoggerWrapper wrapper = new LoggerWrapper(
            createPostJSONRequest(),
            createOKHTTPJSONResponse(),
            createDefultCOntroller()
        );
        System.debug('Created this default LoggerWrapper: \n ' + wrapper);

        return wrapper;
    }

    public static Logger__c createLoggerUsingDefaultValues() {
        LoggerWrapper wrapper = createDefaultLoggerWrapper();

        return wrapper.logger;
    }


    public static Logger__c createLogger() {
        Logger__c logger = new Logger__c();
        insert logger;
        System.debug('Created this Logger__c: \n ' + logger);

        return logger;
    }

    public static Logg_Controller__c createDefultCOntroller() {
        Logg_Controller__c controller = new Logg_Controller__c();
        insert controller;
        controller = CustomSettingsControllerWrapper.queryCntrollerAllFields(
            controller.Id
            );
        System.debug(
            'This custom settgins Logg_Controller__c was created: ' +
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

    public static Account createAccount() {
        Account acc = new Account(
            Name = 'Jhon'
        );
        insert acc;
        System.debug('Created this Account: ' + acc);

        return acc;
    }

    public static Contact createContact() {
        Contact con = new Contact(
            LastName = 'Doe'
        );
        insert con;
        System.debug('Created this Contact: ' + con);

        return con;
    }

}
