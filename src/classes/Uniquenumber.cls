//class for displaying unique number 
public with sharing class Uniquenumber {
	public void uniqueArray()
	{
		Integer[] myList = new List<Integer>{10, 20,10,10};
		for(integer i=0;i<=3;i++)
		{
			system.debug(+mylist[i]);
		}
			Set<Integer> s1 = new Set<Integer>(myList);
			system.debug(+s1);
			
	}
    
}