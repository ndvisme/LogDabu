public with sharing class FileMakerFromHTTP {

    private static final String JSON_FORMAT = 'json';
    public ContentVersion file;


    public FileMakerFromHTTP(HttpRequest request, Logger__c logger) {
        System.debug('Making File');
        this.file = make(request, logger);
    }

    private ContentVersion make(HttpRequest request, Logger__c logger) {
        String formatType = getFormatTypeFrom(request);
        if(formatType == JSON_FORMAT) {
            this.file = makeFileJSONFormat(request, logger);
        }
        else {
            throw new LoggeCustomException(
                LoggeCustomException.UNSOPURTTED_FORMAT + formatType
                );
        }

        return this.file;
    }

    private String getFormatTypeFrom(HttpRequest request) {
        String formatType = request.getHeader('content-type');

        return formatType;
    }

    private ContentVersion makeFileJSONFormat(HttpRequest request, Logger__c logger) {
        String prettyJsonString = makeRequestBodyToPrettyJson(request);
        Blob fileBody = Blob.valueOf(prettyJsonString);
        String fileName = 'Request_' + logger.Id + '.txt';
		ContentVersion contentVersion = createContentVersion(fileName, fileBody);

        ContentDocumentLink Cdl = createContentDocumentLinkFrom(contentVersion, logger);
        System.debug(
            'Created: \n' +
            '\'ContentVersion\', Id: ' + contentVersion.Id + '\n' +
            '\'ContentDocumentLink\', Id: ' + ContentDocumentLink.Id
        );

        return contentVersion;
    }

    private ContentDocumentLink createContentDocumentLinkFrom(ContentVersion contentVersion, Logger__c logger) {
        ContentDocumentLink Cdl = new ContentDocumentLink();
        contentVersion = [SELECT id, ContentDocumentId FROM ContentVersion WHERE Id =: contentVersion.Id LIMIT 1];
        Cdl.ContentDocumentId = contentVersion.ContentDocumentId;
		Cdl.LinkedEntityId = logger.Id;
		Cdl.ShareType = 'V';
		Cdl.Visibility = 'AllUsers';
        insert Cdl;

        return Cdl;
    }


    private static ContentVersion createContentVersion(String fileName, Blob fileBody) {
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
