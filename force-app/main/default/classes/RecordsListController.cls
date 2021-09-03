public with sharing class RecordsListController {

    //get list of objects_B related to objects_A
    @AuraEnabled(Cacheable=true)
    public static ObjectB__c[] getObjectsB(Id recordId) {
        return [SELECT Id, Name, Phone__c, Age__c FROM ObjectB__c where objectA__c = :recordId];
    }

    //get list of objects_C related to objects_A
    @AuraEnabled(Cacheable=true)
    public static ObjectC__c[] getObjectsC(Id recordId) {
        return [SELECT Id, Name, Phone__c, Age__c FROM ObjectC__c where ObjectB__r.objectA__c = :recordId ];
    }

}