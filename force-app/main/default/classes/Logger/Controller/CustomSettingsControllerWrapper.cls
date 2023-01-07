public with sharing class CustomSettingsControllerWrapper {


    public static Boolean shouldCreateLogger(HttpResponse response, Logg_Controller__c controller) {
        Boolean shouldCreate = true;
        if (controller.Log_Only_Failures__c && response.getStatusCode() < 400) {
            shouldCreate = false;
        }

        return shouldCreate;
    }

    public static Logg_Controller__c queryCntrollerAllFields(String id) {
        return [
            SELECT Log_Only_Failures__c, Logger_Record_Names__c
            FROM Logg_Controller__c
            WHERE Id =: id
            LIMIT 1
            ];
    }
}
