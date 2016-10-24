public with sharing class custom_label_translation_Controller {

public String language{get;set;}
public String currentLanguage{get;set;}
public custom_label_translation_Controller()
{
   currentLanguage = UserInfo.getLanguage(); 
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

public void changeLanguage() {
System.debug(language + '-----');
//get current user
    for(selectOption lang : options)
    {
        if(language == 'French')
        {
            String currentuserId = UserInfo.getUserId();
            User currentUserInfo = [select LanguageLocaleKey from User where Id = :UserInfo.getUserId()];
            currentUserInfo.LanguageLocaleKey = 'fr';
             System.debug('english'+currentUserInfo);
            update currentUserInfo;
              
        }
        else if(language == 'Spanish')
        {
            String currentuserId = UserInfo.getUserId();
            User currentUserInfo = [select LanguageLocaleKey from User where Id = :UserInfo.getUserId()];
            currentUserInfo.LanguageLocaleKey = 'es';
            update currentUserInfo;
             System.debug('spanish:-'+currentUserInfo);
        }
        else 
        {
            String currentuserId = UserInfo.getUserId();
            User currentUserInfo = [select LanguageLocaleKey from User where Id = :UserInfo.getUserId()];
            currentUserInfo.LanguageLocaleKey = 'en_US';
            update currentUserInfo; 
             System.debug('english'+currentUserInfo);  
        }  
    }
 }

}