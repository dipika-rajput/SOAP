public  class  childofabstractclassdemo extends Abstarctclassdemo
{
	public override void abstractMethod()
	{
		system.debug('this is abstract method which is defined in child class');
		childofabstractclassdemo cc = new childofabstractclassdemo();
		cc.firstMethod();
		cc.secondMethod();
		cc.abstractMethod();
	}
}