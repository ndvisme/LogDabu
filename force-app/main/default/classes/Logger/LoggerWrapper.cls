public with sharing class LoggerWrapper {


    public Logger__c logger;
    public FileMakerFromHTTP requestFileMaker;
    public HttpResponseFileMaker responseFileMaker;
    public ContentVersion requestFile;
    public ContentVersion responseFile;


    public LoggerWrapper(HttpRequest request, HttpResponse response, Logger_Controller__c controller) {
        System.debug('In \'LoggerWrapper Constuctor\'.');
        try{
            this.logger = createLogger(request, response, controller);
            this.requestFile = createRequestFile(request, this.logger);
            this.responseFile = createResponseFile(response, this.logger);
        }
        catch(LoggeCustomException e) {
            System.debug(
                'The following exception has occurred: ' + e.getMessage()
                );
        }
    }

    private ContentVersion createResponseFile(HttpResponse response, Logger__c logger) {
        this.responseFileMaker = new HttpResponseFileMaker(
            response,
            logger
            );
        this.responseFile = this.responseFileMaker.jsonFile;

        return responseFile;
    }

    private ContentVersion createRequestFile(HttpRequest request, Logger__c logger) {
        this.requestFileMaker = new FileMakerFromHTTP(request, this.logger);
        this.requestFile = this.requestFileMaker.requestfile;

        return this.requestFile;
    }

    private Logger__c createLogger(HttpRequest request, HttpResponse response, Logger_Controller__c controller) {
        Logger__c logger;
        if (CustomSettingsControllerWrapper.shouldCreateLogger(response, controller)) {
            logger = PopulateLoggerHelper.createBasic(controller);
            logger = PopulateLoggerHelper.fromRequest(request, logger);
            logger = PopulateLoggerHelper.fromResponse(response, logger);
            update logger;
            System.debug('Created \'Logger__c\': ' + logger);
        }
        else {
            System.debug(
                'Din\'t create \'Logger__c\'. ' +
                LoggeCustomException.CANT_CREATE_LOGGER_BECAUSE_OF_CONTROLLER
                );
            throw new LoggeCustomException(
                LoggeCustomException.CANT_CREATE_LOGGER_BECAUSE_OF_CONTROLLER
                );
        }

        return logger;
    }
}