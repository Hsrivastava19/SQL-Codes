--select * from employee_salary

--select avg(salary) from employee_salary


/*
select empid, empname, department,salary,
round((salary/sum(salary) over(partition by department))*100,2) as percentag
from employee_salary
*/


select empname,salary, department from
(
select *,
rank() over(partition by department order by salary desc) as sal_rank
from employee_salary
) a
where sal_rank = 1
order by salary desc
