/*  Write a SOQL query to retrieve/print the Contact records where Last Modified Date =
Today*/
public with sharing class soqlsosl6 {
 public void soql6()
 { 
 	List <Contact>lstcon = new List<Contact>();
 	lstcon = [Select  c.Id, c.FirstName From Contact c where c.LastModifiedDate = TODAY];
 	system.debug(lstcon);
 }   
}