public class QueryBuilderusingDynamicApex
{
    public List<SelectOption>fsOptions{set;get;}
    public List<SelectOption>fnsOptions{set;get;}
    public List<SelectOption> objects {set;get;}
    public List<String> objList {set;get;}
    public List<String>fields{set;get;}
    public Set<String>fSelected{set;get;}
    public Set<String>fnotSelected{set;get;}
    public Map<String, Schema.SObjectType> objmap {set;get;}
    public Map<String,Schema.SObjectField>mfields;
    public String selectedObj{set;get;}
   	public String objdescription{set;get;}
    public List<String> sfields {set;get;}
    public List<String> rfields {set;get;}
    public List<Sobject>myData{set;get;}
    public List<String>myFields{set;get;}
    public String query{set;get;}
    public String sequence{set;get;}
    public String oSelected {set;get;}
    list<SelectOption> optionsSorting{get;set;}
    public List<SelectOption> onotSelected{set;get;}
    public String str {set;get;}
    public String SortingOrder{set;get;}
    public String limitSize {get;set;}
    public String limitStr;
    List<String> lst;
    
    public QueryBuilderusingDynamicApex()
    {
        myFields = new List<String>();
        myData = new List<SObject>();
        objects = new List<SelectOption>();
        objList = new List<String>();
        objmap = Schema.getGlobalDescribe();
        //mfields = 
        fsOptions = new List<SelectOption>();
        fnsOptions = new List<SelectOption>();
        fields = new List<String>();
        fSelected = new Set<String>();
        fnotSelected = new Set<String>();
    	onotSelected = new List<SelectOption>();
        objList.addAll(objmap.keyset());
        objList.sort();
        SelectOption n = new SelectOption('None','--None--');
        objects.add(n);
        for(String s : objList)
        {
            
            SelectOption op = new SelectOption(s,s);
            objects.add(op);
            //stem.debug('objects:--'+objects);
        }
    }
    public void Details()
    {
        
        Schema.DescribeSObjectResult myobj = objmap.get(selectedObj).getDescribe();
        //stem.debug('this is describeobjectResult:--'+myobj);
        objDescription = ''+myobj;
        
        mfields = objmap.get(selectedObj).getDescribe().fields.getMap();
        //stem.debug('this are mfields:-'+mfields);
        fields.addAll(mfields.keySet());
        //stem.debug('fields--------'+fields);
        fields.sort();
        fnotSelected.addAll(fields);
        show();
    }
  public void show()
  {
      fnsOptions.clear();
      fsOptions.clear();
      for(String s : fnotSelected)
      {
          //stem.debug('this is s fnotselected:---'+s);
          selectOption op = new selectOption(s,s);
          fnsOptions.add(op);
      }
      for(String s1 : fSelected)
      {
          selectOption op1 = new SelectOption(s1,s1);
          fsOptions.add(op1);
      }
  }
    public void addFields()
    {
        fnotSelected.removeAll(sfields);
        System.debug('this is 1');
        fSelected.addAll(sfields);
        System.debug('this is 2');
        show();
    }
    public void removeFields()
    {
        fnotSelected.addAll(rfields);
        fSelected.removeAll(rfields);
        show();
    }
    //for ascending and Descending order
   public list<SelectOption> getOptionsSorting() 
     {
        list<SelectOption> optionsSorting = new list<SelectOption>();
        optionsSorting.add(new SelectOption('1', 'Ascending'));
        optionsSorting.add(new SelectOption('2', 'Descending'));
        return optionsSorting;
     }
	public PageReference actionSave()
    {
           If(SortingOrder == '1')
               Str = 'ASC';
           else
               str = 'DESC';
           return null;
    }
    //for limit selecting 
    public list<SelectOption> getLimitValue() 
    {
        list<SelectOption> limit1 = new list<SelectOption>();
        limit1.add(new SelectOption('None','--None--'));
        limit1.add(new SelectOption('500', '500'));
        limit1.add(new SelectOption('1000', '1000'));
        limit1.add(new SelectOption('5000', '5000'));
        limit1.add(new SelectOption('50000', '50000'));
        return limit1;
    }
    
    public PageReference actionlimit()
    {
           If(limitSize == '500')
               limitStr = '500';
           else If(limitSize == '1000')
               limitStr = '1000';
           else If(limitSize == '5000')
               limitStr = '5000';
           else If(limitSize == '50000')
               limitStr = '50000';
           return null;
    }
        
    

    public void querymyData()
    {
       query = 'SELECT Id';
        System.debug('this is query '+query);
        //lst = new List<String>();
       myFields.addAll(fSelected);
        for(String s : fSelected)
        {
            //System.debug('this is s'+s);
            query = query+ ','+s;
            //System.debug('this is query part 2'+query);
            
        }
        //query = query + ' FROM '+selectedObj ;
        query = query + ' FROM '+selectedObj +' Order By '+myfields[0]+ ' ' +str+' LIMIT '+limitStr;
        
        System.debug('this is query part 3*************'+query);
       
        myData = Database.query(query);
        System.debug('this is my data>>>>>>>>>>>>'+myData);
    }
    //for selecting fields for order by clause
    

                          
}