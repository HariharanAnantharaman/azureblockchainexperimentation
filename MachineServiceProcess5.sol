pragma solidity ^0.4.20;

contract WorkbenchBase {
    event WorkbenchContractCreated(string applicationName, string workflowName, address originatingAddress);
    event WorkbenchContractUpdated(string applicationName, string workflowName, string action, address originatingAddress);

    string internal ApplicationName;
    string internal WorkflowName;

    function WorkbenchBase(string applicationName, string workflowName) internal {
        ApplicationName = applicationName;
        WorkflowName = workflowName;
    }

    function ContractCreated() internal {
        WorkbenchContractCreated(ApplicationName, WorkflowName, msg.sender);
    }

    function ContractUpdated(string action) internal {
        WorkbenchContractUpdated(ApplicationName, WorkflowName, action, msg.sender);
    }
}

contract MachineServiceProcess5 is WorkbenchBase('MachineServiceProcess5', 'MachineServiceProcess5') {

    //Set of States
    enum StateType { RepairReported, ServiceStarted, ServiceCompleted, ServiceApproved,Completed}
    

    //List of properties
    StateType public  State;
    address public  StoreManager;
    address public  Technician;
	string public MachineNumber;
   

    function MachineServiceProcess5(address storeManager, address technician,string machineNumber) public
    {
        StoreManager = storeManager;
        Technician = technician;
        MachineNumber = machineNumber;
        State = StateType.RepairReported;
		ContractCreated();
        
    }
	
	function Complete() public
    {
		State = StateType.Completed;
        ContractUpdated('Complete');
    }
	function initiateRepair() public
    {
		State = StateType.RepairReported;
        ContractUpdated('initiateRepair');
    }
	
	function startService() public
    {
		State = StateType.ServiceStarted;
        ContractUpdated('startService');
    }
	
	function completeService() public
    {
		State = StateType.ServiceCompleted;
        ContractUpdated('completeService');
    }
	function approveService() public
    {
		State = StateType.ServiceApproved;
        ContractUpdated('approveService');
    }
	
	
    
}
