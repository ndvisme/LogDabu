public with sharing class LoggerUtils {


    private static final String JSON_FORMAT = 'json';
    private static final String DEFAULT_RECORD_NAME = 'API Logger';



    public static Boolean httpRequestIsJSON(HttpRequest request) {
        Boolean isJson = false;
        String formatType = getFormatTypeFrom(request);
        if(formatType == JSON_FORMAT) {
            isJson = true;
        }

        return isJson;
    }

    public static Boolean httpResponseIsJSON(HttpResponse response) {
        Boolean isJson = false;
        String formatType = getFormatTypeFrom(response);
        if(formatType == JSON_FORMAT) {
            isJson = true;
        }

        return isJson;
    }

    public static String getFormatTypeFrom(HttpRequest request) {
        String formatType = request.getHeader('content-type');

        return formatType;
    }

    public static String getFormatTypeFrom(HttpResponse response) {
        String formatType = response.getHeader('content-type');

        return formatType;
    }

    public static Logger_Controller__c queryControlCustomSettings(String name) {
        Logger_Controller__c controller;
        if(name == '') {
           name = DEFAULT_RECORD_NAME;
        }
        controller = [
            SELECT Log_Only_Failures__c, Record_names__c
            FROM Logger_Controller__c
            WHERE Record_names__c =: name
            LIMIT 1
        ];

        return controller;
    }
}