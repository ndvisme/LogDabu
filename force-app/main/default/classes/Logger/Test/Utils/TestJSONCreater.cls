@isTest
public with sharing class TestJSONCreater {


    public static String httpErrorResponse() {
        String json = '{' +
            '"error": "Login Required"' +
        '}';
        System.debug('Created Error JSON Response: \n ' + json);

        return json;
    }
}
