

// REQUEST
String jsonAsString = '{"menu":{"id":"file","value":"File","popup":{"menuitem":[{"value":"New","onclick":"CreateNewDoc()"},{"value":"Open","onclick":"OpenDoc()"},{"value":"Close","onclick":"CloseDoc()"}]}}}';
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

// CONTROLLER
Logg_Controller__c controller = new Logg_Controller__c();
insert controller;
controller = [
        SELECT Log_Only_Failures__c, Logger_Record_Names__c, Name, Put_Data_In_Fields__c
        FROM Logg_Controller__c
        WHERE Id =: controller.id
        LIMIT 1
    ];

Account acc = new Account(
    Name = 'Jhon'
);
insert acc;

// CREATE LOGGER
 LoggerWrapper loggerWrapper = new LoggerWrapper(
    request,
    response,
    controller
    );
loggerWrapper.create();
loggerWrapper.setSObjectLookup('TEST_DO_NOT_DELTE_Account__c', acc.Id);

// REQUEST #2
jsonAsString = '{"Name": "Nadav"}';
request = new HttpRequest();
request.setEndpoint('http://www.yahoo.com');
request.setMethod('POST');
request.setBody(jsonAsString);
request.setHeader('content-type', 'json');

// RESPONSE #2
json = '{' +
        '"Success": "Hello World"' +
    '}';
response = new HttpResponse();
response.setStatusCode(200);
response.setHeader('content-type', 'json');
response.setBody(json);

loggerWrapper = new LoggerWrapper(
    request,
    response,
    controller
    );
loggerWrapper.create();
loggerWrapper.setSObjectLookup('TEST_DO_NOT_DELTE_Account__c', acc.Id);
 loggerWrapper = new LoggerWrapper(
    request,
    response,
    controller
    );
loggerWrapper.create();
loggerWrapper.setSObjectLookup('TEST_DO_NOT_DELTE_Account__c', acc.Id);