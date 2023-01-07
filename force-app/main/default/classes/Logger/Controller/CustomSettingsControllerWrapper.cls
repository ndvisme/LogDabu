public with sharing class CustomSettingsControllerWrapper {


    public static Map<Id, String> recordTypeMap = createMapOfRecordTypeIdToName();
    public static final String RECORDTYPE_NAME_DEFAULT = 'API Logger';
    public static final String RECORDTYPE_NAME_TEST_DUMMY = 'Dummy For Testing Porpuses';


    public static List<Logg_Controller__c> populateName(List<Logg_Controller__c> controllers) {
        for(Logg_Controller__c controller : controllers) {
            String recordTypeName = getRecordTypeName(controller);
            controller.Name = recordTypeName;
            controller.Logger_Record_Names__c = controller.Name;
        }
        System.debug(
            'Gave theses controllers, these names from thier record type: ' +
            controllers
            );

        return controllers;
    }

    public static String getRecordTypeName(Logg_Controller__c controller) {
        String recordTypeName = recordTypeMap.get(controller.RecordTypeId);

        return recordTypeName;
    }

    public static Boolean shouldCreateLogger(HttpResponse response, Logg_Controller__c controller) {
        Boolean shouldCreate = true;
        if (controller.Log_Only_Failures__c && response.getStatusCode() < 400) {
            shouldCreate = false;
        }

        return shouldCreate;
    }

    private static Map<Id, String> createMapOfRecordTypeIdToName() {
        Map<Id, String> recordTypeMap = new Map<Id, String>();
        List<RecordType> recordTypes = [
            SELECT Id, Name
            FROM RecordType
            WHERE SObjectType = 'Logg_Controller__c'
            ];
        for (RecordType rt : recordTypes) {
            recordTypeMap.put(rt.Id, rt.Name);
        }
        System.debug(
            'Map of Logg_Controller__cs RecordTypeId to Name: ' +
            recordTypeMap
        );

        return recordTypeMap;
    }

    public static Logg_Controller__c queryCntrollerAllFields(String id) {
        return [
            SELECT Log_Only_Failures__c, Logger_Record_Names__c, Name
            FROM Logg_Controller__c
            WHERE Id =: id
            LIMIT 1
            ];
    }

    public static Id queryRecordTypeIdFromLabel(String label) {
        RecordType recordType = [
            SELECT Id
            FROM RecordType
            WHERE sObjectType='Logg_Controller__c' AND Name =: label
            LIMIT 1
        ];
        System.debug(
            'Quried this record type: ' + recordType +
            'WHERE: ' + 'Logg_Controller__c, and Name = ' +  label
        );

        return recordType.Id;
    }

}
