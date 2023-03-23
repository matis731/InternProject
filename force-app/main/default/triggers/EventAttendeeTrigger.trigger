trigger EventAttendeeTrigger on Event_Attendee__c (after insert) {
    List<Event_Attendee__c> attendees = Trigger.new;
   
    EventAttendeeHandler handler = new EventAttendeeHandler();
    try {
        handler.sendConfirmationEmails(attendees);
    } catch (Exception e) {
        System.debug('An error occurred while sending confirmation emails: ' + e.getMessage());
    }
}