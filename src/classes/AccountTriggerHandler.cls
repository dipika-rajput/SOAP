public with sharing class AccountTriggerHandler {
    private boolean m_isExecuting = false;
    private integer BatchSize = 0;
    public AccountTriggerHandler(boolean isExecuting, integer size){
        m_isExecuting = isExecuting;
        BatchSize = size;
    }
    public void OnBeforeInsert(Account[] newAccounts)
    {
         List<Account> newAccount = [select Id, Name from Account where Name = 'dipika'];

    }
    public void OnAfterInsert(Account[] newAccounts)
    {
         List<Account> newAccount = [select Id, Name from Account where Name = 'dipika'];
    }

    public void OnBeforeUpdate(Account[] oldAccounts, Account[] updatedAccounts)
    {
      list<Account>newAccount = [select id ,name from Account where Name = 'dipika'];
      List<Account>updatedAccount = [select id ,name from Account where Name = 'divya'];
    }

    public void OnAfterUpdate(Account[] oldAccounts, Account[] updatedAccounts, Map<ID, Account> accountMap)
    {
         List<Account> updatedAccount = [select Id, Name from Account where Name = 'divya'];
        
    }
    public void OnBeforeDelete(Account[] accountsToDelete, Map<ID, Account> accountMap)
    {
    }
     public void OnAfterDelete(Account[] deletedAccounts, Map<ID, Account> accountMap)
    { 
    }
    public void OnUndelete(Account[] restoredAccounts)
    { 
    }
    public boolean IsTriggerContext{
        get{ 
                return m_isExecuting;
            }

        }

    
}