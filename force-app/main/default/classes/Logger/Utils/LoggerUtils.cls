public with sharing class LoggerUtils {


    private static final String JSON_FORMAT = 'json';


    public static Boolean httpRequestIsJSON(HttpRequest request) {
        Boolean isJson = false;
        String formatType = getFormatTypeFrom(request);
        if(formatType == JSON_FORMAT) {
            isJson = true;
        }

        return isJson;
    }

    public static Boolean httpResponseIsJSON(HttpResponse response) {
        Boolean isJson = false;
        String formatType = getFormatTypeFrom(response);
        if(formatType == JSON_FORMAT) {
            isJson = true;
        }

        return isJson;
    }

    public static String getFormatTypeFrom(HttpRequest request) {
        String formatType = request.getHeader('content-type');

        return formatType;
    }

    public static String getFormatTypeFrom(HttpResponse response) {
        String formatType = response.getHeader('content-type');

        return formatType;
    }
}