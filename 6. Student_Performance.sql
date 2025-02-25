
create table student_tests
(
	test_id		int,
	marks		int
);
insert into student_tests values(100, 55);
insert into student_tests values(101, 55);
insert into student_tests values(102, 60);
insert into student_tests values(103, 58);
insert into student_tests values(104, 40);
insert into student_tests values(105, 50);

select * from student_tests;


-- solution - 1
-- we have to compare previous marks and 1 is use for comapre first and 0 is to remove null
select test_id,marks
from (select *, lag(marks,1,0) over(order by test_id) as prev_test_marks
       from student_tests) x
where x.marks > prev_test_marks

-- solution - 2

select test_id,marks
from (select *, lag(marks,1,marks) over(order by test_id) as prev_test_marks
       from student_tests) x
where x.marks > prev_test_marks