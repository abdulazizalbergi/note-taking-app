public without sharing class NoteTakingController {
    @AuraEnabled
    public static boolean createNoteRecord(String title, String description){
        try{
            if(!String.isBlank(title)){
                My_Note__c noteRec = new My_Note__c(Name = title, Note_Description__c = description);
                insert noteRec;
                return true;
            }
            return false;
        }catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }

    }
    @AuraEnabled(cacheable=true)
    public static List<My_Note__c> getNotes(){
        return [SELECT id,Name , Note_Description__c, LastModifiedDate FROM My_Note__c ORDER BY LastModifiedDate];

    }
    @AuraEnabled
    public static Boolean updateNoteRecord(String noteId, String title , String description){
        try {
            if (!String.isBlank(noteId)) {
                My_Note__c note = [SELECT id, Name, Note_Description__c, LastModifiedById FROM My_Note__c WHERE id =:noteId];
                note.Name = title;
                note.Note_Description__c = description;
                update note;
                return true;
            }else {
                return false;
            }
        } catch (Exception e) {
           throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static Boolean deleteNoteRecord(String noteId){
        try {
            if(!String.isBlank(noteId)){
                My_Note__c noteRec = new My_Note__c(Id=noteId);
                delete noteRec;
                return true;
            }else return false;

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}