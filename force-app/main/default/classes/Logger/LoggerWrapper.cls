public with sharing class LoggerWrapper {


    public Logg_Controller__c controller;
    public Logger__c logger;
    public FileMakerFromHTTP requestFileMaker;
    public HttpResponseFileMaker responseFileMaker;
    public ContentVersion requestFile;
    public ContentVersion responseFile;
    private HttpRequest givenRequest;
    private HttpResponse givenResponse;


    public LoggerWrapper(HttpRequest request, HttpResponse response, Logg_Controller__c controller) {
        System.debug('In \'LoggerWrapper Constuctor\'.');
        try{
            this.controller = controller;
            this.logger = createLogger(request, response, controller);
            this.givenRequest = request;
            this.givenResponse = response;
        }
        catch(LoggeCustomException e) {
            System.debug(
                'The following exception has occurred: ' + e.getMessage()
                );
        }
    }

    public void create() {
        try {
            if (this.logger != null) {
                insertRecordsToDB();
            }
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

    private Logger__c createLogger(HttpRequest request, HttpResponse response, Logg_Controller__c controller) {
        Logger__c logger;
        Boolean shouldCreated = CustomSettingsControllerWrapper.shouldCreateLogger(
            response,
            controller
            );
        if (shouldCreated) {
            logger = initLoggerWith(controller, request, response);
        }
        else {
            System.debug(
                LoggeCustomException.CANT_CREATE_LOGGER_BECAUSE_OF_CONTROLLER
                );
            throw new LoggeCustomException(
                LoggeCustomException.CANT_CREATE_LOGGER_BECAUSE_OF_CONTROLLER
                );
        }

        return logger;
    }

    private Logger__c initLoggerWith(Logg_Controller__c controller, HttpRequest request, HttpResponse response) {
        Logger__c logger = PopulateLoggerHelper.createBasic(controller);
        logger = PopulateLoggerHelper.fromRequest(request, logger);
        logger = PopulateLoggerHelper.fromResponse(response, logger);
        System.debug('Created \'Logger__c\': ' + logger);

        return logger;
    }

    public void setSObjectLookup(String lookFielAPIName, String id) {
        try{
            this.logger.put(lookFielAPIName, id);
            update this.logger;
        }
        catch(Exception e) {
            throw new LoggeCustomException(
                LoggeCustomException.tryToConnectInvalidLookup(
                    lookFielAPIName
                    )
                );
        }
        System.debug(
            'Updated SObject lookup in this logger: ' +
            this.logger
            );
    }

    private void insertRecordsToDB() {
        if (this.controller.Put_Data_In_Fields__c) {
            this.logger = putRequestAndResponseInFields(
                this.givenRequest,
                this.givenResponse
                );
            insert this.logger;
        }
        else {
            insert this.logger;
            this.requestFile = createRequestFile(this.givenRequest, this.logger);
            this.responseFile = createResponseFile(this.givenResponse, this.logger);
        }
    }

    private Logger__c putRequestAndResponseInFields(HttpRequest request, HttpResponse response) {
        String prettyResBody = FileMakerUtils.makeBodyToPrettyJson(response);
        String prettyReqBody = FileMakerUtils.makeRequestBodyToPrettyJson(request);
        this.logger.Response_Body__c = prettyResBody;
        this.logger.Request_Body__c = prettyReqBody;

        return this.logger;
    }
}