with Result as
(
	Select 
		city_id,  
		Datename(Month,date) as DN,
		sum(fare_amount) Revenue,
		first_value( Datename(Month,date)  ) 
			over( partition by city_id order by sum(fare_amount) desc) as TopMonth,
		sum( sum(fare_amount) ) over( partition by city_id ) as Total_Revenue
	
	from 
		trips_db.dbo.fact_trips
	group by
		city_id, Datename(Month,date)
)

select 
	city_name,
	TopMonth,
	Format(Revenue ,'c' , 'en-IN' ) Revenue,
	round( Cast(Revenue as float) * 100 / Total_Revenue ,2) 
	 as Percertage_Contribution
from 
	Result R
	left join trips_db.dbo.dim_city C 
		on R.city_id = C.city_id

where 
	TopMonth = DN

	