@isTest
public class AttachmentUploadControllerTest {
     public static testMethod void attachmenthandling()
     {
         Account acc = new Account(Name='abc1',Website_Domain__c='abc.com',rating='Hot',Ownership='Private');
         insert acc;
         Test.startTest();
         Test.setCurrentPage(Page.Account_Attachment);
         ApexPages.StandardController stdController = new ApexPages.StandardController(acc);
         AttachmentUploadController att = new AttachmentUploadController(stdController);
         //for upload method
         att.upload();
         Attachment newAtt = new Attachment(name = 'newAttchment',ParentId = acc.id,Body=Blob.valueOf(''));
         //System.assertEquals(newatt,'newAttchment');
         insert newatt;
         
         	List<Apexpages.Message> msgs = ApexPages.getMessages();
         	boolean isMessage = false;
          	for(Apexpages.Message msg : msgs){
            	if (msg.getDetail().contains('Attachment uploaded successfully') )
                	isMessage  = true;
              //System.assert(isMessage);
               else if(msg.getDetail().contains('Error uploading attachment'))
              	isMessage = false;
            }
           //   
        }
       // system.assert(isMessage );
     }