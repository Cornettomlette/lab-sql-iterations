/*Lab | SQL Iterations
In this lab, we will continue working on the Sakila database of movie rentals.

Instructions
Write queries to answer the following questions:

1) Write a query to find what is the total business done by each store.
2) Convert the previous query into a stored procedure.
3) Convert the previous query into a stored procedure that takes the input for store_id and displays the total sales for that store.
4) Update the previous query. Declare a variable total_sales_value of float type, that will store the returned result (of the total sales amount for the store). 
   Call the stored procedure and print the results.
5) In the previous query, add another variable flag. If the total sales value for the store is over 30.000, then label it as green_flag, otherwise label is as red_flag. 
   Update the stored procedure that takes an input as the store_id and returns total sales value for that store and flag value.*/
   
USE sakila_copy_lab;
-- 1) Write a query to find what is the total business done by each store.
SELECT st.store_id, sum(p.amount) 
from payment p
join staff sff on p.staff_id = sff.staff_id
join store st on sff.store_id = st.store_id
group by store_id;

-- 2) Convert the previous query into a stored procedure.

delimiter //
create procedure store_profit1 ()
begin
SELECT st.store_id, sum(p.amount) 
from payment p
join staff sff on p.staff_id = sff.staff_id
join store st on sff.store_id = st.store_id
group by store_id;
end;
//
delimiter ;
call store_profit1();

-- 3) Convert the previous query into a stored procedure that takes the input for store_id and displays the total sales for that store.
delimiter //
create procedure store_profit2(in param1 tinyint)
begin
SELECT st.store_id, sum(p.amount) 
from payment p
join staff sff on p.staff_id = sff.staff_id
join store st on sff.store_id = st.store_id
group by store_id
having store_id = param1;
end;
//
delimiter ;
call store_profit2(2);

-- 4) Update the previous query. Declare a variable total_sales_value of float type, that will store the returned result (of the total sales amount for the store). 
--    Call the stored procedure and print the results.

delimiter //
create procedure store_profit3(in param1 tinyint)
begin
declare sum_amount float default 0.0;
SELECT sum(p.amount) into sum_amount
from payment p
join staff sff on p.staff_id = sff.staff_id
join store st on sff.store_id = st.store_id
group by st.store_id
having st.store_id = param1;
select param1, sum_amount ;
end;
//
delimiter ;
call store_profit3(1);

show procedure status where db = 'sakila_copy_lab';

--  5) In the previous query, add another variable flag. If the total sales value for the store is over 30.000, then label it as green_flag, otherwise label is as red_flag. 
--     Update the stored procedure that takes an input as the store_id and returns total sales value for that store and flag value.*/
delimiter //
create procedure store_profit4(in param1 tinyint)
begin
declare sum_amount float default 0.0;
SELECT sum(p.amount) into sum_amount
from payment p
join staff sff on p.staff_id = sff.staff_id
join store st on sff.store_id = st.store_id
group by st.store_id
having st.store_id = param1;
select param1, sum_amount, CASE
	when sum_amount > 30000 THEN 'green_flag'
	else 'red_flag'
    end as 'flag';
end;
//
delimiter ;
call store_profit4(2);