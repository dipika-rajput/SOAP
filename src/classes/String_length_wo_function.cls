public with sharing class String_length_wo_function
{
	 String myString ;
	 public String_length_wo_function(String str1)
	 {
		myString = str1;
	 }
     public void lengthCount()
     {
 		integer i = 0;
   		 try
         {
     	  	while (true)
            {
           	 	myString.charAt(i);
           	 	i++;
        	}
    	}
        	
    	catch (Exception e) 
   		{
    		System.debug('length of string is:-'+i);
    	}
	}
    
}
//done