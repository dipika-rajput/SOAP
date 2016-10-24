public with sharing class refreshdemoController {

    public Integer counter { get; set; }
    
    public refreshdemoController()
    {
    counter = 0;
    }

    public void increament() {
     counter = counter +1;
       
    }
    
}