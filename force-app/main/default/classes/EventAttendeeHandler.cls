public class EventAttendeeHandler {
    public void sendConfirmationEmails(List<Event_Attendee__c> attendees) {
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        for (Event_Attendee__c attendee : attendees) {
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(new List<String>{attendee.Attendee__r.Email__c});
            email.setSubject('Pass for the "' + attendee.Event__r.Name + '"');
            String body = 'Dear ' + attendee.Attendee__r.Name + ',\n\n';
            body += 'Thank you for registering for "' + attendee.Event__r.Name + '" which will be organized on ' + attendee.Event__r.Start_Date_Time__c.format('MMMM d, yyyy') + ' at ' + attendee.Event__r.Location__c + '.\n\n';
            body += 'Find the Google Map location for the event here: ' + 'https://www.google.com/maps/place/' + attendee.Event__r.Location__r.Name + '\n\n';
            body += 'Thanks,\n' + attendee.Event__r.Event_Organizer__r.Name;
            email.setPlainTextBody(body);
            emails.add(email);
        }
        Messaging.sendEmail(emails);
    }
}