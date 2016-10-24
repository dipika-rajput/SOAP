public  class EventManagementController {
public PageReference eventLst() {
        return null;
    }


    public PageReference EventObj() {
        return null;
    }
     String SelectedGCId;
public List<Package__c>groupLst{get;set;}  
 //String SelectedGCId;
 public String eventDateList { get; set; }
 public String eventLst { get; set; }
 public String GroupCode { get; set; }
 public String selectedEvent  {get;set;}
 public List<SelectOption> Events {get;set;}
 //public String startDate{get;set;}
 private Final Event_Management__c e; 
 //public Date givenStartDate{get;set;}
 //public String dateStr{get;set;}
 public EventManagementController(ApexPages.StandardController stdController)
 {
     this.e = (Event_Management__c)stdController.getRecord();
     System.debug('current record inside cons:-'+e);
     // EventDate(); 
 }
  //use getter setter like this to get the parameter assignTo value

 public List<SelectOption>getEventObj()
 {
    //dateStr = ApexPages.currentPage().getParameters().get('StartDate');
    //System.debug('string date format::::'+dateStr );
   // System.debug('givenStartDate###'+givenStartDate);
    List<SelectOption>options = new List<SelectOption>();
    List<Event_Management__c> eventLst =[SELECT Id, Name,Start_Date__c,End_Date__c FROM Event_Management__c where Start_Date__c = :e.Start_Date__c];
    System.debug('****eventLst for getting date and related records******'+eventLst);
    System.debug('ApexPages.CurrentPage().getParameters().get(StartDate)'+ApexPages.CurrentPage().getParameters().get('StartDate'));
    options.add(new SelectOption('None','--None--'));
    for(Event_Management__c e : eventLst)
    {
        options.add(new SelectOption(e.Name,e.Name));
    }
    return options;
 }
 public List<SelectOption>getGroupCodeObj()
 {
     System.debug('eventLst^^^^^^^^^^^^^^^@@@@@@@@@@@@@'+eventLst);
     System.debug('selectedEvent---'+selectedEvent);
    
     List<SelectOption>options = new List<SelectOption>();
     List<Package__c>groupLst = [Select Group_Connector__r.Name,Group_Connector__r.id,
     Group_Connector__r.Count_of_Guest_Registration__c,Name from Package__c where Event_connector__r.Name= :selectedEvent];
     //System.debug('Updated query%%%%%'+groupLst1);
    // List<Group_Code__c>groupLst = [Select Id,Name,Count_of_Guest_Registration__c from Group_Code__c where Package__r.Name= :selectedEvent];
     System.debug('***grouplist:--'+groupLst);
     options.add(new SelectOption('None','--None--'));
     for(Package__c p : groupLst)
     {
         String pcode = p.name+'-'+p.Group_Connector__r.Name+'('+p.Group_Connector__r.Count_of_Guest_Registration__c+')' ;
         System.debug('gcode****'+pcode);
         options.add(new SelectOption(p.Group_Connector__r.id,pcode));
         SelectedGCId = p.Group_Connector__r.id;
         system.debug('p.Group_Connector__r.id'+p.Group_Connector__r.id);
     }
     return options;
 }
 public pagereference redirect()
{
   
    PageReference pageRef= new PageReference('/apex/Basic_Information_of_guest');
    pageRef.getParameters().put('SelectedGCId',SelectedGCId);
    pageRef.setredirect(true);
    return pageRef;
}
 
 
}