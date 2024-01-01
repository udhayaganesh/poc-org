import { LightningElement,wire } from 'lwc';
import { publish, subscribe, MessageContext } from 'lightning/messageService';
import JOB_FILTERED_MESSAGE from '@salesforce/messageChannel/JobFiltered__c';
// The delay used when debouncing event handlers before firing the event
const DELAY = 350;
export default class Jobfilter extends LightningElement {
    searchKey = '';
    @wire(MessageContext)
    messageContext;

    filters = {
        searchKey: '',
      
    };
    
    handleSearchKeyChange(event) {
        this.filters.searchKey = event.target.value;
        console.log('searchKey::::::::::::'+this.filters.searchKey);
        this.delayedFireFilterChangeEvent();
    }

    delayedFireFilterChangeEvent() {
        // Debouncing this method: Do not actually fire the event as long as this function is
        // being called within a delay of DELAY. This is to avoid a very large number of Apex
        // method calls in components listening to this event.
        //window.clearTimeout(this.delayTimeout);
        // eslint-disable-next-line @lwc/lwc/no-async-operation
        console.log('fire::::::::::::'+this.filters);
       // this.delayTimeout = setTimeout(() => {
            // Published ProductsFiltered message
            publish(this.messageContext, JOB_FILTERED_MESSAGE, {
                filters: this.filters
            });
            console.log('sent fire::::::::::::');
            //this.senderMsg.push(this.inputValue);
       // }, DELAY);
    }

}