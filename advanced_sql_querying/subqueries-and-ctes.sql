
--	**********************
--	SUBQUERY BASICS
--	**********************

--	A subquery is query nested within a main query, and is typically used for solving a problem in multiple steps.

--	EXAMPLE
--	Return all countries that have an above average happiness score

--	1. Calculate the avrage score
	select avg(hs.happiness_score) as avg_happiness_score
	from happiness_scores hs 
	;

--	2. Return all rows qith a happiness score greater than the average score
	select *
	from happiness_scores hs 
	where hs.happiness_score > (
									select avg(happiness_score) as avg_happiness_score
									from happiness_scores
								)
	;


--	Subqueries can occur in multiple places within a query:
		1. Calculate in the select clause
		2. as part of a join in the from clause
		3. Filtering in the where and having clause 

--	1. Subqueries in the SELECT clause

--	Average happiness score

--	Happiness score deviation from the average

--	2. Subqueries in the FROM clause

--	Average happiness score for each country


-- /* Return a country's happiness score for the year as well as
--	the average happiness score for the country across years */

--	View one country


--	3. Multiple subqueries

