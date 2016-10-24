public  class demo {

   public static void primenoCheck(integer num)
    {
    	num = 5;
    	integer count,flag=0;
    	for(count = 2;count <= num/2;count++)
    	{
    		if(math.mod(num , count) == 0)
    		{
    			flag=1;
    			break;
    		}
    	}
    	if(flag == 0)
    	{
    		System.debug('number is prime');
    	}
    	else
    	{
    		System.debug('number is not prime');
    	}
    }
}