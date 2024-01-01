import { LightningElement, api } from 'lwc';


export default class Jobtile extends LightningElement {

    @api draggable;
    _job;
    name='';
    recid;
    selectedrecid;
    @api
    get job() {
        return this._job;
    }
    set job(value) {
        console.log('JOB::::::::::'+value.Name);
        this._job = value;
        this.recid = value.Id;
        this.name = value.Name;
        
    }
    handleSelect(event)
{
    this.selectedrecid= this.recid;
     
   
    
}


}
 