public with sharing class Param_constructor_demo {
	
	Integer roll;
	String name;

	public  Param_constructor_demo(Integer roll_no,String stud_name)
	{
		roll = roll_no;
		system.debug(+roll_no);
		name = stud_name;
		system.debug(+stud_name);
	}

//Param_constructor_demo object1 = new Param_constructor_demo(10,'dipika');

//Param_constructor_demo object2 = new Param_constructor_demo(20,'abhi');
 	
 
}
//done