public with sharing class Replaceocc {
    
    public  void stringReplace()
    {
    	String [] string_array = new List<String>();
    	string_array.add('dipa');
    	string_array.add('abhi');
		string_array.add('ajinkya');
		for(integer i = 0; i <= 2; i++)
		{
         	String[] strarr = new List<String>();
         	strarr[i] = string_array[i].replace('a', 'b');
			System.debug(+strarr);
        }
   }
}
    //done