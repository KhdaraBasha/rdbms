
--	***************
-- 	1. Basic Joins
--	***************
select *
from happiness_scores hs 
limit 100
;

select *
from country_stats cs 
limit 100
;

select hs."year" , hs.country , hs.happiness_score , cs.continent 
from happiness_scores hs 
inner join country_stats cs 
on hs.country = cs.country 
;

--	***************
-- 	2. JOIN TYPES
--	***************
-- INNER JOIN
select 
	hs."year" ,hs.country ,hs.happiness_score ,cs.continent 
from happiness_scores hs 
inner join country_stats cs
on hs.country = cs.country 
;
-- LEFT JOIN
select
	hs."year", hs.country, hs.happiness_score ,cs.continent 
from happiness_scores hs
left join country_stats cs
on hs.country = cs.country 
where cs.country is null 
;
-- RIGHT JOIN 
select
	hs."year", hs.country, hs.happiness_score ,cs.continent 
from happiness_scores hs
right join country_stats cs
on hs.country = cs.country 
where hs.country is null 
; 
-- FULL OUTER JOIN
select
	hs."year", hs.country, hs.happiness_score ,cs.continent 
from happiness_scores hs
full outer join country_stats cs
on hs.country = cs.country 
where cs.country is null or hs.country is null
;

--	***************************
--	ASSIGNMENT 1: Basic Joins
--	***************************
-- 	Looking at the orders and product tables, which products exists in one table, but not the other?

-- 	View the orders and products tatble

--	Ordered Table
select *
from orders o 
limit 100
;

--	Numbre of rceords in orders table
select count(*) from orders o ;
-- *Tital records 8,549
select count(distinct o.product_id ) from orders o;
-- *Distinct products in orders table is 15 

--	Verfying granularity of orders table
select o.transaction_id, count(*) as cnt_transactions
from orders o 
group by 1
having count(*) > 1
;

select o.order_id , count(*) as cnt_transactions
from orders o 
group by 1
having count(*) > 1
limit 10
;

--	Product Table
select *
from products p 
;

--	Number of records in the product table
select count(*) from products p;
--	*Total Records 	18

-- Verfying granularity of product table
select p.product_id, count(*)
from products p 
group by p.product_id 
having count(*) > 1
;

--	Join the tables using various join types & note the number of rows in the output table

-- INNER JOIN
select count(distinct p.product_id ) as dst_cnt_of_product_id, count(*) as total_records
from products as p
inner join orders as o
on p.product_id = o.product_id 
;
-- dst_cnt_of_product_id: 15, total_records: 8549

-- LEFT JOIN
select count(distinct p.product_id ) as dst_cnt_of_product_id, count(*) as total_records
from products as p
left join orders as o
on p.product_id = o.product_id 
;
-- dst_cnt_of_product_id: 18, total_records: 8552

-- RIGHT JOIN
select count(distinct o.product_id ) as dst_cnt_of_product_id, count(*) as total_records
from products as p
right join orders as o
on p.product_id = o.product_id 
;
-- dst_cnt_of_product_id: 15, total_records: 8549

-- FULL OUTER JOIN
select count(distinct o.product_id ) as dst_cnt_of_product_id_o, count(distinct p.product_id ) as dst_cnt_of_product_id_p, count(*) as total_records
from products as p
full outer join orders as o
on p.product_id = o.product_id 
;
-- dst_cnt_of_product_id_o: 15, dst_cnt_of_product_id_p: 18, total_records: 8549

select p.product_id as p_product_id, o.product_id as o_product_id
from products as p
full outer join orders as o
on p.product_id = o.product_id 
where p.product_id is null or o.product_id is null
group by 1,2
;

--	There products are available in the product table and not in transcation table

--	***************************
-- 	3. JOIN ON MULTIPLE COLUMNS
--	***************************
--	We can JOIN tableas on multiple columns by using "AND" in the join condition

select
	hs.year, hs.country, hs.happiness_score, ir.inflation_rate 
from happiness_scores hs 
inner join inflation_rates ir 
on hs."year" = ir."year" 
and hs.country = ir.country_name
;

--	***************************
-- 	4. JOIN MULTIPLE TABLES
--	***************************
--	We can join more than two tables as long as you specify the columns that link the tables to gether
select
	hs.year, hs.country, hs.happiness_score, ir.inflation_rate, cs.continent 
from happiness_scores hs 
inner join country_stats cs 
	on hs.country = cs.country 
inner join inflation_rates ir 
on hs."year" = ir."year" 
and hs.country = ir.country_name
;

--	***************************
-- 	5. SELF JOIN
--	***************************
--	A self join lets you join a table with itself, and typically involves two steps:
--		1. Combine a table with itself based on a matching column
--		2. Filter on the resulting rows based on some criteria

--	Sample Data For Self Join
-- 	Create Employee Table
create table if not exists employees
	(
		employee_id INT primary key,
		employee_name VARCHAR(200),
		salary INT,
		manager_id INT
	);
--	Insert Data Into Employee Table
insert into employees(employee_id, employee_name, salary, manager_id) 
values 
	(1, 'Ava', 8500, NULL),
	(2, 'Bob', 7200, 1),
	(3, 'Cat', 5900, 1),
	(4, 'Dan', 8500, 2)
	;

select * from employees;

--	Employee with the same salary
select 
	e1.employee_name, e1.salary,
	e2.employee_name, e2.salary
from employees as e1
inner join employees as e2
	on e1.salary = e2.salary
where e1.employee_id > e2.employee_id
order by e1.employee_name
;

--	Employees that have a greater salary


--	Employee and their managers
select m.employee_id, m.employee_name, m.manager_id, e.employee_name as manager_name
from employees as m
left join employees as e
on e.employee_id = m.manager_id
;


--	************************
--	ASSIGNMENT 2: Self Joins
--	************************
-- Which products are within 25 cents of each other in terms of unit price?

-- View the products table


-- Join the products table with itself so each candy is paired with a different candy

        
-- Calculate the price difference, do a self join, and then return only price differences under 25 cents