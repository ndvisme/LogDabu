@isTest
public with sharing class FileDeleterTest {


    @isTest
    public static void test_autoDeleteFiles () {
        System.debug('Started this test: \'test_autoDeleteFiles\'');
        LoggerWrapper logWrapper = TestDataFactory.createDefaultLoggerWrapper();
        delete logWrapper.logger;
        List<ContentDocumentLink> links = LoggerUtils.queryRelatedContentDocumentLinkToThis(
            logWrapper.logger
            );

        System.assertEquals(0, links.size());
    }
}