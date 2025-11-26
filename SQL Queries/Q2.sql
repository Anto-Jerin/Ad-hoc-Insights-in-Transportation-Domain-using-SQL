with Overview_By_City_Month as
(
	select 
		city_id,
		datename(Month,date) as 'month',
		count(*) as total_trips, 
		sum(fare_amount) total_fare, 
		sum(distance_travelled_km) as Total_Dist 
	from
		trips_db.dbo.fact_trips
	group by 
		city_id, 
		datename(Month,date)
),
Target_Overview as
(
	select 
		*,
		datename(month,month) as MonthName 
	from 
		[targets_db].[dbo].[monthly_target_trips]
)


select 
	C.city_name, 
	OBC.month as Month, 
	total_trips, 
	total_target_trips as target_trips, 

	Case 
		when total_target_trips < total_trips then 'Above Target'
		when total_target_trips > total_trips then 'Below Target'
	END as performance_status,

	round(((total_trips - total_target_trips)*Cast(100 as float) / total_target_trips)  , 2)  as '%_difference'

from 
	Overview_By_City_Month as OBC
	left join Target_Overview as T 
		on T.city_id = OBC.city_id and OBC.month = T.MonthName
	left join trips_db.dbo.dim_city as C 
		on C.city_id = OBC.city_id
