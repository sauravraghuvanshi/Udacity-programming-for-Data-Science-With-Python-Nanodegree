/* Udacity 1st project: Investigate a Relational Database */

/* Question Set # 2 */

/*
Question 2
We would like to know who were our top 10 paying customers, how many payments they made on a monthly basis during 2007, 
and what was the amount of the monthly payments. Can you write a query to capture the customer name, month and year of 
payment, and total payment amount for each month by these top 10 paying customers?
*/

WITH t1 AS (SELECT (first_name || ' ' || last_name) AS name, 
                   c.customer_id, 
                   p.amount, 
                   p.payment_date
              FROM customer AS c
                   JOIN payment AS p
                    ON c.customer_id = p.customer_id),

     t2 AS (SELECT t1.customer_id
              FROM t1
             GROUP BY 1
             ORDER BY SUM(t1.amount) DESC
             LIMIT 10)

SELECT t1.name,
       DATE_PART('month', t1.payment_date) AS payment_month, 
       DATE_PART('year', t1.payment_date) AS payment_year,
       COUNT (*),
       SUM(t1.amount)
  FROM t1
       JOIN t2
        ON t1.customer_id = t2.customer_id
 WHERE t1.payment_date BETWEEN '20070101' AND '20080101'
 GROUP BY 1, 2, 3;
