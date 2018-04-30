--1.What are the three longest trips on rainy days?

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

--2. Which station is full most often?

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

--3. Return a list of stations with a count of number of trips starting at that station but ordered by dock count.
select start_station
,start_terminal
,count(*) as NumberOfTrips
,s.dockcount
 from trips  t 
 left join stations s on t.start_terminal = s.station_id
 group by start_station,start_terminal
 order by s.dockcount desc


--4. What's the length of the longest trip for each day it rains anywhere ?

with rainy_days as (
select distinct date,events/*,zip*/  from weather where Events = 'Rain' order by date
 )
-- limit 100
, trip_duration as (
select 
 date(start_date) as start_date_slim
,max(duration)

 from trips 
 group by start_date_slim
 order by start_date_slim , duration desc
)

select 
t.*
from trip_duration t
inner join rainy_days r on r.date = t.start_date_slim



