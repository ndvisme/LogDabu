

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


// CREATE LOGGER
 LoggerWrapper logger = new LoggerWrapper(request, response);