@istest
public with sharing class MaintenanceRequestHelperTest {
    
    private static final string STATUS_NEW = 'New';
    private static final string WORKING = 'Working';
    private static final string CLOSED = 'Closed';
    private static final string REPAIR = 'Repair';
    private static final string REQUEST_ORIGIN = 'Web';
    private static final string REQUEST_TYPE = 'Routine Maintenance';
    private static final string REQUEST_SUBJECT = 'Testing subject';
    
    
    
    PRIVATE STATIC Product2 createEq(){
        product2 equipment = new product2(name = 'SuperEquipment'
                                         );
        return equipment;
    }
    
    PRIVATE STATIC Case createMaintenanceRequest(id vehicleId, id equipmentId){
        case cs = new case(Type=REPAIR,
                          Status=STATUS_NEW,
                          Origin=REQUEST_ORIGIN,
                          Subject=REQUEST_SUBJECT);
        return cs;
    }
    
    PRIVATE STATIC Equipment_Maintenance_Item__c createWorkPart(id equipmentId,id requestId){
        Equipment_Maintenance_Item__c wp = new Equipment_Maintenance_Item__c( );
        return wp;
    }
    
    
    @istest
    private static void testMaintenanceRequestPositive(){ 
        id vehicleId =null;
        
        Product2 equipment = createEq();
        insert equipment;
        id equipmentId = null;
        
        case somethingToUpdate = createMaintenanceRequest(vehicleId,equipmentId);
        insert somethingToUpdate;
        
        Equipment_Maintenance_Item__c workP = createWorkPart(equipmentId,somethingToUpdate.id);
        insert workP;
        
        test.startTest();
        somethingToUpdate.status = CLOSED;
        update somethingToUpdate;
        test.stopTest();
        
        Case newReq = [Select id, subject, type
                      from case
                      where status =:STATUS_NEW];
        
        Equipment_Maintenance_Item__c workPart = [select id
                                                 from Equipment_Maintenance_Item__c
                                                 where Maintenance_Request__c =:newReq.Id];
        
        system.assert(workPart != null);
        system.assert(newReq.Subject != null);
        system.assertEquals(newReq.Type, REQUEST_TYPE);
        
    }
    
    @istest
    private static void testMaintenanceRequestNegative(){
         
        id vehicleId = null;
        
        product2 equipment = createEq();
        insert equipment;
        id equipmentId = equipment.Id;
        
        case emptyReq = createMaintenanceRequest(vehicleId,equipmentId);
        insert emptyReq;
        
        Equipment_Maintenance_Item__c workP = createWorkPart(equipmentId, emptyReq.Id);
        insert workP;
        
        test.startTest();
        emptyReq.Status = WORKING;
        update emptyReq;
        test.stopTest();
        
        list<case> allRequest = [select id 
                                 from case];
        
        Equipment_Maintenance_Item__c workPart = [select id 
                                                  from Equipment_Maintenance_Item__c 
                                                  where Maintenance_Request__c = :emptyReq.Id];
        
        system.assert(workPart != null);
        system.assert(allRequest.size() == 1);
    }
    
    @istest
    private static void testMaintenanceRequestBulk(){
        //list<Vehicle__C> vehicleList = new list<Vehicle__C>();
        list<Product2> equipmentList = new list<Product2>();
        list<Equipment_Maintenance_Item__c> workPartList = new list<Equipment_Maintenance_Item__c>();
        list<case> requestList = new list<case>();
        list<id> oldRequestIds = new list<id>();
        
        for(integer i = 0; i < 300; i++){
        //   vehicleList.add(createVehicle());
            equipmentList.add(createEq());
        }
       // insert vehicleList;
        insert equipmentList;
        
        for(integer i = 0; i < 300; i++){
          //  requestList.add(createMaintenanceRequest( );
        }
        insert requestList;
        
        for(integer i = 0; i < 300; i++){
            workPartList.add(createWorkPart(equipmentList.get(i).id, requestList.get(i).id));
        }
        insert workPartList;
        
        test.startTest();
        for(case req : requestList){
            req.Status = CLOSED;
            oldRequestIds.add(req.Id);
        }
        update requestList;
        test.stopTest();
        
        list<case> allRequests = [select id
                                 from case
                                 where status =: STATUS_NEW];
        
        list<Equipment_Maintenance_Item__c> workParts = [select id
                                                        from Equipment_Maintenance_Item__c
                                                        where Maintenance_Request__c in: oldRequestIds];
        
        system.assert(allRequests.size() == 300);
    }
}