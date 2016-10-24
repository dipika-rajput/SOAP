public with sharing class customlistController {

    public String city{ get; set; }
    public String country {get; set;}   
    //public String citiesSelectList {get;set;}
   // public String countriesSelectList{get;set;}
    
    public List<SelectOption> getCountriesSelectList() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('', '-- Select One --'));        

        
        Map<String, Country__c> countries = Country__c.getAll();
        
      
        List<String> countryNames = new List<String>();
        countryNames.addAll(countries.keySet());
        countryNames.sort();
        
       
        for (String countryName : countryNames) {
            Country__c country = countries.get(countryName);
            options.add(new SelectOption(countryName,country.Name));
        }
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