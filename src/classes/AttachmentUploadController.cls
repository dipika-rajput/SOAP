public with sharing class AttachmentUploadController {

    String AccountIDx {get; set;}
    public AttachmentUploadController(ApexPages.StandardController controller) {
    AccountIDx = ApexPages.currentPAge().getParameters().get('AccIDx');
      
    }


  public Attachment attachment {
  get {
      if (attachment == null)
        attachment = new Attachment();
      return attachment;
    }
  set;
  }

  public PageReference upload() {
        attachment.OwnerId = UserInfo.getUserId();
        
        attachment.ParentId = AccountIDx ; // the record the file is attached to
        attachment.IsPrivate = true;

    try {
      insert attachment;
    } catch (DMLException e) {
      ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading attachment'));
      return null;
    } finally {
      attachment = new Attachment(); 
    }

    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Attachment uploaded successfully'));
    PageReference pr = page.Account_Details;
     pr.getParameters().put('id',AccountIDx);
    pr.setRedirect(True);
    return pr;
    
    
  }

}