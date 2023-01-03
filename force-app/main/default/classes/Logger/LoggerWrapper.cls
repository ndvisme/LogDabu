public with sharing class LoggerWrapper {


    private Logger__c logger;
    public FileMakerFromHTTP requestFileMaker;


    public LoggerWrapper(HttpRequest request) {
        System.debug('In \'LoggerWrapper Constuctor\'.');
        this.logger = createLogger();
        this.requestFileMaker = new FileMakerFromHTTP(request, this.logger);
    }

    private Logger__c createLogger() {
        Logger__c logger = new Logger__c();
		insert logger;
        System.debug('Created \'Logger__c\', Id: ' + logger.Id);

        return logger;
    }
}