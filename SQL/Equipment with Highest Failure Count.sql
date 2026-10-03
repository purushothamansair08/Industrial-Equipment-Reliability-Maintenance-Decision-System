SELECT
top 1
    e.machineID,
    e.model,
    e.age,
    COUNT(f.machineID)AS failure_count
FROM Equipment e
LEFT JOIN
Equipmentfailures f
on e.machineid=f.machineid
group by e.machineID,e.model,e.age 
order by failure_count desc;