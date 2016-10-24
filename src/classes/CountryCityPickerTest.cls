@isTest
public class CountryCityPickerTest 
{
	Static testMethod void unitTesting()
    {
        test.startTest();
        CountryCityPicker c = new CountryCityPicker();
        c.country = 'India';
        c.getCountriesSelectList();
        System.assertEquals(c.country,'India');
        c.city = 'Mumbai';
        c.getCitiesSelectList();
        System.assertEquals(c.city,'Mumbai');
        test.stopTest();
        
    }
    
}