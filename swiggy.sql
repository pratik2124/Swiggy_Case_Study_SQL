use swiggy_sql 


Q1.) How Many Restaurants Have a Rating Greater Than 4.5?

--->  select count(distinct restaurant_name) as high_rated_restaurants
from swiggy
where rating>4.5;	
       
Q2.) Which is the Top 1 City With The Highest Number of Restaurants?

---->  SELECT city, COUNT(DISTINCT restaurant_name) 
as restaurant_count from swiggy
group by city
order by restaurant_count DESC
LIMIT 1;

Q3.) How Many Restaurants Have The Word "Pizza" in Their Name?

---->  SELECT count(distinct restaurant_name) as pizza_restaurants 
	   FROM swiggy
       WHERE restaurant_name LIKE '%Pizza%';
        
Q4.) What is the Most Common Cuisine Among the Restaurants in the Datasets?	

---->   SELECT cuisine, count(*) as cuisine_count
		from swiggy 
        group by cuisine
        order by cuisine_count desc 
        limit 1;
        
Q5.) What is the Average Rating of Restaurants in Each City?

---->  SELECT City, avg(rating) as average_rating
	   from swiggy
	   GROUP BY City;
        
Q6.) What is the Highest Price of Item Under the 'Recommended' Menu Category For Each Restaurant?

---->  SELECT distinct(restaurant_name), menu_category, MAX(price) as highest_price 
		from swiggy 
        where menu_category = 'Recommended'
        group by restaurant_name, menu_category;
        
Q7.) Find the Top 5 Most Expensive Restaurants That Offer Cuisine Other Than Indian Cuisine.

---->  SELECT distinct(restaurant_name), cost_per_person
		from swiggy where cuisine <> 'Indian'
        order by cost_per_person desc
        limit 5;
        
Q8.) Find the Restaurants that have an Average Cost which is Higher Than the Total Average Cost of all Restaurants Together.

---->  SELECT distinct restaurant_name, cost_per_person 
		from swiggy where cost_per_person > (
        select avg(cost_per_person) from swiggy);
        
Q9.) Retrieve the Details of Restaurants that have the same Name But are Located in Different Cities

---->  SELECT distinct t1.restaurant_name, t1.city,t2.city		
	   from swiggy t1 join swiggy t2 
	   on t1.restaurant_name=t2.restaurant_name and 
	   t1.city <> t2.city; 
       
Q10.) Which Restaurant Offers the most number of items in the 'Main Course' Category?

---->  SELECT DISTINCT(restaurant_name), menu_category, COUNT(item) as no_of_items
	   from swiggy
       where menu_category = 'Main Course'
       group by restaurant_name, menu_category
       order by no_of_items desc 
       limit 1;
       
Q11.) List the names of restaurants that are 100% Vegetarian in Alphabetical Order Of Restaurant Name.

---->  SELECT DISTINCT(restaurant_name), (COUNT(case when veg_or_nonveg = 'Veg' then 1 end) * 100/count(*))
	   as vegetarian_percentage
       from swiggy
       group by restaurant_name 
       having vegetarian_percentage = 100.00
       order by restaurant_name;
       
Q12.) Which is the Restaurant Providing the Lowest Average Price for all items?

---->  SELECT distinct(restaurant_name), avg(price) as average_price
	   from swiggy
       group by restaurant_name
       Order by average_price
       limit 1;
       
Q13.) Which Top 5 Restaurant Offers Highest Number of Categories?

---->  SELECT DISTINCT(restaurant_name),
		COUNT(distinct menu_category) as no_of_categories 
		FROM swiggy
        group by restaurant_name
        order BY no_of_categories DESC 
        LIMIT 5;
        
	Q14.) Which Restaurant Provides the Highest Percentage of Non-Vegetarian Food?
    
    ---->  SELECT DISTINCT(restaurant_name), (count(case when veg_or_nonveg = 'Non-Veg' then 1 end) *100
		   /count(*)) as nonvegetarian_percentage 
           from swiggy 
           group by restaurant_name 
           order by nonvegetarian_percentage desc limit 1;
           
	Q15.) Calculate the Rating Rank for Each Restaurant Within its City
    
    ---->  WITH RatingRankByCity AS (
			SELECT distinct(restaurant_name),
            city, 
            rating,
            DENSE_RANK() OVER (PARTITION BY City ORDER BY rating DESC) AS rating_rank
            FROM swiggy
		)
        SELECT 
				restaurant_name,
                city,
                rating,
                rating_rank
			FROM RatingRankByCity
            WHERE rating_rank = 1;
            
Q16.) Determine the Most Expensive and Least Expensive Cities for Dining

---->  WITH CityExpense AS (
		SELECT city,
        MAX(cost_per_person) AS most_expensive,
        MIN(cost_per_person) AS least_expensive
	FROM swiggy
    GROUP BY city
)
	SELECT 
    city,
    most_expensive,
    least_expensive 
    FROM CityExpense
    ORDER BY most_expensive DESC;