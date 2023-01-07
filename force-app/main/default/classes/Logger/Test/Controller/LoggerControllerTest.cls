@isTest
public with sharing class LoggerControllerTest {


    public static String TEST_LOOKUP_API_FIELD_NAME = 'TEST_DO_NOT_DELTE_Account__c';
    public static Logg_Controller__c controller = TestDataFactory.createDefultCOntroller();


    @isTest
    public static void test_logOnlyFailsCheckBox() {
        test_noLogShouldBeCreated();
        test_logShouldBeCreated();
    }

    @isTest
    public static void test_noLogShouldBeCreated() {
        System.debug('Starting test: test_noLogShouldBeCreated.');
        controller.Log_Only_Failures__c = true;
        update controller;
        HttpRequest request = TestDataFactory.createPostJSONRequest();
        HttpResponse respones = TestDataFactory.createOKHTTPJSONResponse();
        LoggerWrapper loggerWrapper = new LoggerWrapper(
            request,
            respones,
            controller
            );
        List<Logger__c> loggers = [SELECT Id FROM Logger__c];

        System.assertEquals(0, loggers.size());
    }

    @isTest
    public static void test_logShouldBeCreated() {
        System.debug('Starting test: test_logShouldBeCreated.');
        controller.Log_Only_Failures__c = false;
        update controller;
        HttpRequest request = TestDataFactory.createPostJSONRequest();
        HttpResponse respones = TestDataFactory.createOKHTTPJSONResponse();
        LoggerWrapper loggerWrapper = new LoggerWrapper(
            request,
            respones,
            controller
            );
        List<Logger__c> loggers = [SELECT Id FROM Logger__c];

        System.assertEquals(1, loggers.size());
    }

    @isTest
    public static void test_controllerName() {
        System.debug('Starting test: \'test_controllerName\'.');
        test_defaultControllerName();
        test_customControllerName();
    }

    @isTest
    public static void test_defaultRecordNames() {
        System.debug('Starting test: test_defaultRecordNames.');
        test_defaultName();
        test_customName();
    }

    private static void test_defaultControllerName() {
        System.debug('Started test: \'test_defaultControllerName\'.');
        Logg_Controller__c controller = TestDataFactory.createDefultCOntroller();

        System.assertEquals(
            CustomSettingsControllerWrapper.RECORDTYPE_NAME_DEFAULT,
            controller.Name
            );
    }

    private static void test_customControllerName() {
        System.debug('Started test: \'test_customControllerName\'.');
        Logg_Controller__c controller = TestDataFactory.createCustomController();

        System.assertEquals(
            CustomSettingsControllerWrapper.RECORDTYPE_NAME_TEST_DUMMY,
            controller.Name
            );
    }

    public static void test_customName() {
        controller = TestDataFactory.createCustomController();
        HttpRequest request = TestDataFactory.createPostJSONRequest();
        HttpResponse respones = TestDataFactory.createOKHTTPJSONResponse();
        LoggerWrapper loggerWrapper = new LoggerWrapper(
            request,
            respones,
            controller
            );
        List<Logger__c> loggers = [
            SELECT Name
            FROM Logger__c
            WHERE Id =: loggerWrapper.logger.Id
            ];

        System.assertEquals(1, loggers.size());
        System.assert(loggers[0].Name.containsAny(
            controller.Logger_Record_Names__c
            )
        );
    }

    public static void test_defaultName() {
        controller.Log_Only_Failures__c = false;
        update controller;
        controller = CustomSettingsControllerWrapper.queryCntrollerAllFields(
            controller.Id
            );
        HttpRequest request = TestDataFactory.createPostJSONRequest();
        HttpResponse respones = TestDataFactory.createOKHTTPJSONResponse();
        LoggerWrapper logger = new LoggerWrapper(
            request,
            respones,
            controller
            );
        List<Logger__c> loggers = [SELECT Name FROM Logger__c];

        System.assertEquals(1, loggers.size());
        System.assert(loggers[0].Name.containsAny(
            controller.Logger_Record_Names__c
            )
        );
    }
}