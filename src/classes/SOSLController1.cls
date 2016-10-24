Public class SOSLController1{
public List<Opportunity> myOpportunities { get;set; }
 public String searchStr1;
 Public List<Opportunity> optyList {get;set;}
 Public List<contact> conList{get;set;}
 Public List<account> accList{get;set;}
 Public List<lead> leadList{get;set;}
 Public String searchStr{get;set;}
 public Id getContacts{get;set;}
Public List<contact> conListNew{get;set;}
public List<List <sObject>> searchList1;
 public list<contact> contact1list{get;set;}
 public Account A{get;set;}
 /*
     public List<Contact> cont11() {
        String CurrentUserId = UserInfo.getUserId();
       
        List<Contact> mycon = [select id, name from contact where OwnerId =: CurrentUserId];
        
        return mycon;
    }
*/

/*
public list<contact> cont1(){
string currentUserId=userInfo.getUserId();

list<contact> mycon=[select firstname,phone from contact where OwnerID=:CurrentUserId];

return mycon;
}
*/
 
   Public void SOSLController1(){
 
   }
  
  Public void soslDemo_method(){
   optyList = New List<Opportunity>();
   conList = New List<contact>();
   accList = New List<account>();
   leadlist= New List<lead>();
   if(searchStr.length() > 1){
   searchStr1 = '*'+searchStr+'*';
   String searchQuery = 'FIND \'' + searchStr1 + '\' IN ALL FIELDS RETURNING  Account (Id,Name,type,phone),Contact(name,mailingAddress,phone),Opportunity(name,StageName),Lead(name,address,phone)';
   List<List <sObject>> searchList = search.query(searchQuery);
   accList = ((List<Account>)searchList[0]);
   conList  = ((List<contact>)searchList[1]);
   optyList = ((List<Opportunity>)searchList[2]);
   leadList = ((List<lead>)searchList[3]);
   }
   }
  
   public PageReference recGetter()
   {
   
   contact1list=[select firstName from contact where AccountId=:getContacts];
   System.debug('this is concatslist'+contact1list);
   pagereference ref =new pagereference('/apex/secondReference');
   ref.setredirect(true);
   return ref;
   
/*   contact1list=[select firstname,LastName, phone from contact where id=];

   if(searchStr.length() > 1)
   String searchStr1 = '*'+searchStr+'*';
   String searchQuery1 = 'FIND \'' + searchStr1 + '\' IN ALL FIELDS RETURNING  Contact(name,mailingAddress,phone)';
   searchList1 = search.query(searchQuery1);
   return Null;
   */
   } 
   }