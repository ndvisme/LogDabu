public with sharing class LoggerWrapper {

    private ContentVersion requestBodyFile;
    private Logger__c logger;

    public LoggerWrapper(HttpRequest request) {
        this.logger = createLogger();
        this.requestBodyFile = makeFileWithBodyContentFrom(request);
        System.debug(
            'In \'LoggerWrapper\' constructor. \n '+
            'Created: \n' +
            '\'Logger__c\', Id: ' + this.logger.Id
        );
    }


    private ContentVersion makeFileWithBodyContentFrom(HttpRequest request) {
        System.debug(
            'In method: \'makeFileWithBodyContentFrom\' \n' +
            'Input: ' + request + '\n'
            );
        String prettyJsonString = makeRequestBodyToPrettyJson(request);
        Blob fileBody = Blob.valueOf(prettyJsonString);
        String fileName = 'myfile.txt';
		ContentVersion contentVersion = createContentVersion(fileName, fileBody);

        ContentDocumentLink Cdl = createContentDocumentLinkFrom(contentVersion);
        System.debug(
            'Created: \n' +
            '\'ContentVersion\', Id: ' + contentVersion.Id + '\n' +
            '\'ContentDocumentLink\', Id: ' + ContentDocumentLink.Id
        );

        return contentVersion;
    }

    private Logger__c createLogger() {
        Logger__c logger = new Logger__c();
		insert logger;

        return logger;
    }

    private ContentDocumentLink createContentDocumentLinkFrom(ContentVersion contentVersion) {
        ContentDocumentLink Cdl = new ContentDocumentLink();
        contentVersion = [SELECT id, ContentDocumentId FROM ContentVersion WHERE Id =: contentVersion.Id LIMIT 1];
        Cdl.ContentDocumentId = contentVersion.ContentDocumentId;
		Cdl.LinkedEntityId = this.logger.Id;
		Cdl.ShareType = 'V';
		Cdl.Visibility = 'AllUsers';
        insert Cdl;

        return Cdl;
    }

    private ContentVersion createContentVersion(String fileName, Blob fileBody) {
        ContentVersion contentVersion = new ContentVersion();
        contentVersion.Title = fileName;
        contentVersion.PathOnClient = fileName;
        contentVersion.VersionData = fileBody;
		insert contentVersion;

        return contentVersion;
    }


    private String makeRequestBodyToPrettyJson(HttpRequest request) {
     	Map<String, Object> jsonMap = (Map<String, Object>) JSON.deserializeUntyped(request.getBody());
        String prettyJsonString = JSON.serializePretty(jsonMap);
        System.debug('prettyJsonString: ' + prettyJsonString);

        return prettyJsonString;
    }
}