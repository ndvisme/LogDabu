@isTest
public with sharing class loggerPopulatorTest {


    @isTest
    public static void test_dynamicSobjectLookup() {
        System.debug('Started test: test_dynamicSobjectLookup');
        test_validLookUpConnect();
        test_invalidGivenLookUp();
    }

    private static void test_validLookUpConnect() {
        System.debug('Started test: test_validLookUpConnect');
        Account acc = TestDataFactory.createAccount();
        LoggerWrapper loggerWrapper = TestDataFactory.createDefaultLoggerWrapper();
        loggerWrapper.setSObjectLookup(
            LoggerControllerTest.TEST_LOOKUP_API_FIELD_NAME,
            acc.Id
            );
        Logger__c logger = LoggerUtils.queryThisLoggerWithAllHisFields(
            loggerWrapper.logger.Id
            );

        System.assertEquals(acc.Id, logger.TEST_DO_NOT_DELTE_Account__c);
    }

    private static void test_invalidGivenLookUp() {
        System.debug('Started test: test_invalidGivenLookUp');
        Contact con = TestDataFactory.createContact();
        LoggerWrapper loggerWrapper = TestDataFactory.createCustomControllerLoggerWrapper();
        try {
            loggerWrapper.setSObjectLookup('Contact', con.Id);
        }
        catch(LoggeCustomException e) {
            System.assertEquals(
                LoggeCustomException.tryToConnectInvalidLookup('Contact'),
                e.getMessage()
                );
        }
    }


    @isTest
    public static void test_populateReqAndResInFields() {
        Logg_Controller__c controller = createControllerWithDataInFields(true);
        LoggerWrapper wrapper = new LoggerWrapper(
            TestDataFactory.createPostJSONRequest(),
            TestDataFactory.createOKHTTPJSONResponse(),
            controller
        );
        wrapper.create();

        System.assert(wrapper.logger.Request_Body__c != null);
        System.assert(wrapper.logger.Response_Body__c != null);
        System.assert(wrapper.requestFile == null);
        System.assert(wrapper.responseFile == null);
    }

    @isTest
    public static void test_populateReqAndResInTxtFile() {
        Logg_Controller__c controller = createControllerWithDataInFields(false);
        LoggerWrapper wrapper = new LoggerWrapper(
            TestDataFactory.createPostJSONRequest(),
            TestDataFactory.createOKHTTPJSONResponse(),
            controller
        );
        wrapper.create();

        System.assert(wrapper.logger.Request_Body__c == null);
        System.assert(wrapper.logger.Response_Body__c == null);
        System.assert(wrapper.requestFile != null);
        System.assert(wrapper.responseFile != null);
    }


    private static Logg_Controller__c createControllerWithDataInFields(Boolean putDataInFields) {
        Logg_Controller__c controller = TestDataFactory.createDefultCOntroller();
        controller.Put_Data_In_Fields__c = putDataInFields;
        update controller;
        System.debug('Updated controller with data in field: ' + controller);

        return controller;
    }
}