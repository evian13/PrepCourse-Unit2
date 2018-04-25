--1.What was the hottest day in our data set? Where was that?
select 
	date as date_hotest
	,maxtemperaturef as temp_hotest
	,zip as zip_location
from 
	weather
order by maxtemperaturef desc
	limit 1	;

--2.How many trips started at each station?
select 
	count(*) as Number_of_Trips, start_Station 
from 
	trips 
group by 
	start_Station ;
	
--3.What's the shortest trip that happened?
select 
	*
from 
	trips
order by duration asc	
limit 1 
	 ;

--4.What is the average trip duration, by end station?
select 
	round(avg(duration),2) as duration_avg
	, end_station
from 
	trips 
group by 
	end_station ;
