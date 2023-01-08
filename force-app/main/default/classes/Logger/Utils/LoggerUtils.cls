public with sharing class LoggerUtils {


    private static final String JSON_FORMAT = 'json';
    public static final String DEFAULT_RECORD_NAME = 'API Logger';


    public static Integer queryAmountOfLoggerRecords() {
        return [SELECT count() FROM Logger__c];
    }

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

    public static Logg_Controller__c queryControlCustomSettings(String name) {
        Logg_Controller__c controller;
        if(name == '') {
           name = DEFAULT_RECORD_NAME;
        }
        controller = [
            SELECT Log_Only_Failures__c, Logger_Record_Names__c
            FROM Logg_Controller__c
            WHERE Logger_Record_Names__c =: name
            LIMIT 1
        ];

        return controller;
    }

    public static Logger__c queryThisLoggerWithAllHisFields(String id) {
        Logger__c logger = [
            SELECT Id, Apex_Call_Trace__c, API_Verb__c, End_Point__c, Name, Response_Status_Code__c, TEST_DO_NOT_DELTE_Account__c
            FROM Logger__c
            WHERE Id =: id
            LIMIT 1
        ];
        System.debug('Quired this logger: ' + logger);

        return logger;
    }
}