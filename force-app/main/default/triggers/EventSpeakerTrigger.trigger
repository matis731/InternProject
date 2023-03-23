trigger EventSpeakerTrigger on EventSpeakers__c (before insert, before update) {
    Set<Id> speakerIds = new Set<Id>();
    for (EventSpeakers__c es : Trigger.new) {
        speakerIds.add(es.Speaker__c);
    }
   
    List<EventSpeakers__c> existingBookings = [SELECT Id, Speaker__c FROM EventSpeakers__c WHERE Speaker__c IN :speakerIds AND Event__r.End_Date_Time__c = :System.now() AND Id NOT IN :Trigger.new];
   
    Map<Id, EventSpeakers__c> speakerToBooking = new Map<Id, EventSpeakers__c>();
    for (EventSpeakers__c es : existingBookings) {
        speakerToBooking.put(es.Speaker__c, es);
    }
   
    for (EventSpeakers__c es : Trigger.new) {
        if (speakerToBooking.containsKey(es.Speaker__c)) {
            es.addError('Speaker already has an event booked.');
        }
    }
}