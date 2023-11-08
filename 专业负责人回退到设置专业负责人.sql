--update WF_Instance set Status =9,Isactive = '0' where FatherId = '23f25ef548a166ebb3273a0473020e6a' 

--update WF_Instance set Currentstep = '25890977ed7a51eadf2539fe9755ae32' where Id = '23f25ef548a166ebb3273a0473020e6a' 
--update WF_Instance set Status = '10',Isactive = '1' where id in ('1593fdcaa674a09ed6be3a0481b481c2','72921f4814103143b1583a0481b48087')
select * from WF_Instance where mainid = '952cbd5f1c32ccf318813a047301f684' order by CREATETIME desc

 select * from WF_Task  where InstanceId  in ( select id from WF_Instance where FatherId = '23f25ef548a166ebb3273a0473020e6a' and ISACTIVE = '1')
--update WF_Task set Status = '0' where id = '4dd66c6e0f7d2a4ecd4e3a04820de9d3'
update WF_Task   set Status = '1' where InstanceId = '23f25ef548a166ebb3273a0473020e6a' 

select * from WF_Task where InstanceId = '23f25ef548a166ebb3273a0473020e6a' order by CREATETIME desc

--update WF_Task set status = '1' where InstanceId  in ( select id from WF_Instance where FatherId = '23f25ef548a166ebb3273a0473020e6a' )

--update  WF_Instance_RunningRecord  set Status = '2'  where InstanceId = '23f25ef548a166ebb3273a0473020e6a'  


-- select * from WF_Instance_RunningRecord  where InstanceId  in ( select id from WF_Instance where FatherId = '23f25ef548a166ebb3273a0473020e6a' and ISACTIVE = '1')
select * from WF_Instance_RunningRecord where InstanceId = '23f25ef548a166ebb3273a0473020e6a'  order by CREATETIME desc

--update WF_Instance_RunningRecord set WfStepDefinitionId = '25890977ed7a51eadf2539fe9755ae32' where id = 'adb9d32d69a94010587e3a04815023aa'
--update WF_Instance_RunningRecord set Status = '0' where id = '2e27ef5a119bb1ad512d3a04820de955'

--update  WF_Instance set Status = 1 where id in ('769e8f1fae318c7cc0d83a047e4bb83b','65b54b6ef078d7c03b5f3a047e4bb51b','eb0b83ccd83a76be83133a047e4bb2eb','59c5a29407e96f8020363a047e4bb0ba','92e63d8aac863fda4d203a047e4baf7b')

--update  WF_Task set Status = 1 where id in ('c1fed30d6f6b08ad119f3a047e003f3c','2717101fe4549b7395583a047dd833d4')

select * from WF_Task where InstanceId = 'bb1ced333a5ce8fb91483a048189e63d'

delete WF_Task where id = '3315df377866fc58aa0f3a048177cb33'

delete WF_Instance_RunningRecord where id = '577ee3d58ccb9b20c2e33a048177cabe'