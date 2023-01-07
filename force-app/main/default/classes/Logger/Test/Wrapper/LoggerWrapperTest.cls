@isTest
public with sharing class LoggerWrapperTest {


    private static HttpRequest request = TestDataFactory.createPostJSONRequest();
    private static HttpResponse response = TestDataFactory.createErrorHTTPJSONResponse();


    @isTest
    public static void test_loggerName() {
        System.debug('Started test: \'test_loggerName\'');

        test_logRecordsFromControllerLogRecordNameField();
        test_logRecordsFromControllerNameField();
    }

    private static void test_logRecordsFromControllerLogRecordNameField() {
        System.debug('Started test: \'test_logRecordsFromControllerLogRecordNameField\'');
        Logg_Controller__c controller = TestDataFactory.createDefultCOntroller();
        controller.Logger_Record_Names__c = 'Jhon Does';
        update controller;
        LoggerWrapper loggerWrapper = new LoggerWrapper(
            request,
            response,
            controller
        );

        System.assert(loggerWrapper.logger.Name.contains(controller.Logger_Record_Names__c));
    }

    private static void test_logRecordsFromControllerNameField() {
        System.debug('Started test: \'test_logRecordsFromControllerNameField\'');
        Logg_Controller__c controller = TestDataFactory.createDefultCOntroller();
        controller.Logger_Record_Names__c = null;
        update controller;
        LoggerWrapper loggerWrapper = new LoggerWrapper(
            request,
            response,
            controller
        );

        System.assert(loggerWrapper.logger.Name.contains(controller.Name));
    }

    @isTest
    public static void test_statusCodeField() {
        System.debug('Started test: \'test_statusCodeField\'');
        HttpResponse response = TestDataFactory.createErrorHTTPJSONResponse();
        Logger__c logger = TestDataFactory.createLogger();
        logger = PopulateLoggerHelper.fromResponse(response, logger);

        System.assertEquals(
            response.getStatusCode(),
            logger.Response_Status_Code__c
            );
    }

    @isTest
    public static void test_APIVerbField() {
        System.debug('Started test: \'test_APIVerbField\'');
        HttpRequest request = TestDataFactory.createPostJSONRequest();
        Logger__c logger = TestDataFactory.createLogger();
        logger = PopulateLoggerHelper.fromRequest(request, logger);

        System.assertEquals(request.getMethod(), logger.API_Verb__c);
    }

    @isTest
    public static void test_EndPointField() {
        System.debug('Started test: \'test_EndPointField\'');
        HttpRequest request = TestDataFactory.createPostJSONRequest();
        Logger__c logger = TestDataFactory.createLogger();
        logger = PopulateLoggerHelper.fromRequest(request, logger);

        System.assertEquals(request.getEndpoint(), logger.End_Point__c);
    }

    @isTest
    public static void test_ApexCallTraceField() {
        System.debug('Started test: \'test_ApexCallTraceField\'');
        Logger__c logger = TestDataFactory.createLogger();
        String trace = 'LoggerWrapperTest.test_ApexCallTraceField';
        logger = PopulateLoggerHelper.putTrace(logger, trace);

        System.assertEquals(trace, logger.Apex_Call_Trace__c);
    }
}