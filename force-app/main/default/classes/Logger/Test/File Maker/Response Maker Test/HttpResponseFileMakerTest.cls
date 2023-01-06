@isTest
public with sharing class HttpResponseFileMakerTest {


    @isTest
    public static void test_makeTxtFileFromJSONResponse() {
        System.debug('Start test: \'test_makeTxtFileFromJSONResponse\'');
        HttpResponse response = TestDataFactory.createErrorHTTPJSONResponse();
        Logger__c logger = TestDataFactory.createLogger();
        HttpResponseFileMaker fileMaker = new HttpResponseFileMaker(
            response,
            logger
            );

        System.assertNotEquals(null, fileMaker.jsonFile);
    }

    @isTest
    public static void test_unsaporrtedFormat() {

    }

    @isTest
    public static void test_checkJSONFilePrettyFormat() {
        System.debug('Start test: \'test_checkJSONFilePrettyFormat\'');
        HttpResponse response = TestDataFactory.createErrorHTTPJSONResponse();
        Logger__c logger = TestDataFactory.createLogger();
        HttpResponseFileMaker fileMaker = new HttpResponseFileMaker(
            response,
            logger
            );
        Integer numOfLines = FileMakerTest.getNumberOfTxtLinesFrom(
            fileMaker.jsonFile
            );

        System.assertEquals(3, numOfLines);
    }

    @isTest
    public static void test_responseFileName() {
        // check that name fits wanted name
    }
}
