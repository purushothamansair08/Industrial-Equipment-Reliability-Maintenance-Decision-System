select top 1 e.machineid,e.model,e.age,count(m.comp) as maintenance_count from equipment e inner join equipmentmaintenance m
on e.machineid=m.machineid
group by e.machineid,e.model,e.age
order by maintenance_count desc;
