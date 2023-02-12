@isTest
public with sharing class TestDataFactory {

    public static LoggerWrapper createDefaultLoggerWrapper() {
        LoggerWrapper wrapper = new LoggerWrapper(
            createPostJSONRequest(),
            createOKHTTPJSONResponse(),
            createDefultCOntroller()
        );
        wrapper.create();
        System.debug('Created this LoggerWrapper: \n ' + wrapper);

        return wrapper;
    }

    public static LoggerWrapper createCustomControllerLoggerWrapper() {
        LoggerWrapper wrapper = new LoggerWrapper(
            createPostJSONRequest(),
            createOKHTTPJSONResponse(),
            createCustomController()
        );
        wrapper.create();
        System.debug('Created this LoggerWrapper: \n ' + wrapper);

        return wrapper;
    }

    public static Logger__c createLoggerUsingDefaultValues() {
        LoggerWrapper wrapper = createDefaultLoggerWrapper();

        return wrapper.logger;
    }


    public static Logger__c createLogger() {
        Logg_Controller__c controller = createDefultCOntroller();
        Logger__c logger = new Logger__c(
            Logger_Controller__c = controller.Id
        );
        insert logger;
        System.debug('Created this Logger__c: \n ' + logger);

        return logger;
    }

    public static Logg_Controller__c createDefultCOntroller() {
        String recordTypeId = CustomSettingsControllerWrapper.queryRecordTypeIdFromLabel(
            CustomSettingsControllerWrapper.RECORDTYPE_NAME_DEFAULT
            );
        Logg_Controller__c controller = createControllerWithThisRecordTypeId(
            recordTypeId
            );

        return controller;
    }

    public static Logg_Controller__c createCustomController() {
        String recordTypeId = CustomSettingsControllerWrapper.queryRecordTypeIdFromLabel(
            CustomSettingsControllerWrapper.RECORDTYPE_NAME_TEST_DUMMY
            );
        Logg_Controller__c controller = createControllerWithThisRecordTypeId(
            recordTypeId
            );

        return controller;
    }

    private static Logg_Controller__c createControllerWithThisRecordTypeId(String recordTypeId) {
        Logg_Controller__c controller = new Logg_Controller__c(
            RecordTypeId = recordTypeId,
            Put_Data_In_Fields__c = false
        );
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