--Drill 1:
select 
	trip_id, duration 
from 
	TRIPS 
where 
	duration > 500
order by 
	duration ;
	
--Drill 2:
select * 
from 
	stations 
where 
	station_id = 84 ;
--Drill 3:

--select  * from weather limit 10
select distinct
	min(mintemperaturef)
from 
	weather 
where 
	zip = 94301
and 
	events = 'Rain'
