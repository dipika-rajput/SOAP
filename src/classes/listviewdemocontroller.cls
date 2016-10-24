public with sharing class listviewdemocontroller {
    String searchText;
    List<Account> results;
    
    public String getSearchText() {
        return searchText;
    }
    
    public void setSearchText(String s) {
        searchText = s;
    }
    
    public List<Account> getResults() {
        return results;
    }
    
    public listviewdemocontroller(ApexPages.StandardSetController controller) {
        
    }
    public PageReference search() {
        results = (List<Account>)[FIND :searchText RETURNING Account(Name,Email_ID__c,Phone,Website)][0];  
        return null ;
    }
    
    
    
}