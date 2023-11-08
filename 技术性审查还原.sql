select * from WF_Instance where id = '1a72dd0299b8ff471e3a3a0424db5721'

--update WF_Instance set CurrentStep = 'd88bb09b873c3c437f4039feb641f90a' where id = '1a72dd0299b8ff471e3a3a0424db5721'

--update WF_Instance set CurrentStep = 'efdc14fbc62b4a789d01d9205c285c12' where id = '1a72dd0299b8ff471e3a3a0424db5721'



select * from WF_Task where InstanceId = '1a72dd0299b8ff471e3a3a0424db5721'

--update WF_Task set WfStepDefinitionId = 'efdc14fbc62b4a789d01d9205c285c12' where id = 'bc571111a613c2b4ed003a042a36d245'

select * from WF_Definition where id = 'efdc14fbc62b4a789d01d9205c285c12'

select * from WF_Instance_RunningRecord  where InstanceId = '1a72dd0299b8ff471e3a3a0424db5721'

--delete WF_Instance_RunningRecord where id = '2646bae524394382b8403a042a36d1be'
--update WF_Instance_RunningRecord set status = 0 where id = '1672bff77627b5fafb503a0429c0f0ef'

--delete WF_Task where InstanceId = '1a72dd0299b8ff471e3a3a0424db5721'