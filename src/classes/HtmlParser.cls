public class HtmlParser {
    public void parsing()
    {
    	CalloutToGoogle c = new CalloutToGoogle();
    	String HtmlResponse = c.callingGoogle();
        String[] DivSeperate = HtmlResponse.split('\\<div class="g">');
        System.debug(' seperation of div:-'+DivSeperate[1]);
        String url1 = DivSeperate[1];
        String[]url2 = url1.split('\\</h3>');
         System.debug('url:-'+url2[0]);
       // String[] url3 = url2.split();
        
      	        
    }
    
    

}