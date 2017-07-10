public class populateTestData {
    public static final String ACCESS_KEY = 'dp9aP-9Juxf7NNzPyml7k0LJfaC5KDTOOEo_D2JVITcRFAz9sSJOLAxDjsgIk-9v';

    public static void populate() {
        DateTime closedTime = DateTime.now();
        
        //Create 10 baskets of 10 items each
        for(Integer baskets=0; baskets<5; baskets++) {
            for(Integer i=0; i<10; i++) {
                closedTime.addMinutes(5);
                String closedTimeStr = String.valueOf(closedTime.year()) + '-' + addLeadingZeros(String.valueOf(closedTime.month())) + '-' + addLeadingZeros(String.valueOf(closedTime.day())) + 'T' + addLeadingZeros(String.valueOf(closedTime.hour())) + ':' + addLeadingZeros(String.valueOf(closedTime.minute())) + ':' + addLeadingZeros(String.valueOf(closedTime.second())) + '.' + adjustMs(String.valueOf(closedTime.millisecond())) + '-08:00';
                //Send the api call for the first item in this basket
                HttpRequest req = new HttpRequest();
                req.setMethod('POST');
                req.setEndpoint('http://events-mj.herokuapp.com/events.json?accessKey=' + ACCESS_KEY);
                req.setHeader('Content-Type','application/json');
                req.setBody('{'
                  + '"event" : "buy",'
                  + '"entityType" : "user",'
                  + '"entityId" : "user",'
                  + '"targetEntityType" : "item",'
                  + '"targetEntityId" : "item-' + i + '",'
                  + '"eventTime" : "' + closedTimeStr + '"'
                + '}');
                Http http = new Http();
                HTTPResponse res = http.send(req);
                
            }  
        }
    }
    
    //Helper method for formatting event date in event server db
    private static String addLeadingZeros (String str) {
        return str.length() == 2 ? str : '0' + str;
    }
    
    //Helper method for formatting event date in event server db
    private static String adjustMs (String str) {
        String retStr;
        if(str.length() == 3) {
            retStr = str;
        } else if(str.length() > 3) {
            retStr = str.substring(0,3);
        } else if (str.length() == 0) {
            retStr = '000';
        } else if (str.length() == 1) {
            retStr = '00' + str;   
        } else if (str.length() == 2) {
            retStr = '0' + str;
        }
        return retStr;
    }

}