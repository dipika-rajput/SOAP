/*Write a SOQL query to find total number of Lead records by status by Lead Source. Store this
information in map and display the same.
(Hint: map<string,map<string,integer>>)*/
    
public with sharing class aggregatefunction3 
{
 	public void aggregateOperation()
 	{
     	List<AggregateResult> ls = new List<AggregateResult>();
     	ls = [select count(id)id1,leadsource,status from Lead group by leadsource,status];
	 	Map <String,Map<string,Integer>> mapofstatus_map = new  Map <String,Map<String,Integer>>();
	 	//this is inner map
	 	Map<String,Integer> mapofleadsource_totalleads = new Map <string,Integer>();
		for( AggregateResult ar:ls)
    	{
	 		Integer ids= (Integer)ar.get('id1');
	 		String leadsrc =(String) ar.get('leadsource');
	 		String stats  =(String) ar.get('status');
	 		//System.debug(ar.get('id1')+'-'+ar.get('leadsource')+'-'+ar.get('status'));
  			//here in inner map i am specifying key value to it.
  	 		mapofleadsource_totalleads.put(leadsrc,ids);
 			mapofstatus_map.put(stats,mapofleadsource_totalleads);
  	 		//now i am here accessing fileds of leads in aggregateresult.
  	 		System.debug('id:-' +ids+ 'leadsource:-' +leadsrc+'status:-'+stats);
		}
	}
}


//done