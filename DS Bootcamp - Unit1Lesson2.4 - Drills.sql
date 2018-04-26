--What are the three longest trips on rainy days?

WITH 
rainydays as (
	select distinct
		date
	from 
		weather 
	where 
		Events = 'Rain' 
	)
	, trips_date as (
	select 
		strftime( '%Y-%m-%d' , start_date) start_date_
		,strftime( '%Y-%m-%d' , end_date) end_date_
		,trip_id
		,start_date
		,start_station
		,end_date
		,end_station
		,duration 
		, zip_code
		
	from trips
		)
		
select t.*, r.[date]
from trips_date as t
inner join rainydays as r on t.start_date_ = r.date
	--and t.zip_code = r.zip
order by duration desc
limit 3

-- Which station is full most often?

select s.station_id
	,count(*) as Full 
	,ss.name
	, case when docks_available = 0 then 1 else 0 end empty_docks
from status s
inner join stations ss on s.station_id = ss.station_id
 where empty_docks = 1 
 group by s.station_id -- order by full desc limit 10
	order by full  desc
	limit 1 -- San Francisco Caltrain (Townsend at 4th)



