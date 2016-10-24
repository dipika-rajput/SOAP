@isTest
public class AssociationContactTriTestClass {
     static testMethod void contactTriTesting()
     {
         
        	 //will first create contact
        	list<contact>conlist = new list<contact>();

         	Contact newcon = new Contact(Email_Domain__c = 'etrenus.com',LastName = 'rajput' ,College_Name__c = 'SMV' ,
                                      First_Name__c = 'harsh',	Last_Name__c = 'rajput');
         	conlist.add(newcon);
         	Test.startTest();
         	insert conlist;
         	Test.stopTest();
         
         	//list<Account>accAlreadyPresent = new list<Account>();
         	list<account>newAccList = new list<account>();
         //try{
         	if((newcon.Email_Domain__c) != Null )
        	 {
                 Account acc= new Account(Name = 'harsh rajput',Website_Domain__c = 'eternus.com');
                // accAlreadyPresent = [select id,Website_Domain__c from Account where Website_Domain__c 
                      //               = 'eternus.com' ];
                 	newAccList.add(acc);
                 	insert newAccList;
                    newcon.AccountId =acc.id;
                 	System.assertEquals(acc.Website_Domain__c,'eternus.com');
                 	System.assertEquals(acc.Name,'harsh rajput');
                   	
            // }
            // catch(Exception e)
             //{
             
             	if(acc.id == null)
             	{
                	 Account newAcc = new Account(name = 'newAccountdemo',Website_Domain__c = 'eternus.com');
                	 newAccList.add(newAcc);
          	     	 insert newAccList;
                    
                 	 for(Account a : newAccList )
                     {
                    	 newcon.AccountId = a.id;
                     }
                    
                	 	System.assertEquals(newAcc.Website_Domain__c,'eternus.com');
                    	System.assertEquals(newAcc.name,'newAccountdemo');
             	}
             }
         }
      }