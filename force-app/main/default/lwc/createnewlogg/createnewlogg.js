import { LightningElement,api, track, wire  } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
import { CurrentPageReference } from 'lightning/navigation';

import RECORDS_NAME from '@salesforce/schema/Logg_Controller__c.Logger_Record_Names__c';
import LOG_ONLY_FAILURE from '@salesforce/schema/Logg_Controller__c.Log_Only_Failures__c';

export default class createnewlogg extends NavigationMixin(LightningElement)  {

    // objectApiName is "Order" when this component is called
    @api objectApiName;
    @api CardTitle;
    @track isShowModal = false;

    fields = [LOG_ONLY_FAILURE, RECORDS_NAME];

    @wire(CurrentPageReference)
    currentPageReference;

    connectedCallback() {
        console.log(`recordTypeId = ${this.currentPageReference.state.recordTypeId}`);
        this.recordTypeId = this.currentPageReference.state.recordTypeId;
        console.log(this.recordTypeId + this.recordTypeId);
    }

    handleSuccess(event) {
        console.log(JSON.stringify(event.detail))
        const evt = new ShowToastEvent({
            title: 'Controller created',
            variant: 'success',
        });
        this.dispatchEvent(evt);
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: event.detail.id,
                objectApiName: 'Logg_Controller__c',
                actionName: 'view'
            },
        });
    }
    closeModal() {
        // Navigation to Order List view(recent)
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Logg_Controller__c',
                actionName: 'list'
            },
            state: {
                filterName: 'Recent'
            },
        });
    }
}