public with sharing class LCTRL_Complaint {
    
    @AuraEnabled
    public static string createComplaint(String status, String caseOrigin, String email, String name, String phone, String subject, String description){
        try {

            if(String.isNotBlank(status) && String.isNotBlank(caseOrigin) && String.isNotBlank(email) && String.isNotBlank(name) && String.isNotBlank(phone) && String.isNotBlank(subject) && String.isNotBlank(description)){
                Case newCase = new Case();
                newCase.Status = status;
                newCase.Origin = caseOrigin;
                newCase.SuppliedEmail = email;
                newCase.SuppliedName = name;
                newCase.SuppliedPhone = phone;
                newCase.Subject = subject;
                newCase.Description = description;
                //test
                Database.SaveResult saveResult = Database.insert(newCase);
                return JSON.serialize(saveResult.getErrors());
            }else{
                return 'error';
            }
                 

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

}