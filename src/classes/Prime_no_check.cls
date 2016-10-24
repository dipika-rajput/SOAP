public with sharing class Prime_no_check {
    
    public void checkPrime()
    {
		integer num = 8;
    	integer count,flag = 0;
    	for(count = 2 ; count <= num / 2; count++)
    	{
    		if(math.mod(num , count) == 0)
    		{	
    			System.debug('Not a prime');
    			flag = 1;
    			break;
    		}
    	}
    	if(flag == 0)
    	{
    		System.debug('number is prime');
    	}
    	
    }
}
//done