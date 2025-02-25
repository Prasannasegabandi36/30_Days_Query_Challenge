-- code 
create table salary
(
	emp_id		int,
	emp_name	varchar(30),
	base_salary	int
);
insert into salary values(1, 'Rohan', 5000);
insert into salary values(2, 'Alex', 6000);
insert into salary values(3, 'Maryam', 7000);


drop table if exists income;
create table income
(
	id			int,
	income		varchar(20),
	percentage	int
);
insert into income values(1,'Basic', 100);
insert into income values(2,'Allowance', 4);
insert into income values(3,'Others', 6);


drop table if exists deduction;
create table deduction
(
	id			int,
	deduction	varchar(20),
	percentage	int
);
insert into deduction values(1,'Insurance', 5);
insert into deduction values(2,'Health', 6);
insert into deduction values(3,'House', 4);


drop table if exists emp_transaction;
create table emp_transaction
(
	emp_id		int,
	emp_name	varchar(50),
	trns_type	varchar(20),
	amount		numeric
);
insert into emp_transaction
select s.emp_id, s.emp_name, x.trns_type
, case when x.trns_type = 'Basic' then round(base_salary * (cast(x.percentage as decimal)/100),2)
	   when x.trns_type = 'Allowance' then round(base_salary * (cast(x.percentage as decimal)/100),2)
	   when x.trns_type = 'Others' then round(base_salary * (cast(x.percentage as decimal)/100),2)
	   when x.trns_type = 'Insurance' then round(base_salary * (cast(x.percentage as decimal)/100),2)
	   when x.trns_type = 'Health' then round(base_salary * (cast(x.percentage as decimal)/100),2)
	   when x.trns_type = 'House' then round(base_salary * (cast(x.percentage as decimal)/100),2) end as amount	   
from salary s
cross join (select income as trns_type, percentage from income
			union
			select deduction as trns_type, percentage from deduction) x;


select * from salary;
select * from income;
select * from deduction;
select * from emp_transaction;
 -- solution for table 1
 -- we have to insert data into emp_tran
 insert into emp_transaction
select emp_id,emp_name,trns_type
, case when trns_type ='Allowance' then round(base_salary * (percentage/100),2)
        when trns_type ='Others' then round(base_salary * (percentage/100),2)
		 when trns_type ='Insurance' then round(base_salary * (percentage/100),2)
		  when trns_type ='Health' then round(base_salary * (percentage/100),2)
		   when trns_type ='House' then round(base_salary * (percentage/100),2)
		    when trns_type ='Basic' then round(base_salary * (percentage/100),2)
end amount
from salary
cross join(select income as trns_type,cast(percentage as decimal) as percentage from income
            union
			select deduction as trns_type,cast(percentage as decimal ) as percentage from deduction) x
order by 2
---solution 2 
-- we have to convert  row data into column
-- building salary report
create extension tablefunc;

select employee
, basic, allowance,others
, (basic+allowance+others) as gross
, insurance,health,house
,( insurance+health+house) as total_deduction
,(basic+allowance+others) - ( insurance+health+house) as net_pay
from crosstab('select emp_name,trns_type,amount
                from emp_transaction
				order by emp_name,trns_type'
				,'select distinct trns_type from emp_transaction order by trns_type')
	as result(employee varchar, allowance numeric,basic numeric, health numeric
	          , house numeric, insurance numeric,others numeric)
 --- this is base query:  select emp_name,trns_type,amount from emp_transaction
--- list distants : select distinct trns_type from emp_transaction
--- final columns with data type : 

