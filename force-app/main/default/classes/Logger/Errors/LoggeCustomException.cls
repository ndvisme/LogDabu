public with sharing class LoggeCustomException extends Exception{

    public static final String UNSOPURTTED_FORMAT = 'Can\'t create file. Logger dosn\'t support the following format: ';
    public static final String CANT_CREATE_LOGGER_BECAUSE_OF_CONTROLLER = 'Can\'t create because of custom settings controller.';

    public static String tryToConnectInvalidLookup(String SObjectApiName) {
        String errMsg = 'Tried to connect - ' + SObjectApiName +
        'to Logger with out adding the apropriate field to the ' +
        'Logger__c object.';
        System.debug('Created Error Message: ' + errMsg);

        return errMsg;
    }
}