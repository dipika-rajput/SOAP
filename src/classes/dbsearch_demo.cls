public with sharing class dbsearch_demo {

	public void dbsearch()
	{
		String str2 = 'FIND\'Edge*\'IN ALL FIELDS RETURNING Account(id,name)';
       	List<List<SObject>>searchList = search.query(str2);
		System.debug(searchList);
	}    
}