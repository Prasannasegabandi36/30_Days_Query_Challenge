/* -- Popular Posts (From Stratascratch):
The column 'perc_viewed' in the table 'post_views' denotes the percentage of the session 
duration time the user spent viewing a post. Using it, calculate the total time that each 
post was viewed by users. Output post ID and the total viewing time in seconds, 
but only for posts with a total viewing time of over 5 seconds. */

drop table if exists user_sessions;
create table user_sessions
(
	session_id				int,
	user_id					varchar(10),
	session_starttime		timestamp, -- In MSSQL replace timestamp with datetime2
	session_endtime			timestamp, -- In MSSQL replace timestamp with datetime2
	platform				varchar(20)
);
insert into user_sessions values(1	,'U1','2020-01-01 12:14:28','2020-01-01 12:16:08','Windows');
insert into user_sessions values(2	,'U1','2020-01-01 18:23:50','2020-01-01 18:24:00','Windows');
insert into user_sessions values(3	,'U1','2020-01-01 08:15:00','2020-01-01 08:20:00','IPhone');
insert into user_sessions values(4	,'U2','2020-01-01 10:53:10','2020-01-01 10:53:30','IPhone');
insert into user_sessions values(5	,'U2','2020-01-01 18:25:14','2020-01-01 18:27:53','IPhone');
insert into user_sessions values(6	,'U2','2020-01-01 11:28:13','2020-01-01 11:31:33','Windows');
insert into user_sessions values(7	,'U3','2020-01-01 06:46:20','2020-01-01 06:58:13','Android');
insert into user_sessions values(8	,'U3','2020-01-01 10:53:10','2020-01-01 10:53:50','Android');
insert into user_sessions values(9	,'U3','2020-01-01 13:13:13','2020-01-01 13:34:34','Windows');
insert into user_sessions values(10 ,'U4','2020-01-01 08:12:00','2020-01-01 12:23:11','Windows');
insert into user_sessions values(11 ,'U4','2020-01-01 21:54:03','2020-01-01 21:54:04','IPad');


drop table if exists post_views;
create table post_views
(
	session_id 		int,
	post_id			int,
	perc_viewed		float
);
insert into post_views values(1,1,2);
insert into post_views values(1,2,4);
insert into post_views values(1,3,1);
insert into post_views values(2,1,20);
insert into post_views values(2,2,10);
insert into post_views values(2,3,10);
insert into post_views values(2,4,21);
insert into post_views values(3,2,1);
insert into post_views values(3,4,1);
insert into post_views values(4,2,50);
insert into post_views values(4,3,10);
insert into post_views values(6,2,2);
insert into post_views values(8,2,5);
insert into post_views values(8,3,2.5);


select * from user_sessions;
select * from post_views;
-- solution
with cte as 
   (select p.*, session_starttime,session_endtime
   , extract('epoch' from (session_endtime - session_starttime)) as total_time
   from user_sessions s 
   join post_views p on p.session_id=s.session_id)
 select post_id
 ,sum((perc_viewed/100)*total_time) as total_viewtime
 from cte
 group by post_id
 having sum((perc_viewed/100)*total_time) > 5