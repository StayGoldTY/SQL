update WF_Instance_RunningRecord set id = '25f04bf34e4a2f1cc76a3a0459c45fc9',InstanceId = 'cfa5a8fbc472791901d53a044e3ed018',
SubmitBy = '460100195801081554',CREATEBY = '460100195801081554' where id = '03879a93dbc107b00a293a02c6b0a7bc'

UPDATE WF_Instance SET STATUS = '1',currentstep = '62a374e9bbd4ee6ab39a39fe9278bae4'   WHERE ID = 'cfa5a8fbc472791901d53a044e3ed018'

update WF_Instance_RunningRecord set status = '0' where id = '25f04bf34e4a2f1cc76a3a0459c45fc9'


UPDATE WF_Task SET Status = 0  WHERE ID = '2e3233a0e00a63214d7a3a0459c45fcf'

UPDATE WF_Task SET Status = 1  WHERE ID = '2a62d50b8ccd400bc2873a04078436fc'

UPDATE WF_Instance SET STATUS = '10',currentstep = '62a374e9bbd4ee6ab39a39fe9278bae4'  WHERE ID = '93bcc9085b500ffaaddd3a04078436fc'