public with sharing class LoggerWrapper {


    private Logger__c logger;
    public FileMakerFromHTTP requestFileMaker;
    public HttpResponseFileMaker responseFileMaker;
    public ContentVersion requestFile;
    public ContentVersion responseFile;


    public LoggerWrapper(HttpRequest request, HttpResponse response) {
        System.debug('In \'LoggerWrapper Constuctor\'.');
        this.logger = createLogger();
        this.requestFile = createRequestFile(request, this.logger);
        this.responseFile = createResponseFile(response, this.logger);
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

    private Logger__c createLogger() {
        Logger__c logger = new Logger__c();
		insert logger;
        System.debug('Created \'Logger__c\', Id: ' + logger.Id);

        return logger;
    }
}