// create custom controller:
RecordType recordType = [
            SELECT Id
            FROM RecordType
            WHERE sObjectType='Logg_Controller__c' AND Name = 'Dummy For Testing Porpuses'
            LIMIT 1
        ];
Logg_Controller__c customController = new Logg_Controller__c(
            RecordTypeId = recordType.Id,
            Log_Only_Failures__c = true,
            Put_Data_In_Fields__c = true,
            Logger_Record_Names__c = 'Data In Fields'
        );
insert customController;

// REQUEST
String jsonAsString = '{"name" : "Jhon", "Last Name" : "Doe"}';
HttpRequest request = new HttpRequest();
request.setEndpoint('http://www.yahoo.com');
request.setMethod('POST');
request.setBody(jsonAsString);
request.setHeader('content-type', 'json');


// RESPONSE
String json = '{' +
        '"error": "Login Required"' +
    '}';
HttpResponse response = new HttpResponse();
response.setStatusCode(400);
response.setHeader('content-type', 'json');
response.setBody(json);
Account acc = new Account(
    Name = 'Jhon'
);
insert acc;

 // CREATE LOGGER
 LoggerWrapper loggerWrapper = new LoggerWrapper(
    request,
    response,
    customController
    );
loggerWrapper.create();
loggerWrapper.setSObjectLookup('TEST_DO_NOT_DELTE_Account__c', acc.Id);

loggerWrapper = new LoggerWrapper(
    request,
    response,
    customController
    );
loggerWrapper.create();
loggerWrapper.setSObjectLookup('TEST_DO_NOT_DELTE_Account__c', acc.Id);