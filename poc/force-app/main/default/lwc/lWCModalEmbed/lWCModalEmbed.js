import { LightningElement } from 'lwc';
import lWCModal from 'c/lWCModal';

export default class LWCModalEmbed extends LightningElement {
    async openModal() {
        const result = await lWCModal.open({
            size: 'small', //small, medium, or large default :medium
            description: 'Accessible description of modal\'s purpose',
            content: 'Open LWC form for get details',
        });
        console.log(result);
    }
}