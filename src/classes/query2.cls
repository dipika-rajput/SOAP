public with sharing class query2 {
	public void q2()
	{
		Map<ID,user> mapdemo = new Map<ID,user>([select name, email,title from user where isActive = TRUE]);
		//mapdemo = [select name, email,title from user where isActive = TRUE];
		//system.debug(+mapdemo);
		for (ID idKey : mapdemo.keyset()) {
			 user a = mapdemo.get(idKey);
			 System.debug(a);

			}
		
	}
    
}