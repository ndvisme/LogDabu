@isTest
public with sharing class TestJSONCreater {

    public static String httpValidResponse() {
        String json = '{' +
        '"resault": "Hello World!"' +
        '}';
        System.debug('Created this JSON Response: \n ' + json);

        return json;
    }


    public static String httpErrorResponse() {
        String json = '{' +
            '"error": "Login Required"' +
        '}';
        System.debug('Created Error JSON Response: \n ' + json);

        return json;
    }
}
