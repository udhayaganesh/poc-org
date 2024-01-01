import { api } from 'lwc';
import LightningModal from 'lightning/modal';

export default class LWCModal extends LightningModal {
    @api content;

    handleClose() {
        this.close('close popup');
    }

    handleSave() {
        let data = {};
        this.template.querySelectorAll('lightning-input').forEach(currentItem => {
            data[currentItem.name] = currentItem.value;
        });

        console.log(data);
        this.close(data);
    }
}