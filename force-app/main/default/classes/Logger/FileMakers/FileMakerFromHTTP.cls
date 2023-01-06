public with sharing class FileMakerFromHTTP {

    private static final String JSON_FORMAT = 'json';
    public ContentVersion requestfile;


    public FileMakerFromHTTP(HttpRequest request, Logger__c logger) {
        System.debug('Making File');
        this.requestfile = makeRequestFile(request, logger);
    }

     private ContentVersion makeRequestFile(HttpRequest request, Logger__c logger) {
        if(LoggerUtils.httpRequestIsJSON(request)) {
            this.requestfile = FileMakerUtils.jsonFormat(
                request,
                logger
                );
        }
        else {
            throw new LoggeCustomException(
                LoggeCustomException.UNSOPURTTED_FORMAT +
                LoggerUtils.getFormatTypeFrom(request)
                );
        }

        return this.requestfile;
    }
}