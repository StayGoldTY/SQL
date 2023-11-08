---查询办理记录
SELECT b.WorkStep,a.Approver,CASE a.ApproveStatus WHEN 0 then  '办理中' ELSE '已完成' END AS  ApproveStatus,'' AS EndDate FROM dbo.StepApprovers a
LEFT JOIN WorkInstances b ON a.WorkInsID = b.ID
LEFT JOIN WorkSteps c ON b.WorkID = c.WorkID
WHERE a.WorkInsID = {WorkInstancesID}
ORDER BY a.id DESC