@isTest
public with sharing class LoggerWrapperTest {

    @isTest
    public static void test_loggerName() {
        System.debug('Started test: \'test_loggerName\'');
        Logger__c logger = TestDataFactory.createLoggerUsingDefaultValues();
        Integer loggerRecordAmount = [SELECT COUNT() FROM Logger__c];

        System.assert(logger.Name.contains(
            LoggerUtils.DEFAULT_RECORD_NAME
            )
        );
        System.assert(logger.Name.contains(
            String.valueOf(loggerRecordAmount - 1)
            )
        );
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