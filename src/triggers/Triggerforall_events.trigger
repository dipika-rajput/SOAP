trigger Triggerforall_events on Contact (after update) {
    //system.debug('this is before insert using new '+Trigger.new);
     system.debug('this is before update using new'+Trigger.new);
   system.debug('this trigger is for before update using newMap'+Trigger.newMap);
   // system.debug('this trigger is for after insert using newMap'+Trigger.newMap);
    //system.debug('this trigger is for after update using newMap'+Trigger.newMap);
    system.debug('this trigger is for before update using old'+Trigger.old);
    // system.debug('this trigger is for after update using old'+Trigger.old);
     //system.debug('this trigger is for before delete using old'+Trigger.old);
     //system.debug('this trigger is for after delete using old'+Trigger.old);
     system.debug('this trigger is for before update using old'+Trigger.oldMap);
      // system.debug('this trigger is for after update using old'+Trigger.oldMap);
     // system.debug('this trigger is for before delete using old'+Trigger.oldMap);
      //system.debug('this trigger is for after delete using old'+Trigger.oldMap);
    





}