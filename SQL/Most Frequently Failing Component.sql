select top 1 failure,count(failure) as failure_count from equipmentfailures
group by failure
order by failure_count desc;