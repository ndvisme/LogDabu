import { LightningElement,api, track, wire  } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
import { CurrentPageReference } from 'lightning/navigation';

import RECORDS_NAME from '@salesforce/schema/Logg_Controller__c.Logger_Record_Names__c';
import LOG_ONLY_FAILURE from '@salesforce/schema/Logg_Controller__c.Log_Only_Failures__c';

export default class createnewlogg extends NavigationMixin(LightningElement)  {


    @api objectApiName;
    @api CardTitle;
    @track isShowModal = false;

    fields = [LOG_ONLY_FAILURE, RECORDS_NAME];

    @wire(CurrentPageReference)
    currentPageReference;

    connectedCallback() {
        this.recordTypeId = this.currentPageReference.state.recordTypeId;
        console.log(this.recordTypeId);
    }

    handleSuccess(event) {
        console.log('onsuccess event recordEditForm',event.detail.id);
        this[NavigationMixin.Navigate]({
          type: 'standard__recordPage',
          attributes: {
            recordId: event.detail.id,
            objectApiName: 'GRA_RV_Rig_Verification__c',
            actionName: 'view'
          },
        });
      }
}