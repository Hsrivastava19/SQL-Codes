-- Check all the records from a particular Table
select * from employees

-- Check Distinct values
select distinct Empname,salary from employees

--Add a temporary table and add all distinct values
select distinct Empname,salary into #temp_Employeee from employees

-- View the newly created temporary table
select * from #temp_employeee

--Select Top 3 salaries from table
select top 3 salary, Empname from #temp_Employeee
order by salary desc

--Using a sub-query to find the third highest salary
select top 1 * from
(select top 3 salary, Empname from #temp_Employeee
order by salary desc) as tableval
order by salary;
