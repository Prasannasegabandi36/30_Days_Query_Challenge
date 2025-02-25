create table Q4_data
(
	id			int,
	name		varchar(20),
	location	varchar(20)
);
insert into Q4_data values(1,null,null);
insert into Q4_data values(2,'David',null);
insert into Q4_data values(3,null,'London');
insert into Q4_data values(4,null,null);
insert into Q4_data values(5,'David',null);

select * from Q4_data;

-- Solution

-- select id,name,location from Q4_data limit 1 ;
-- this gives only first row
-- so we have to use an inbuilt (aggregate) function
select min(id) id , min(name) name, min(location) location
from Q4_data;

select max(id) id, max(name) name, max(location) location
from Q4_data;
