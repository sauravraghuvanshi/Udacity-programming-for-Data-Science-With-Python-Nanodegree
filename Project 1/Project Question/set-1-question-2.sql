/* Udacity 1st project: Investigate a Relational Database */

/* Question Set # 1 */

/* 

Question 2: Now we need to know how the length of rental duration of these family-friendly movies compares to the duration that all movies are rented for. Can you provide a table with the movie titles and divide them into 4 levels (first_quarter, second_quarter, third_quarter, and final_quarter) based on the quartiles (25%, 50%, 75%) of the rental duration for movies across all categories? Make sure to also indicate the category that these family-friendly movies fall into.

Answer: The question is rather ambiguous about how one subset of data (duration of these family-friendly movies) should be compared to another subset of data (duration that all movies are rented for). Below I provide 3 ways to answer the above question.

*/



/* 2.a As the first possible answer, the two groups could be plotted in a Histogram or Box Plot, which would provide a comparison of how the data is distributed in both datasets. */

SELECT *,
       NTILE(4) OVER(ORDER BY t1.rental_duration) AS standard_quartile
  FROM (SELECT f.title, 
			         c.name,
	  		       f.rental_duration
          FROM category AS c
	             JOIN film_category AS fc
	              ON 	c.category_id = fc.category_id 
                AND c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
	
               JOIN film AS f
	              ON f.film_id = fc.film_id
	       ORDER BY 2, 1) t1;

/* 2.b */

SELECT	*,
	      NTILE(4) OVER(ORDER BY t1.rental_duration) AS standard_quartile
  FROM (SELECT f.title, 
			            c.name,
	  		          f.rental_duration
	         FROM category AS c
	              JOIN film_category AS fc
	               ON 	c.category_id = fc.category_id
	              
               JOIN film AS f
	               ON f.film_id = fc.film_id
	       ORDER BY 2, 1) t1;
         
         
/* 2.c As the second possible answer, a Bar Chart or a Pie Chart could provide a comparison of the average rental duration for each film category. */

SELECT t1.title,
		   t1.name,
		   t1.avg_title_duration,
       t1.avg_category_duration,
       NTILE(4) OVER(ORDER BY t1.avg_category_duration) AS standard_quartile
 FROM  (SELECT f.title, 
               c.name, 
               AVG(f.rental_duration) OVER (PARTITION BY f.title) AS avg_title_duration, 
               AVG(f.rental_duration) OVER (PARTITION BY c.name) AS avg_category_duration
          FROM category AS c
               JOIN film_category AS fc
                ON c.category_id = fc.category_id
	
               JOIN film f
                ON f.film_id = fc.film_id
         ORDER BY 4, 3) t1
 ORDER BY 4, 5;

/* 2.d As a third possible answer, a Histogram could provide a comparison of the average rental duration for each film. */

SELECT t1.title,
       avg_category_durationt1.name,
       AVG(t1.avg_category_duration),
       NTILE(4) OVER(ORDER BY t1.avg_category_duration) AS standard_quartile
  FROM (SELECT f.title, 
               c.name, 
               AVG(f.rental_duration) OVER (PARTITION BY f.title) AS avg_title_duration, 
               AVG(f.rental_duration) OVER (PARTITION BY c.name) AS avg_category_duration
          FROM category c
               JOIN film_category AS fc
                ON c.category_id = fc.category_id
               
               JOIN film AS f
                ON f.film_id = fc.film_id
         ORDER BY 4, 3) t1
  GROUP BY 1, 2, t1.avg_category_duration
  ORDER BY 3, 1;
