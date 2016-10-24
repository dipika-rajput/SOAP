public with sharing class CountryCityPicker {
    //created two variables to use them on vf
    public String city{ get; set; }
    public String country {get; set;}   
   //public String CountriesSelectList{get;set;}
   // public String CitiesSelectList{get;set;}
    
    //created a function having return value as list<selectOption> to get all countries list
    public List<SelectOption> getCountriesSelectList() {
        //creating a list of selectoptions
        List<SelectOption> options = new List<SelectOption>();
        //at the fisrt location of select option storing nothing with label select one.
        options.add(new SelectOption('', '-- Select One --'));        

      //creating a map to store all values of custom setting country__c 
      //By using getAll i ll get all values of that object and in string ill get all names of those values  
        Map<String, Country__c> countries = Country__c.getAll();
        
      //creating a list store names of countries 
        List<String> countryNames = new List<String>();
        //adding all keyset of countries which having names of countries in thr countrynames list
        //now i got all names in countrynames list
        countryNames.addAll(countries.keySet());
        //Now, i am sorting that list of countrynames alphabetically
        countryNames.sort();
        
       //now creating a string variable to store a name at a time from countryNames list
        for (String countryName : countryNames) {
        //Now,creating a object of country__C which will store a value of countryName by using get method
        //for ex initially get will return France which will be stored in country
            Country__c country = countries.get(countryName);
            //Now i have list of selectOption as a options so now add that countryName value to that list
            //So, at first time France will be stored in options list. 
            options.add(new SelectOption(countryName,country.Name));
            //this loop will iterate for all country names
            
        }
        //return that list of options to the funtions
        return options;
        
    }
    
    public list<Selectoption>getCitiesSelectList() {
        List<SelectOption> options = new List<SelectOption>();
        
        Map<String, City__c> allcities = City__c.getAll();

        Map<String, City__c> cities = new Map<String, City__c>();
        for(City__c city : allcities .values()) {
            if (city.country__c == this.country) {
                cities.put(city.name, city);
            }
        }
        
        List<String> cityNames = new List<String>();
        cityNames.addAll(cities .keySet());
        cityNames.sort();
        for (String cityName : cityNames) {

            City__c state = cities.get(cityName);

            options.add(new SelectOption(cityName , cityName));
        }

        
        return options;
    }
}