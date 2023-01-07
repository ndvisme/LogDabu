trigger LoggController on Logg_Controller__c (before insert) {
    if (trigger.isBefore) {
        CustomSettingsControllerWrapper.checkThatAreSingletons(trigger.new);
        CustomSettingsControllerWrapper.populateName(
            trigger.new
        );

    }
}