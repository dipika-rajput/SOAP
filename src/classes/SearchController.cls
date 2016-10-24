public with sharing class SearchController {
   public list <account> acc {get;set;}
   public list<account> accalpha{get;set;}  
   public string searchstring {get;set;}  
   public List<string> alphabet{get;set;}
   Public List<contact> conlist{get;set;}
   //public Account accobj{get;set;}
   public String getContacts{get; set;}
   
   string searchquery;
    //private string accountListQuery;
    public SearchController(ApexPages.StandardSetController controller) 
    {
         //accobj = new Account(); 
         acc = new list<Account>();
         accalpha = new list<account>();
         alphabet = new string[]{'All','a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i',
          'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z' };  
    }
    
    
     
    public void search()
    { 
         System.debug('In search');
         searchquery = 'select name,id from account where name like \'%'+searchstring+'%\' Limit 20';
         acc = Database.query(searchquery);  
         System.debug('this is listview:-'+acc);
         Integer strlen = searchstring.length();
         if(searchstring == null ||searchstring == ''||strlen <= 3)
         { 
               ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,
               'Input String should be greater than 3 characters'));       
         }
         
   }  
          public void clear(){  
          acc.clear();  
   }  
   
   public PageReference refreshList2() {
     string s;
       if(apexpages.currentpage().getparameters().get('alpha') == 'All')
           s='%';
       else
           s= apexpages.currentpage().getparameters().get('alpha')+'%';
           searchquery = 'select id,name from account where name like' +'\''+s +'\''+ 'limit 5000';
           System.debug('this is search result'+searchquery);
           accalpha= Database.query(searchquery);  
           System.debug('this is search result:-'+accalpha);
           return null;
       }
       public pageReference getContactsRecords()
       {
       
           //conlist=[select firstName from contact where AccountId=:getContacts];
           //System.debug('this is concatslist'+conlist);
           pagereference ref =new pagereference('/apex/secondReference');
           //ref.getParameters().put('conlist',String.valueof(conlist));
           ref.getParameters().put('getContacts',getContacts);
           ref.setredirect(true);
           return ref;
       }
       
       @RemoteAction
       
       public static String DeleteAccount(String IdChoosen)
       {
           System.debug('this is id of account which needs to be deleted'+IdChoosen);
           Account accdel = new Account(id = IdChoosen);
           delete accdel;
           System.debug('this is account to be deleted'+accdel);
           return 'Account is deleted successfully!!!!!';  
       }
       

}