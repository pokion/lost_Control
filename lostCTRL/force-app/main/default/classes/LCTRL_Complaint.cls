public with sharing class LCTRL_Complaint {
    
    @AuraEnabled
    public static string createComplaint(String status, String caseOrigin, String email, String name, String phone, String subject, String description){
        try {
            Case newCase = new Case();
            newCase.Status = status;
            newCase.Origin = caseOrigin;
            newCase.SuppliedEmail = email;
            newCase.SuppliedName = name;
            newCase.SuppliedPhone = phone;
            newCase.Subject = subject;
            newCase.Description = description;

            Database.SaveResult saveResult = Database.insert(newCase);

            return JSON.serialize(saveResult.getErrors());

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

}