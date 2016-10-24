public with sharing class secondReferenceController {
//public list<String>listParam{get; set;}
public list<Contact>conlist{get; set;}
public String getContacts{get; set;}
public secondReferenceController()
{
   // List<Contact>conlistx = ApexPages.currentPage().getParameter().get('conlist'); 
   String accountIdx = ApexPages.currentPage().getParameters().get('getContacts'); 
   conlist=[select firstName , Last_Name__c,Phone,
            Email,Department,Technical_Skills__c from contact where AccountId=:AccountIdx];
   System.debug('this is concatslist'+conlist);
   
  // listParam = new list<String>();
  // listParam.add(conlist);
}
public pageReference goBack()
{
      pagereference ref = page.listviewdemo;
      ref.setRedirect(True);
      return ref;
}
}