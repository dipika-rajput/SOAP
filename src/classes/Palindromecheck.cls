public with sharing class Palindromecheck {
	 String str;
   public Palindromecheck(String string1)
   {
   		str = string1;
   }
   public void stringPalindromecheck( )
   {
   		integer len = str.length();
   		for(integer i = 0; i < len/2; i++ )
   		{
   			if(str.charAt(i) != str.charAt(len - i - 1))
   			{
   				System.debug('string is not palindrome');
   			}
   			else
   				System.debug('string is palindrome');
   		}
    }
}
//done