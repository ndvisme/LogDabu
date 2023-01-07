public with sharing class LoggeCustomException extends Exception{

    public static final String UNSOPURTTED_FORMAT = 'Can\'t create file. Logger dosn\'t support the following format: ';
    public static final String CANT_CREATE_LOGGER_BECAUSE_OF_CONTROLLER = 'Can\'t create because of custom settings controller.';
}