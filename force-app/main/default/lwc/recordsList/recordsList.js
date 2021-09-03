import {LightningElement, api, wire} from 'lwc';
import getObjectsB from '@salesforce/apex/RecordsListController.getObjectsB';
import getObjectsC from '@salesforce/apex/RecordsListController.getObjectsC';

// Default table columns
const COLUMNS = [
	{ label: 'Name',fieldName: 'Name'},
	{ label: 'Age',fieldName: 'Age__c'},
	{ label: 'Phone',fieldName: 'Phone__c'}
];

export default class recordsList extends LightningElement {
    // Get recordId from ObjectA
     @api recordId;

     // Get values from related object B and C
     @wire(getObjectsB, {recordId: '$recordId'})
     recordB;
     @wire(getObjectsC, {recordId: '$recordId'})
     recordC;

     /*
        Array that allows to get a dynamic title and to concatenate pretended objects
        They must be declared with the same name above in @wire
    */
     allowedRecords = ['recordB', 'recordC'];

     data = [];
     columns = COLUMNS;
     title = 'Records list for';


    connectedCallback() {
        // The title will be build based on the objects pretended 
        this.allowedRecords.forEach((record, index) => {
            if (index !== 0) this.title = this.title + ' and ' + record;
            else this.title = this.title + ' ' + record;
        })
        
        // Dinamically merge object records defined on allowedRecords
        this.delayTimeout = setTimeout(() => {
        this.allowedRecords.forEach(record => {
            if(this[record].data.length) this.data = this.data.concat(this[record].data);
        })
		}, 800);
	}
    
}