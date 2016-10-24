public class Multiple_Record_sales {
    public void creating()
    {
       List<Sales_stream_Points__c>listofsales = new List<Sales_stream_Points__c>();
       Sales_stream_Points__c sale;
        Opportunity o = new Opportunity();
        sale =  new Sales_stream_Points__c(Point_Type__c = 'Collaborate',Opportunity__c = o.Id);
        listofsales.add(sale);
        sale = new Sales_stream_Points__c(Point_Type__c = 'Connect1',Opportunity__c = o.Id);
         listofsales.add(sale);
         sale = new Sales_stream_Points__c(Point_Type__c = 'Connect2',Opportunity__c = o.Id);
         listofsales.add(sale);
         sale = new Sales_stream_Points__c(Point_Type__c = 'Connect3',Opportunity__c = o.Id);
         listofsales.add(sale);
         sale = new Sales_stream_Points__c(Point_Type__c = 'Connect4',Opportunity__c = o.Id);
         listofsales.add(sale);
         sale = new Sales_stream_Points__c(Point_Type__c = 'Connect5',Opportunity__c = o.Id);
         listofsales.add(sale);
         sale = new Sales_stream_Points__c(Point_Type__c = 'Closed Won',Opportunity__c = o.Id);
         listofsales.add(sale);
        insert listofsales;
        System.debug('list of sales:'+listofsales);
    }

}