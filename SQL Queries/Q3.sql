DECLARE @cols NVARCHAR(MAX), @query NVARCHAR(MAX);


With Total_RP_By_City_RepeatCnt as
(
    select 
        city_id,
        trip_count, 
        sum(repeat_passenger_count)  as Total_R_Passengers,
        Sum(sum(repeat_passenger_count)) over( partition by city_id ) as Total_Trips
    from  
        trips_db.dbo.dim_repeat_trip_distribution
    Group by 
        city_id,
        trip_count
    
)

select 
    city_name,  
    (select Round( Total_R_Passengers * 100 / Cast(Total_Trips as float ) , 2 )  
        from Total_RP_By_City_RepeatCnt _rp 
        where _rp.city_id = RP.city_id and _rp.trip_count like '%1%'
    ) as '1 Trip',
    (select Round( Total_R_Passengers * 100 / Cast(Total_Trips as float ) , 2 ) 
        from Total_RP_By_City_RepeatCnt _rp 
        where _rp.city_id = RP.city_id and _rp.trip_count like '%2%'
    ) as '2 Trips',
    (select Round( Total_R_Passengers * 100 / Cast(Total_Trips as float ) , 2 ) 
        from Total_RP_By_City_RepeatCnt _rp 
        where _rp.city_id = RP.city_id and _rp.trip_count like '%3%'
    ) as '3 Trips',
    (select Round( Total_R_Passengers * 100 / Cast(Total_Trips as float ) , 2 ) 
        from Total_RP_By_City_RepeatCnt _rp 
        where _rp.city_id = RP.city_id and _rp.trip_count like '%4%'
    ) as '4 Trips',
    (select Round( Total_R_Passengers * 100 / Cast(Total_Trips as float ) , 2 ) 
        from Total_RP_By_City_RepeatCnt _rp 
        where _rp.city_id = RP.city_id and _rp.trip_count like '%5%'
    ) as '5 Trips',
    (select Round( Total_R_Passengers * 100 / Cast(Total_Trips as float ) , 2 ) 
        from Total_RP_By_City_RepeatCnt _rp 
        where _rp.city_id = RP.city_id and _rp.trip_count like '%6%'
    ) as '6 Trips',
    (select Round( Total_R_Passengers * 100 / Cast(Total_Trips as float ) , 2 ) 
        from Total_RP_By_City_RepeatCnt _rp 
        where _rp.city_id = RP.city_id and _rp.trip_count like '%7%'
    ) as '7 Trips',
    (select Round( Total_R_Passengers * 100 / Cast(Total_Trips as float ) , 2 ) 
        from Total_RP_By_City_RepeatCnt _rp 
        where _rp.city_id = RP.city_id and _rp.trip_count like '%8%'
    ) as '8 Trips',
    (select Round( Total_R_Passengers * 100 / Cast(Total_Trips as float ) , 2 ) 
        from Total_RP_By_City_RepeatCnt _rp 
        where _rp.city_id = RP.city_id and _rp.trip_count like '%9%'
    ) as '9 Trips',
    (select Round( Total_R_Passengers * 100 / Cast(Total_Trips as float ) , 2 ) 
        from Total_RP_By_City_RepeatCnt _rp 
        where _rp.city_id = RP.city_id and _rp.trip_count like '%10%'
    ) as '10 Trips'

from 
     trips_db.dbo.dim_city RP 
