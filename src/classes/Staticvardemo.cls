public with sharing class Staticvardemo {
    public static integer VAR = 5;
   public static void staticvarfunction()
   {
	 
  	 System.debug(+VAR);
	 VAR = 3; 
 	 System.debug(+VAR);
   }
}
//this is working in developer console
//done