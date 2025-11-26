with NewPassengers_by_City as
(
	select 
		* , 
		count(*) over() as TotRows, 
		ROW_NUMBER() over(order by Total_New_Passengers DESC) as RowNum
	from
		(	
			select 
				city_id , sum(new_passengers) as Total_New_Passengers 
			from 
				trips_db.dbo.fact_passenger_summary 
			group by 
				city_id
		)t
)

select 
	city_id, 
	Total_New_Passengers, 
	case
		when RowNum < = 3 then 'Top 3'
		when RowNum > 7 then 'Bot 3'
		else ''
	End as city_category
from 
	NewPassengers_by_City
order by 
	Total_New_Passengers desc