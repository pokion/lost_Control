public virtual class ObjectTest {

    private static fflib_SObjectUnitOfWork uow = initUnitOfWork();
    public SObject record;
    
    public ObjectTest(SObject standalone) {
        register(standalone);
    }
    
    
    public ObjectTest(SObject child, Schema.SObjectField parentRelationship, ObjectTest parent) {
        this(child);
        register(parentRelationship, parent.record);
    }
    
    
    public ObjectTest(SObject linker, 
                        Schema.SObjectField leftRelationship, ObjectTest left, 
                        Schema.SObjectField rightRelationship, ObjectTest right) {
                            this(linker, leftRelationship, left);
                            register(rightRelationship, right.record);
                        }
    
    public ObjectTest persist() {
        uow.commitWork();
        
        uow = initUnitOfWork();
        
        return this;
    }
    
    protected ObjectTest addChild(ObjectTest child, Schema.SObjectField parentRelationship){
        uow.registerRelationship(child.record, parentRelationship, record);
        return this;
    }
    
    private void register(SObject record) {
        this.record = record;
        
        if(record.Id == null) {
            uow.registerNew(record);
        }
    }
    
    private void register(Schema.SObjectField relationship, SObject relatedRecord) {
        if(relatedRecord.Id == null) {
            uow.registerRelationship(record, relationship, relatedRecord);
        }
        else {
            record.put(relationship, relatedRecord.Id);
        }
    }
    
    private static fflib_SObjectUnitOfWork initUnitOfWork() {
        return new fflib_SObjectUnitOfWork(new List<Schema.SObjectType>{ 
            Grandfather__c.SObjectType,
                Father__c.SObjectType,
                Child__c.SObjectType
                });
    }
}
