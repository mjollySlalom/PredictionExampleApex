public class TestPrediction {
    
    
    public static void predict(String str) {
        
        //Make the API call to the recommendation engine
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setEndpoint('http://comp-engine-mj.herokuapp.com/queries.json');
        req.setHeader('Content-Type','application/json');
        req.setBody('{ "items": ["' + str + '"], "num": ' + 20 + ' }');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        System.debug(res.getBody());
    }
}