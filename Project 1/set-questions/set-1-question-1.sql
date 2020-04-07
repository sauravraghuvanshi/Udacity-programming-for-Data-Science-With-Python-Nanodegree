/* Udacity 1st project: Investigate a Relational Database */

/* Question Set # 1 */

/* Question 1:
We want to understand more about the movies that families are watching. 
The following categories are considered family movies: Animation, Children, Classics, Comedy, Family and Music.
Create a query that lists each movie, the film category it is classified in, and the number of times it has been rented out. 
*/

SELECT f.title,
       c.name,
       COUNT(r.rental_id) AS rental_count
  FROM category AS c
       JOIN film_category AS fc
        ON c.category_id = fc.category_id
        AND c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')

       JOIN film AS f
        ON f.film_id = fc.film_id

       JOIN inventory AS i
        ON f.film_id = i.film_id

       JOIN rental AS r
        ON i.inventory_id = r.inventory_id
 GROUP BY 1, 2
 ORDER BY 2, 1;
