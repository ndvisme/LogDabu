public with sharing class PopulateLoggerHelper {


    public static Logger__c fromRequest(HttpRequest request, Logger__c logger) {
        logger = putAPIVerb(request, logger);
        logger = putEndPoint(request, logger);
        System.debug('Logger After populate from HTTP request: ' + logger);

        return logger;
    }

    public static Logger__c fromResponse(HttpResponse response, Logger__c logger) {
        logger = putStatusCode(response, logger);
        System.debug('Logger After populate from HTTP response: ' + logger);

        return logger;
    }

    public static Logger__c putTrace(Logger__c logger, String apexTrace) {
        logger.Apex_Call_Trace__c = apexTrace;

        return logger;
    }

    private static Logger__c putStatusCode(HttpResponse response, Logger__c logger) {
        Integer statusFromResponse = response.getStatusCode();
        logger.Response_Status_Code__c = statusFromResponse;

        return logger;
    }

    private static Logger__c putAPIVerb(HttpRequest request, Logger__c logger) {
        String requestVerb = request.getMethod();
        logger.API_Verb__c = requestVerb;

        return logger;
    }

    private static Logger__c putEndPoint(HttpRequest request, Logger__c logger) {
        String requestEndPoint = request.getEndpoint();
        logger.End_Point__c = requestEndPoint;

        return logger;
    }
}
