@isTest
public with sharing class LoggerWrapperTest {


    @isTest
    public static void test_createJsonFile() {
        test_createRequestJsonFile();
    }

    public static void test_createRequestJsonFile() {
        System.debug('Start test: \'test_createRequestJsonFile\'');
        HttpRequest request = createPostJSONRequest();
        LoggerWrapper logger = new LoggerWrapper(request);
        ContentVersion requestBodyFile = logger.requestBodyFile;
        Integer numOfLines = getNumberOfTxtLinesFrom(requestBodyFile);

        System.assertEquals(4, numOfLines);
    }

    private static HttpRequest createPostJSONRequest() {
        String jsonAsString = '{"name" : "Jhon", "Last Name" : "Doe"}';
        HttpRequest request = new HttpRequest();
        request.setEndpoint('http://www.yahoo.com');
        request.setMethod('POST');
        request.setBody(jsonAsString);
        request.setHeader('content-type', 'json');
        System.debug('HTTP Request Created: \n' + request);

        return request;
    }

    private static Integer getNumberOfTxtLinesFrom(ContentVersion requestBodyFile) {
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
