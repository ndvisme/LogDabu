@isTest
public with sharing class FileMakerTest {


    @isTest
    public static void test_createJsonFile() {
        test_createRequestJsonFile();
    }

    @isTest
    public static void test_unsaporttedFormat() {
        System.debug('Started test: \'test_unsaporttedFormat\'');
        HttpRequest request = makeXMLHTTPRequest();
        HttpResponse response = TestDataFactory.createErrorHTTPJSONResponse();
        Logger_Controller__c controller = TestDataFactory.createDefultCOntroller();
        String format = getFormatFrom(request);
        try {
            LoggerWrapper loggerWrapper = new LoggerWrapper(
                request,
                response,
                controller
                );
        }
        catch(LoggeCustomException err) {
            System.assertEquals(
                LoggeCustomException.UNSOPURTTED_FORMAT + format,
                err.getMessage()
                );
        }
    }

    public static HttpRequest makeXMLHTTPRequest() {
        String xmlAsString = '<note> <to>Tove</to> </note>';
        HttpRequest request = new HttpRequest();
        request.setEndpoint('http://www.yahoo.com');
        request.setMethod('POST');
        request.setBody(xmlAsString);
        request.setHeader('content-type', 'xml');
        System.debug('HTTP Request Created: \n' + request);

        return request;
    }

    public static String getFormatFrom(HttpRequest request) {
        String format = request.getHeader('content-type');
        System.debug('Http format: ' + format);

        return format;
    }

    public static void test_createRequestJsonFile() {
        System.debug('Start test: \'test_createRequestJsonFile\'');
        HttpRequest request = TestDataFactory.createPostJSONRequest();
        HttpResponse response = TestDataFactory.createErrorHTTPJSONResponse();
        Logger_Controller__c controller = TestDataFactory.createDefultCOntroller();
        LoggerWrapper loggerWrapper = new LoggerWrapper(
            request,
            response,
            controller
            );
        ContentVersion requestBodyFile = loggerWrapper.requestFileMaker.requestfile;
        Integer numOfLines = getNumberOfTxtLinesFrom(requestBodyFile);

        System.assertEquals(4, numOfLines);
    }

    public static Integer getNumberOfTxtLinesFrom(ContentVersion requestBodyFile) {
        Integer numOfLines = -1;
        Blob versionDataBlob = requestBodyFile.VersionData;
        String versionDataString = versionDataBlob.toString();
        numOfLines = countLines(versionDataString);

        return numOfLines;
    }

    public static Integer countLines(String str) {
        if (str == null || str == '') {
            return 0;
        }
        String[] lines = str.split('\\n|\\r|\\r\\n');
        System.debug('Num of lines found in given string: ' + lines.size());

        return lines.size();
    }
}
