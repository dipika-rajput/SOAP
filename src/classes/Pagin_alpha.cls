public with sharing class Pagin_alpha {

     
    private List<contactSet> contactSetList{get;set;}
    private string contactListQuery;
    private set<contact> selectedContact;
    
    public List<string> alphabet{get;set;}
    public boolean fals{get;set;}   
    
    public Pagin_alpha(){
      fals=false;
      alphabet=new string[]{'All','a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z' };  
      contactSetList = new List<contactSet>();
      selectedContact = new set<contact>();
      contactListQuery= 'select id,name,phone from contact limit 1000';    
    }
    
     Private void updateSelectedContact(){
        for(contactSet cs:contactSetList ){
           if(cs.checked)
               selectedcontact.add(cs.ocontact);
           else{
               if(selectedcontact.contains(cs.ocontact))
                   selectedcontact.remove(cs.ocontact);
               }
       }   
    } 
    
      public ApexPages.StandardSetController standardSetCon {
        get {
            if(standardSetCon == null) {
                standardSetCon = new ApexPages.StandardSetController(Database.getQueryLocator(contactListQuery));
                // sets the number of records in each page set
                standardSetCon .setPageSize(20);
            }
            return standardSetCon ;
        }
        set;
    }
 
    public List<contactSet> getCurrentList() {
       updateSelectedContact(); 
       contactSetList = new List<contactSet>();       
        for (contact category : (List<contact>)standardSetCon.getRecords()){        
            if(selectedContact.contains(category))          
            contactSetList.add(new contactSet(category,'true'));
            else
            contactSetList.add(new contactSet(category));
        }
        fals=false;
        return contactSetList;
    } 
    
    public PageReference refreshList2() {       
       standardSetCon = null;     
       string s;
       if(apexpages.currentpage().getparameters().get('alpha') == 'All')
           s='%';
       else
           s= apexpages.currentpage().getparameters().get('alpha')+'%';
       
       contactListQuery= 'select id,name,phone from contact where name like' +'\''+s +'\''+ 'limit 5000';           
        return null;
    }
    
   
    
    public List<contact> getDisplaySelectedList(){
        updateSelectedContact();
        List<contact> displaycon = new list<contact>();
        displaycon.addall(selectedcontact);
        return displaycon;
    }
       
    public class contactSet { 
        public Boolean checked{ get; set; }
        public contact ocontact { get; set;} 

        public contactSet(){
            ocontact = new contact();
            checked = false;
        } 
        public contactSet(contact c){
            ocontact = c;
            checked = false;

        } 
        public contactSet(contact c,string s){
            ocontact = c;
            checked = true;

        } 
    }
    
  
}