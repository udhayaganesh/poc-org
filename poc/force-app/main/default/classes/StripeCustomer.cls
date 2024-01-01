public class StripeCustomer{
	/*public StripeGetResponseValues StripeGetResponseValue{get;set;}
	public StripeResponseModel StripeResponseModel{get;set;}
	Integer statusCode;
	string response;
	String CUSTOMER_URL = 'https://api.stripe.com/v1/customers';
	String API_KEY = 'SecretToken';
	public StripeCustomer(String apikey){
		API_KEY=apikey;
		StripeGetResponseValue=new StripeGetResponseValues();
		StripeResponseModel=new StripeResponseModel();
	}
	@future(callout=true)
	public static void createCustomer(String cnumber,String exp_month,String exp_year,String cvc,String name,String addressLine1,String addressLine2,String zip,String state,String country,String email,String description,string oConId,String oLeadId){
	Integer statusCode;
	string response;
	string sCusId;
	Lead oLead = new Lead();
	Contact oCon = new Contact();
	String CUSTOMER_URL = 'https://api.stripe.com/v1/customers';
	String API_KEY = 'SecretToken';
	HttpRequest http = new HttpRequest();
	http.setEndpoint(CUSTOMER_URL);
	http.setMethod('POST');
	Blob headerValue = Blob.valueOf(API_KEY + ':');
	String authorizationHeader = 'BASIC ' +
	EncodingUtil.base64Encode(headerValue);
	http.setHeader('Authorization', authorizationHeader);
	http.setBody('email='+email+'&description='+description+'&source=tok_visa');
	if(!Test.isRunningTest()){
	Http con = new Http();
	HttpResponse hs = con.send(http);
	system.debug('#### '+ hs.getBody());
	response = hs.getBody();
	statusCode=hs.getStatusCode();
	system.debug('$$statusCode='+hs.getStatusCode());
	system.debug('email==========='+email );
	JSONParser parser = JSON.createParser(hs.getBody());
	System.JSONToken token;
	string text;
		while((token = parser.nextToken()) != null) {
		// Parse the object
			if ((token = parser.getCurrentToken()) != JSONToken.END_OBJECT) {
				text = parser.getText();
				if (token == JSONToken.FIELD_Name && text == 'id') {
					token=parser.nextToken();
					if(oCon != null){
						if(parser.getText().contains('cus')){
							sCusId = parser.getText();
						}
					}
				}
			}
		}
		if(oConId != null){
			oCon = [SELECT Id, Customer_Id__c FROM Contact WHERE Email = :email AND Customer_Id__c = null LIMIT 1];
			oCon.Customer_Id__c = sCusId ;
			update oCon;
		}
		if(oLeadId != null){
			oLead = [SELECT Id, Customer_Id__c FROM Lead WHERE Email = :email AND Customer_Id__c = null LIMIT 1];
			oLead.Customer_Id__c = sCusId ;
			update oLead ;
		}
		}else{
			statusCode=200;
			response='"created": 1317825831,';
			response+='"description": "testing",';
			response+='"email": "gamer.sanjay@gmail.com",';
			response+='"id": "cus_wCA0LuIzUzRYZp",';
			response+='"livemode": false,';
			response+='"object": "customer",';
			response+='"active_card": {';
			response+='"address_country": "India",';
			response+='"address_line1": "add1",';
			response+='"address_line1_check": "pass",';
			response+='"address_line2": "add22",';
			response+='"address_state": "Rajasthan",';
			response+='"address_zip": "123123",';
			response+='"address_zip_check": "pass",';
			response+='"country": "US",';
			response+='"cvc_check": "pass",';
			response+='"exp_month": 12,';
			response+='"exp_year": 2013,';
			response+='"last4": "4242",';
			response+='"name": "sanjay",';
			response+='"object": "card",';
			response+='"type": "Visa"';
			response+='}';
			response+='}';
		}
		if(statusCode!=200){
			// StripeResponseModel.errorResponse.code=statusCode;
			//StripeResponseModel.errorResponse.message=StripeGetResponseValue.getValue(response,'"message":');
			// StripeResponseModel.errorResponse.param =StripeGetResponseValue.getValue(response,'"param":');
			//StripeResponseModel.errorResponse.error_type=StripeGetResponseValue.getValue(response,'"type":');
			//StripeResponseModel.errorResponse.error_type=StripeGetResponseValue.getLastValue(response,'"type":');
			//StripeResponseModel.isError=true;
		}else{
			
		}
			// system.debug('**StripeResponseModel='+StripeResponseModel);
			//return StripeResponseModel;
		}


		public StripeResponseModel retrieveCustomer(String customerId){
			HttpRequest http = new HttpRequest();
			String mainUrl=CUSTOMER_URL+'/'+customerId;
			http.setEndpoint(mainUrl);
			http.setMethod('GET');
			Blob headerValue = Blob.valueOf(API_KEY + ':');
			String authorizationHeader = 'BASIC ' +
			EncodingUtil.base64Encode(headerValue);
			http.setHeader('Authorization', authorizationHeader);
			if(!Test.isRunningTest()){
			Http con = new Http();
			HttpResponse hs = con.send(http);
			system.debug('#### '+ hs.getBody());
			response = hs.getBody();
			statusCode=hs.getStatusCode();
		}
		else{
			statusCode=200;
			response='"created": 1317825831,';
			response+='"description": "testing",';
			response+='"email": "gamer.sanjay@gmail.com",';
			response+='"id": "cus_wCA0LuIzUzRYZp",';
			response+='"livemode": false,';
			response+='"object": "customer",';
			response+='"active_card": {';
			response+='"address_country": "India",';
			response+='"address_line1": "add1",';
			response+='"address_line1_check": "pass",';
			response+='"address_line2": "add22",';
			response+='"address_state": "Rajasthan",';
			response+='"address_zip": "123123",';
			response+='"address_zip_check": "pass",';
			response+='"country": "US",';
			response+='"cvc_check": "pass",';
			response+='"exp_month": 12,';
			response+='"exp_year": 2013,';
			response+='"last4": "4242",';
			response+='"name": "sanjay",';
			response+='"object": "card",';
			response+='"type": "Visa"';
			response+='}';
			response+='}';
		}
		if(statusCode!=200){
			StripeResponseModel.errorResponse.code=statusCode;
			StripeResponseModel.errorResponse.message=StripeGetResponseValue.getValue(response,'"message":');
			StripeResponseModel.errorResponse.param =StripeGetResponseValue.getValue(response,'"param":');
			//StripeResponseModel.errorResponse.error_type=StripeGetResponseValue.getValue(response,'"type":');
			StripeResponseModel.errorResponse.error_type=StripeGetResponseValue.getLastValue(response,'"type":');
			StripeResponseModel.isError=true;
		}else{
			StripeResponseModel.isError=false;
			StripeResponseModel.id=StripeGetResponseValue.getValue(response,'"id":');
			StripeResponseModel.rObject=StripeGetResponseValue.getValue(response,'"object":');
			StripeResponseModel.description=StripeGetResponseValue.getValue(response,'"description":');
			StripeResponseModel.livemode=StripeGetResponseValue.getNumValue(response,'"livemode":');
			StripeResponseModel.created=StripeGetResponseValue.getNumValue(response,'"created":');
			//StripeResponseModel.card.ctype=StripeGetResponseValue.getValue(response,'"type":');
			StripeResponseModel.card.ctype=StripeGetResponseValue.getLastValue(response,'"type":');
			StripeResponseModel.card.cObject=StripeGetResponseValue.getValue(response,'"object":');
			StripeResponseModel.card.country =StripeGetResponseValue.getValue(response,'"country":');
			StripeResponseModel.card.exp_month=StripeGetResponseValue.getNumValue(response,'"exp_month":');
			StripeResponseModel.card.last4 =StripeGetResponseValue.getValue(response,'"last4":');
			StripeResponseModel.card.exp_year=StripeGetResponseValue.getNumValue(response,'"exp_year":');
		}
		system.debug('**StripeResponseModel='+StripeResponseModel);
		return StripeResponseModel;
	}*/
}