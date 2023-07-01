Use PRACTICE



----- Creating table
/*

create table Horizontal_Sorting
(
Caller varchar(50),
Reciever varchar(50),
Duration int
)
*/

--- creating stored procedure
/*

create procedure showTable
as
select * from Horizontal_Sorting
go;

*/

exec showTable

insert into Horizontal_sorting
values 
('Abhay','Bhanu',5),
('Abhay','Bhanu',10),
('Bhanu','Abhay',10),
('Bhanu','Abhay',25),
('Abhay','Dev',1),
('Dev','Chinmay',2),
('Bhanu','Chinmay',4),
('Chinmay','Bhanu',9),
('Chinmay','Bhanu',7),
('Chinmay','Abhay',2),
('Dev','Chinmay',5),
('Dev','Bhanu',10)



select caller,Reciever, sum(duration) as [Total Duration] 

from Horizontal_Sorting 

group by caller,Reciever

order by 1


--- the above approach will not give us correct output as Abhay-->Bhanu and Bhanu-->Abhay will be considered as different values




--- Horizontal Sorting

Select person1 as Caller, Person2 as Reciever,
sum(duration) as Duration

from(

select *, case when caller < Reciever then caller else Reciever end as person1,
case when caller > Reciever then caller else Reciever end as person2

from Horizontal_sorting

) A

group by person1, person2

order by 1,3 desc









--------- optimized SQL code by Bing AI

SELECT 
    CASE WHEN caller < Reciever THEN caller ELSE Reciever END AS Caller, 
    CASE WHEN caller > Reciever THEN caller ELSE Reciever END AS Reciever,
    SUM(duration) AS Duration
FROM Horizontal_sorting
GROUP BY 
    CASE WHEN caller < Reciever THEN caller ELSE Reciever END, 
    CASE WHEN caller > Reciever THEN caller ELSE Reciever END
ORDER BY Caller, Duration DESC;


/* Note from AI */

/* 

This version removes the subquery and instead calculates the Caller and Reciever 
values directly in the SELECT and GROUP BY clauses. 
This can improve performance by reducing the amount of data that needs to be processed. 
Additionally, the ORDER BY clause has been updated to use the column names instead of numbers for improved readability.

*/



SELECT 
    CASE WHEN caller < Reciever THEN caller ELSE Reciever END AS Caller, 
    CASE WHEN caller > Reciever THEN caller ELSE Reciever END AS Reciever,
    SUM(duration) AS Duration
FROM Horizontal_sorting
GROUP BY 
    CASE WHEN caller < Reciever THEN caller ELSE Reciever END, 
    CASE WHEN caller > Reciever THEN caller ELSE Reciever END
ORDER BY Caller, Duration DESC;