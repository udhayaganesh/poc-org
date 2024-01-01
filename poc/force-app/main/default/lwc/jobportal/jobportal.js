import {subscribe, MessageContext, APPLICATION_SCOPE,   
  unsubscribe,publish} from 'lightning/messageService';
import { LightningElement, api, track,wire } from 'lwc';
import getJP from '@salesforce/apex/JobPortalController.getJP';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
import JOB_FILTERED_MESSAGE from '@salesforce/messageChannel/JobFiltered__c';
export default class Jobportal extends NavigationMixin(LightningElement) {
 @track summaryData; 
 @track selectedrecid; 
 @wire(MessageContext)
 messageContext;
summarypage= true;
  detailpage= false;
 
  filters = {};

  productFilterSubscription=null;

  subscribeMessage(){
     
    console.log('subscribeMessage');

    this.productFilterSubscription = subscribe(this.messageContext, JOB_FILTERED_MESSAGE,
      /* (message) => {
      //console.log('#####'+JSON.parse(message.filters));
      console.log('#####'+JSON.stringify(message.filters));
      var incommsg=(message.filters).searchKey;
      console.log('###came##'+incommsg);
  
  this.searchString = incommsg;
      this.handleFilterChange(message); 
     */

      (message) => this.callapexMethod((message.filters).searchKey),
      {scope: APPLICATION_SCOPE}
  );
  
  }
connectedCallback() {
this.subscribeMessage();
 
this.callapexMethod();
}
callapexMethod(searchString){
  console.log('value :::'+this.searchString);
getJP({str: searchString}).then(result => {
  console.log(result);
  this.summaryData = result;
  }).catch(function(error){
          console.error(error);
  });
}
handleFilterChange(message) {
  
  this.filters = { ...message.filters };
  
}

handleSelect(event)
{
    this.summarypage =false;
    this.detailpage=true;
    //alert('came'+event.currentTarget.id);
    this.selectedrecid = event.target.getAttribute("id");
    alert(this.selectedrecid);
    
}

/*
@wire (getJP) summaryData   ({data,error}){
          if (data) {
          console.log('########'+data); 
          } else if (error) {
          console.log('@@@@@@@'+error);
          }
     }
 */
}