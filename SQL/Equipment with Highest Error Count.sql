select top 1 e.machineid,e.age,e.model,count(er.errorid) as error_count from Equipmenterrors er inner join Equipment e on er.machineid=e.machineid
group by e.machineid,e.age,e.model
order by error_count desc;