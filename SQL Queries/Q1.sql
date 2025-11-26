
with Overview_By_City as
(
	select 
		city_id, 
		count(*) as total_trips, 
		sum(fare_amount) total_fare, 
		sum(distance_travelled_km) as Total_Dist 
	from 
		trips_db.dbo.fact_trips
	group by 
		city_id
)

select 
	C.city_name, 
	total_trips, 
	Round( cast( total_fare as float ) / Total_Dist,0) Fare_Per_KM, 
	Round( cast( total_fare as float ) / total_trips ,0)  Fare_per_Trip,
	
	Round( cast(total_trips as float) * 100/(select sum(total_trips) from Overview_By_City ),2) '%contribution'
from 
	Overview_By_City as OBC
	left join trips_db.dbo.dim_city C 
		on OBC.city_id = C.city_id

