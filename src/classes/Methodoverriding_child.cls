public with sharing class Methodoverriding_child extends Methodoveriding
 {
	 public virtual override void dosomething(){
 	 super.dosomething();
	 System.debug('something else of my class');
	}

		
}
    
//done