/* Udacity 1st project: Investigate a Relational Database */

/* Question Set # 2 */

/*
Question 1:
We want to find out how the two stores compare in their count of rental orders during every month for all the years 
we have data for. Write a query that returns the store ID for the store, the year and month and the number of rental
orders each store has fulfilled for that month. Your table should include a column for each of the following: year, month, 
store ID and count of rental orders fulfilled during that month.
*/

SELECT DATE_PART('month', r1.rental_date) AS rental_month, 
       DATE_PART('year', r1.rental_date) AS rental_year,
       ('Store ' || s1.store_id) AS store,
       COUNT(*)
  FROM store AS s1
       JOIN staff AS s2
        ON s1.store_id = s2.store_id
		
       JOIN rental r1
        ON s2.staff_id = r1.staff_id
 GROUP BY 1, 2, 3
 ORDER BY 2, 1;
