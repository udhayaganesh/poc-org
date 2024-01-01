import { LightningElement } from 'lwc';
 import { fireEvent } from 'c/pubsub';
     
export default class ParentCmp extends LightningElement {


	 
	  
 handleCarSelect(event){
        event.preventDefault();

        const carId = '123123'; this.car.Id;

        const carSelect = new CustomEvent('carselect', {detail:carId});
        this.dispatchEvent(carSelect);

        fireEvent(this.pageRef, 'carselect', this.car);
    }
	
	
	
}