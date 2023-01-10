public with sharing class HttpResponseFileMaker {


    public ContentVersion jsonFile;


    public HttpResponseFileMaker(HttpResponse response, Logger__c logger) {
        System.debug('In HttpResponseFileMaker constructor.');
        this.jsonFile = make(response, logger);
    }

	private ContentVersion make(HttpResponse response, Logger__c logger) {
        if(LoggerUtils.httpResponseIsJSON(response)) {
            this.jsonFile = FileMakerUtils.jsonFormat(
                response,
                logger
                );
        }
        else {
            throw new LoggeCustomException(
                LoggeCustomException.UNSOPURTTED_FORMAT +
                LoggerUtils.getFormatTypeFrom(response)
                );
        }

		return this.jsonFile;
	}
}