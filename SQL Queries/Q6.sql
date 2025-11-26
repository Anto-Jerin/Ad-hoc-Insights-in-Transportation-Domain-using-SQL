with result as 
(
	select 
		city_name, 
		DATENAME(month,month) as Month,
		sum(total_passengers) as TotalPassengers,
		sum(repeat_passengers) as Repeatpassengers,
		sum( sum( repeat_passengers) ) over( partition by city_name) 
			as Total_Repeat_Passengers
	

	from 
		trips_db.dbo.fact_passenger_summary F
		left join trips_db.dbo.dim_city C 
			on F.city_id = C.city_id

	group by
		city_name, 
		DATENAME(month,month)
)

select 
	city_name, 
	Month, 
	TotalPassengers, 
	Repeatpassengers, 
	Round( Cast( Repeatpassengers as float) * 100 / TotalPassengers,2) 
	as Monthly_RepeatPassengerRate,
	Round( Cast( Repeatpassengers as float) * 100 / Total_Repeat_Passengers,2) 
	as City_RepeatPassengerRate
from 
	result

