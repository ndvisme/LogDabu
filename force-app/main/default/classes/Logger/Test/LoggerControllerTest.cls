@isTest
public with sharing class LoggerControllerTest {


    public static Logger_Controller__c controller = TestDataFactory.createDefultCOntroller();


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
    public static void test_defaultRecordNames() {
        System.debug('Starting test: test_defaultRecordNames.');
        test_defaultName();
        test_customName();
    }

    public static void test_customName() {
        controller.Log_Only_Failures__c = false;
        controller.Record_names__c = 'Custom Name';
        update controller;
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
        System.assertEquals(controller.Record_names__c, loggers[0].Name);
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
        System.assertEquals(controller.Record_names__c, loggers[0].Name);
    }
}