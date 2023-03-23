trigger ErrorLogTrigger on Error_Log__c (before insert) {
    Integer todayErrorCount = [SELECT COUNT() FROM Error_Log__c WHERE CreatedDate = TODAY];
    String todayDateString = Date.today().format();
    String logNumber = 'Log - ' + String.valueOf(todayErrorCount + 1).leftPad(4, '0') + '/' + todayDateString + ' - Log - ' + String.valueOf(todayErrorCount + 1);
    for (Error_Log__c errorLog : Trigger.new) {
        errorLog.Log_Number__c = logNumber;
    }
}