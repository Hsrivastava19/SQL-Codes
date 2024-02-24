-------------------------------------------Easy-------------------------------------------

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
2. Which country has the most Invoices?
Table: select * from invoice
*/
SELECT top 1 COUNT(*) AS Invoice_count, billing_country 
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

/*
3 What are top 3 highest invoice values?
Table: select * from invoice
*/

select top 3 invoice_id, total from invoice
order by total desc

/*
4  Write a query that returns one city that has the highest sum of invoice totals. Return both the city name & sum of all invoice totals
Table: select * from invoice
*/
select top 1 billing_city, round(sum(total),2) as [Sum of invoices]
from invoice
group by billing_city
order by [Sum of invoices] desc

/*
5 Write a query that returns the person who has spent the most money

select * from customer
select * from invoice
*/

Select top 1 i.customer_id, c.first_name, c.last_name, c.city, round(sum(i.total),2) as [Total spent by customer]
from customer c
inner join invoice i
on c.customer_id = i.customer_id
group by i.customer_id, c.first_name, c.last_name, c.city
order by [Total spent by customer] desc

-------------------------------------------Moderate-------------------------------------------

/*
1 Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
Return your list ordered alphabetically by email starting with A
*/
select distinct c.email, c.first_name, c.last_name
from customer c, invoice i, invoice_line il
where c.customer_id = i.customer_id
and i.invoice_id = il.invoice_id
and il.track_id in (
	SELECT track_id FROM track t, genre g
	where t.genre_id = g.genre_id
	and g.name LIKE 'Rock'
)
ORDER BY email;

--Alternatively we can use Joins as well

SELECT DISTINCT email,first_name, last_name
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
WHERE track_id IN(
	SELECT track_id FROM track
	JOIN genre ON track.genre_id = genre.genre_id
	WHERE genre.name LIKE 'Rock'
)
ORDER BY email;