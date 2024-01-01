import { LightningElement, api, track,wire } from 'lwc';
import getJPRec from '@salesforce/apex/JobPortalController.getJPRec';
export default class Jobportaldetails extends LightningElement {
@track summaryData; 
@api recordid;
 
connectedCallback() {
  
  getJPRec({recid: 'a0x2w000006E1fjAAC'}).then(result => {
    console.log(result);
    this.summaryData = result;
    }).catch(function(error){
            console.error(error);
    });
 
}
}