trigger LoggController on Logg_Controller__c (before insert) {
    if(trigger.isBefore) {
        CustomSettingsControllerWrapper.populateName(
            trigger.new
            );
    }
}