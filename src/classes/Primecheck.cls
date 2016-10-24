public  class Primecheck {

   public void primenoCheck(integer num1)
    {
    	integer num;
    	integer count,flag = 0;
    	for(count = 2;count <= num / 2;count++)
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