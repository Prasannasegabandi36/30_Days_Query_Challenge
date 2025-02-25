DROP TABLE IF EXISTS Friends;

CREATE TABLE Friends
(
	Friend1 	VARCHAR(10),
	Friend2 	VARCHAR(10)
);
INSERT INTO Friends VALUES ('Jason','Mary');
INSERT INTO Friends VALUES ('Mike','Mary');
INSERT INTO Friends VALUES ('Mike','Jason');
INSERT INTO Friends VALUES ('Susan','Jason');
INSERT INTO Friends VALUES ('John','Mary');
INSERT INTO Friends VALUES ('Susan','Mary');

select * from Friends;
-- solution
with all_friends as
	(SELECT friend1,friend2 FROM Friends
	union 
	SELECT friend2 ,friend1 FROM Friends)
select distinct f.friend1, f.friend2 --, cf.friend2 as mutual_frnd
, count(cf.friend1) over(partition by f.friend1, f.friend2 order by f.friend1, f.friend2
						 range between unbounded preceding and unbounded following) as mutual_friends 
from friends f 
left join all_friends cf 
		on f.friend1 = cf.friend1
		and cf.friend2 in ( select cf2.friend2
							from all_friends cf2
							where f.friend2 = cf2.friend1);




