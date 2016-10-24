public with sharing class StudentRegistrationformcontroller {
public String currentLanguage {get; set;}
public String language{get;set;}
List<Student_Details__c> result;
//public String LanguageSelected{get;set;}

public List<Student_Details__c> getresult() {
       return result;
}
public StudentRegistrationformcontroller(ApexPages.StandardController controller) {
    currentLanguage =  UserInfo.getLanguage();

}
/*public void changeLanguagetofrench() {
//get current user
    
    String currentuserId = UserInfo.getUserId();
    User currentUserInfo = [select LanguageLocaleKey from User where Id = :UserInfo.getUserId()];
    currentUserInfo.LanguageLocaleKey = 'fr';
    update currentUserInfo;
}*/
public PageReference search()
{
    System.debug('inside search');
    result=[select Language_Selection__c from Student_Details__c where 
    Name=: ApexPages.currentPage().getParameters().get('Language_Selection__c')];
    System.debug('options : '+result);
    return null;
}

List<selectOption>options = new List<selectOption>();
public List<selectOption>getLanguageSelected()
{
    options.add(new selectOption('','-None-'));
    options.add(new selectOption('English','English'));
    options.add(new selectOption('French','French'));
    options.add(new selectOption('Spanish','Spanish'));
    return options;
}
public void changeLanguagetofrench() {
System.debug(language + '-----');
//get current user
    for(selectOption lang : options)
    {
        if(language == 'French')
        {
            String currentuserId = UserInfo.getUserId();
            User currentUserInfo = [select LanguageLocaleKey from User where Id = :UserInfo.getUserId()];
            currentUserInfo.LanguageLocaleKey = 'fr';
            update currentUserInfo;
        }
        else if(language == 'Spanish')
        {
            String currentuserId = UserInfo.getUserId();
            User currentUserInfo = [select LanguageLocaleKey from User where Id = :UserInfo.getUserId()];
            currentUserInfo.LanguageLocaleKey = 'es';
            update currentUserInfo;
                
        }
       
       else if(language == 'English')
       {
           String currentuserId = UserInfo.getUserId();
           User currentUserInfo = [select LanguageLocaleKey from User where Id = :UserInfo.getUserId()];
           currentUserInfo.LanguageLocaleKey = 'en';
           update currentUserInfo;   
      }  
    }
 }

}