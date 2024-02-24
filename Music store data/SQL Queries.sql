/*1. Who is the senior most employee based on job title?

To get the table: select * from employee
*/

Select top 1 title , first_name,last_name
from employee
order by levels desc

--Alternatively we can use window function to dynamically select the Nth senior employee
declare @n int

set @n =1;

with cte_employee as (
	select *,
	DENSE_RANK() over (order by levels desc) as rnk
	from employee
)
select title , first_name,last_name from cte_employee
where rnk = @n

/* 
2. Which country has the most Invoices?Table: select * from invoice*/SELECT top 1 COUNT(*) AS Invoice_count, billing_country 
FROM invoice
GROUP BY billing_country
ORDER BY Invoice_count DESC

--to find the Nth highest Invoicing country
declare @n int;
set @n=5;

WITH TopInvoices AS (
    SELECT TOP (@n) COUNT(*) AS Invoice_count, billing_country
    FROM invoice
    GROUP BY billing_country
    ORDER BY Invoice_count DESC
)
SELECT top 1 *
FROM TopInvoices
order by Invoice_count;