-- Find the median ages of countries

drop table if exists people;
create table people
(
	id			int,
	country		varchar(20),
	age			int
);
insert into people values(1 ,'Poland',10 );
insert into people values(2 ,'Poland',5  );
insert into people values(3 ,'Poland',34   );
insert into people values(4 ,'Poland',56);
insert into people values(5 ,'Poland',45  );
insert into people values(6 ,'Poland',60  );
insert into people values(7 ,'India',18   );
insert into people values(8 ,'India',15   );
insert into people values(9 ,'India',33 );
insert into people values(10,'India',38 );
insert into people values(11,'India',40 );
insert into people values(12,'India',50  );
insert into people values(13,'USA',20 );
insert into people values(14,'USA',23 );
insert into people values(15,'USA',32 );
insert into people values(16,'USA',54 );
insert into people values(17,'USA',55  );
insert into people values(18,'Japan',65  );
insert into people values(19,'Japan',6  );
insert into people values(20,'Japan',58  );
insert into people values(21,'Germany',54  );
insert into people values(22,'Germany',6  );
insert into people values(23,'Malaysia',44  );

select * from people;
-- solution
select country,age
from(
     select *
     , row_number() over(partition by country order by age) age_rnk
     ,  cast(count(id) over(partition by country order by age
                    range between unbounded preceding and unbounded following) as decimal)
				as total_ppl
from people) x
where age_rnk >= total_ppl/2 and age_rnk <= (total_ppl/2) + 1