public with sharing class FileMakerUtils {

    public static ContentVersion jsonFormat(HttpResponse response, Logger__c logger) {
        String prettyJsonString = makeBodyToPrettyJson(
            response
            );
        Blob fileBody = Blob.valueOf(prettyJsonString);
        String fileName = 'Response_' + logger.Id + '.txt';
        ContentVersion contentVersion = createContentVersion(
            fileName,
            fileBody
            );
        ContentDocumentLink Cdl = createContentDocumentLinkFrom(
            contentVersion,
            logger
            );

        return contentVersion;
    }

    public static ContentVersion jsonFormat(HttpRequest request, Logger__c logger) {
        String prettyJsonString = makeRequestBodyToPrettyJson(request);
        Blob fileBody = Blob.valueOf(prettyJsonString);
        String fileName = 'Request_' + logger.Id + '.txt';
		ContentVersion contentVersion = createContentVersion(fileName, fileBody);
        ContentDocumentLink Cdl = createContentDocumentLinkFrom(contentVersion, logger);

        return contentVersion;
    }

    private static ContentDocumentLink createContentDocumentLinkFrom(ContentVersion contentVersion, Logger__c logger) {
        ContentDocumentLink Cdl = new ContentDocumentLink();
        contentVersion = queryContentVersionsWhereIdIs(
            contentVersion.Id
            );
        Cdl.ContentDocumentId = contentVersion.ContentDocumentId;
		Cdl.LinkedEntityId = logger.Id;
		Cdl.ShareType = 'V';
		Cdl.Visibility = 'AllUsers';
        insert Cdl;
        System.debug(
            'Created this ContentDocumentLink: \n' +
            Cdl
            );

        return Cdl;
    }

    private static ContentVersion createContentVersion(String fileName, Blob fileBody) {
        ContentVersion contentVersion = new ContentVersion();
        contentVersion.Title = fileName;
        contentVersion.PathOnClient = fileName;
        contentVersion.VersionData = fileBody;
		insert contentVersion;
        System.debug(
            'Created this ContentVersion: \n' +
            contentVersion
            );

        return contentVersion;
    }

    private static String makeBodyToPrettyJson(HttpResponse response) {
        Map<String, Object> jsonMap = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        String prettyJsonString = JSON.serializePretty(jsonMap);
        System.debug('prettyJsonString: ' + prettyJsonString);

        return prettyJsonString;
    }


    private static String makeRequestBodyToPrettyJson(HttpRequest request) {
     	Map<String, Object> jsonMap = (Map<String, Object>) JSON.deserializeUntyped(request.getBody());
        String prettyJsonString = JSON.serializePretty(jsonMap);
        System.debug('prettyJsonString: ' + prettyJsonString);

        return prettyJsonString;
    }

    private static ContentVersion queryContentVersionsWhereIdIs(String contentVersionId) {
        return [
            SELECT id, ContentDocumentId
            FROM ContentVersion
            WHERE Id =: contentVersionId
            LIMIT 1
            ];
    }
}