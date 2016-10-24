@isTest
public class ContactDuplicateAvoiderTest{
    public static testMethod void testcontactDupPreventer() 
    {
    	Contact contact1 = new Contact(Title='Test1',LastName='test1l', 
                                   Department='Test1 dept',Email='test1@duptest.com');
    	Contact contact2 = new Contact(Title='test2',LastName='test2l',
                                   Department='Test2 dept',Email='test4@duptest.com');
    	Contact contact3 = new Contact(Title='test3',LastName='test3l',
                                   Department='test3 dept',Email='test5@duptest.com');
        Test.startTest();
        Contact[] contactArray = new Contact[] {contact1, contact2,contact3};   
        insert contactArray;
        contact2.Email = 'test2@duptest.com';
        contact3.Email = 'test3@duptest.com';
        update contactArray;
        Contact dup1 = new Contact(Title = 'Test1Dup',LastName = 'test1dupl',
                                   Department = 'Test1Dup Inc.',Email = 'test1@duptest.com');
        insert dup1;
        System.assertEquals(contact1.Email,dup1.Email);
        Test.stopTest();
        
        
    }  
}//this is done