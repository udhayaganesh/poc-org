public class JobPortalController {
    @AuraEnabled 
    public static List<jobportal__c> getJP(String str){
        String strKey = '%'+str+'%';
        system.System.debug('#######'+strKey);
        List<jobportal__c> jp=[SELECT Id, jobtitle__c, jobdesc__c, expr__c, location__c, 
        Name, CreatedDate FROM jobportal__c WHERE name like :strKey ] ;
        return jp;
    }
    
     @AuraEnabled
    public static List<jobportal__c> getJPRec(Id recid){
        List<jobportal__c> jp=[SELECT Id, jobtitle__c, jobdesc__c, expr__c, location__c, Name, CreatedDate FROM jobportal__c where id= :recid];
        return jp;
    }
}