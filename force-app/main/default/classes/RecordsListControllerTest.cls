@isTest(SeeAllData = true)
public with sharing class RecordsListControllerTest {
    @isTest static void testObjectList() {
        
        //Create ojbectA
        ObjectA__c obja = new ObjectA__c(Name = 'Example');
        insert obja;

        //Save Id of objectA
        ID objaid = obja.id;
        system.debug('id'+objaid);
      

        //Create list of objectb
        List < ObjectB__c > objectsb = new List < ObjectB__c > ();
        for (Integer count = 0; count < 3; count++) {
            objectsb.add(new ObjectB__c(Name = 'Jack' + count, Phone__c = '910294830000', ObjectA__c =objaid) );
        }
        insert objectsb;
      
       ID objbid = objectsb[0].id;
  
        ////Create list of objectC
        List < ObjectC__c > objectsc = new List < ObjectC__c > ();
        for (Integer count = 0; count < 3; count++) {
            objectsc.add(new ObjectC__c(Name = 'Jack' + count, Phone__c = '910294830000', objectB__c = objbid));
        }
        insert objectsc;

        Test.startTest();
        List < ObjectB__c > recordsb = RecordsListController.getObjectsB(objaid);
        List < ObjectC__c > recordsc = RecordsListController.getObjectsC(objaid);
        system.debug(recordsb.size());

        Test.stopTest();
        
         System.assertEquals(recordsb.size(), 3);
         System.assertEquals(recordsc.size(), 3);
       

    }

}