-- For the Airbnb project I used data for the city of Berlin.
-- After the import of the csv in the DB Browser I changed the types of numeric columns from text to either integer or double.

UPDATE listings SET id = cast (id as integer),
scrape_id = cast (scrape_id as integer),
last_scraped= strftime( '%Y-%m-%d' , last_scraped),
host_id = cast (host_id as integer),
host_since= strftime( '%Y-%m-%d' , host_since),
host_listings_count = cast (host_listings_count as integer),
host_total_listings_count = cast (host_total_listings_count as integer),
latitude = cast (latitude as real),
accommodates = cast (accommodates as integer),
bathrooms = cast (bathrooms as integer),
bedrooms = cast (bedrooms as integer),
beds = cast (beds as integer),
square_feet = cast (square_feet as integer),
guests_included = cast (guests_included as integer),
minimum_nights = cast (minimum_nights as integer),
maximum_nights = cast (maximum_nights as integer),
availability_30 = cast (availability_30 as integer),
availability_60 = cast (availability_60 as integer),
availability_90 = cast (availability_90 as integer),
availability_365 = cast (availability_365 as integer),
calendar_last_scraped= strftime( '%Y-%m-%d' , calendar_last_scraped),
first_review= strftime( '%Y-%m-%d' , first_review),
last_review= strftime( '%Y-%m-%d' , last_review),
review_scores_rating = cast (review_scores_rating as integer),
review_scores_accuracy = cast (review_scores_accuracy as integer),
review_scores_cleanliness = cast (review_scores_cleanliness as integer),
review_scores_checkin = cast (review_scores_checkin as integer),
review_scores_communication = cast (review_scores_communication as integer),
review_scores_location = cast (review_scores_location as integer),
review_scores_value = cast (review_scores_value as integer)

-- Add a new column to the db to test the modifications on 'price' column:
ALTER TABLE listings ADD COLUMN price_val double;
-- Copy data from 'price' to the new column:
update listings set price_val = price;

-- Remove the special character to be able to aggregate over this column:
update listings set price_val = replace(price_val,'$','')

--1.What's the most expensive listing? What else can you tell me about the listing?
select * from listings order by price_val desc limit 2
	-- This listing looks like a big hoax. The price is outrageous for a 45m2, 4 low quality pictures and nothing to make you believe it is a real offer. 
	-- When this data was scraped the price was $9000/night, but today it is $11,303!

--2.What neighborhoods seem to be the most popular?

select  
	neighbourhood_cleansed,count(*) as Count_Neighbour 
from 
	listings 
group by 
	neighbourhood_cleansed  
order by 
	Count_Neighbour desc	
limit 10


--3.What time of year is the cheapest time to go to your city? What about the busiest?
UPDATE calendar_airbnb SET listing_id = cast (listing_id as integer)

update 
		calendar_airbnb 
	set 
		price = replace(price,'$','')
		
		
with calendar as 
(
	select 
		*
		,strftime( '%Y-%m' ,date) as YYYYMM		
		
	from
		calendar_airbnb
	where
		available = 't'	
	--order by date
)

select yyyymm,avg(price) as AveragePrice from calendar group by YYYYMM order by AveragePrice
 -- It looks like February and March are the cheapest months with an average price per night of ~$68.
 -- The busiest month is August, the Holiday month, with ~$72.53