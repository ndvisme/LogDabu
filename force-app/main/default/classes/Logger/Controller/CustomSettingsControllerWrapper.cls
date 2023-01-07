public with sharing class CustomSettingsControllerWrapper {


    public static Boolean shouldCreateLogger(HttpResponse response, Logger_Controller__c controller) {
        Boolean shouldCreate = true;
        if (controller.Log_Only_Failures__c && response.getStatusCode() < 400) {
            shouldCreate = false;
        }

        return shouldCreate;
    }

    public static Logger_Controller__c queryCntrollerAllFields(String id) {
        return [
            SELECT Log_Only_Failures__c, Record_names__c
            FROM Logger_Controller__c
            WHERE Id =: id
            LIMIT 1
            ];
    }
}
