select * from 
(
(select * from table1 where col>now() order by col limit 1)
union all
(select * from table1 where col<now() order by col desc limit 1)
) t
order by col desc limit 1