import { LightningElement,api, track, wire  } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
import { CurrentPageReference } from 'lightning/navigation';

import RECORDS_NAME from '@salesforce/schema/Logg_Controller__c.Logger_Record_Names__c';
import LOG_ONLY_FAILURE from '@salesforce/schema/Logg_Controller__c.Log_Only_Failures__c';
import PUT_DATA_IN_FIELDS from '@salesforce/schema/Logg_Controller__c.Put_Data_In_Fields__c';

export default class createnewlogg extends NavigationMixin(LightningElement)  {


    @api objectApiName;
    @api CardTitle;
    @track isShowModal = false;
    myCustomObjectId;

    fields = [LOG_ONLY_FAILURE, RECORDS_NAME, PUT_DATA_IN_FIELDS];

    @wire(CurrentPageReference)
    currentPageReference;

    connectedCallback() {
        this.recordTypeId = this.currentPageReference.state.recordTypeId;
        console.log(this.recordTypeId);
    }

    handleSuccess(event) {
        console.log('onsuccess event recordEditForm', event.detail.id );
        this.myCustomObjectId= event.detail.id;
        this[NavigationMixin.Navigate]({
          type: 'standard__recordPage',
          attributes: {
            recordId: this.myCustomObjectId,
            actionName: 'view'
          },
        });
    }

    closeModal() {
      window.history.back();
    }

    errorHandler(event) {
      const e = new ShowToastEvent({
        title : event.detail.message,
        message : event.detail.detail,
        variant : "error"
      })

      this.dispatchEvent(e)
    }
}