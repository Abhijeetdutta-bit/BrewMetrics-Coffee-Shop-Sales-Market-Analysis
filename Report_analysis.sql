-- Report and data analysis
-- Q.1 Coffee Consumers Count
-- How many people in each city are estimated to consume coffee, given that 25% of the population does?
select city_name, 
round((population*0.25)/1000000,2) as population_consume_coffee_in_million,
city_rank 
from city
order by 2 desc;

-- Q.2 Total Revenue from Coffee Sales
-- What is the total revenue generated from coffee sales across all cities in the last quarter of 2023?
select Sum(total) as total_revenue 
from sales
where year(sale_date)=2023 And quarter(sale_date) =4 ;

select Sum(total) as city_revenue, ct.city_name
from sales as s
join customers as c
on s.customer_id=c.customer_id 
join city as ct
on c.city_id=ct.city_id
where year(s.sale_date)=2023 And quarter(s.sale_date) =4
group by ct.city_name 
order by 1 Desc ;

-- Q.3 Sales Count for Each Product
-- How many units of each coffee product have been sold?

select count(s.product_id) as total_units , p.product_id, p.product_name
from products as p
left join sales as s
on p.product_id=s.product_id
group by p.product_id
order by 1 desc ;

-- Q.4
-- Average Sales Amount per City
-- What is the average sales amount per customer in each city?
-- to find city and their total sale
-- number of customer in each of these city

select sum(s.total) as Total_sales , ct.city_name, count(distinct c.customer_id) as total_customers,
	round(sum(s.total)/count(distinct c.customer_id),2) as avg_customer_sales
from sales as s
join customers as c
on s.customer_id=c.customer_id
join city as ct
on c.city_id=ct.city_id
group by ct.city_name 
order by 4 desc;

-- Q.5 City Population and Coffee Consumers (25%)
-- Provide a list of cities along with their populations and estimated coffee consumers.
-- return city_name, total current cx, estimated coffee consumers (25%)
with city_table as
(select ct.city_name, 
round((population*0.25)/1000000,2) as coffee_consumer_in_million,
city_rank 
from city as ct
order by 2 desc)
, customer_table as
(select ct.city_name , count(distinct s.customer_id) as total_customer from sales as s
 join customers as c
 on s.customer_id=c.customer_id
 join city as ct
 on c.city_id=ct.city_id
 group by city_name
 )
 select cit.city_name , cut.total_customer, cit.coffee_consumer_in_million
 from city_table as cit
 join customer_table as cut
 on cit.city_name=cut.city_name ;

-- Q6 Top Selling Products by City
-- What are the top 3 selling products in each city based on sales volume?

select * from 
(select p.product_id, p.product_name,ct.city_name, 
count(s.product_id) as number_of_products, 
dense_rank() over(partition by city_name order by count(s.sale_id) desc ) as product_rank
from sales as s
join products as p
on s.product_id=p.product_id 
join customers as c
on c.customer_id=s.customer_id
join city as ct
on c.city_id = ct.city_id
group by p.product_name,p.product_id, ct.city_name) as main_table
where main_table.product_rank <= 3;

-- Q.7 Customer Segmentation by City
-- How many unique customers are there in each city who have purchased coffee products?

select count(distinct c.customer_id) as total_customers,ct.city_name 
from customers as c
join city as ct
on c.city_id=ct.city_id
join sales as s
on c.customer_id=s.customer_id
join products as p
on s.product_id=p.product_id
where p.product_id <= 14
group by ct.city_name
order by total_customers desc ;

-- -- Q.8 Average Sale vs Rent
-- Find each city and their average sale per customer and avg rent per customer
with avg_sales  as
(select sum(s.total) as Total_sales ,
		ct.city_name, 
        count(distinct c.customer_id) as total_customers,
		round(sum(s.total)/count(distinct c.customer_id),2) as avg_customer_sales
from sales as s
join customers as c
on s.customer_id=c.customer_id
join city as ct
on c.city_id=ct.city_id
group by ct.city_name )
, rent_table as
(select city_name , estimated_rent from city)

select rt.city_name, rt.estimated_rent, avs.total_customers, avs.avg_customer_sales ,  
		round(rt.estimated_rent / avs.total_customers , 2) as avg_rent
from rent_table as rt 
join avg_sales as avs
on rt.city_name=avs.city_name
order by 4 desc ; 

-- Q.9 Monthly Sales Growth
-- Sales growth rate: Calculate the percentage growth (or decline) in sales over different time periods (monthly)
-- (by each city)
with revenue_table as
(select  sum(s.total) as total_sale ,ct.city_name , year(s.sale_date) as years , month(s.sale_date) as months from sales as s
join customers as c
on c.customer_id=s.customer_id
join city as ct
on ct.city_id=c.city_id 
group by 2,3,4
order by 2, 3,4
),
growth_table as
(select city_name , years , months, total_sale as total_sale_per_month ,   
		lag(total_sale,1) over(partition by city_name order by years,months) as last_month_sales
from revenue_table 
)
select city_name , years , months, total_sale_per_month , last_month_sales, 
		round(((total_sale_per_month - last_month_sales)/last_month_sales)*100,2) as growth_rate 
from growth_table
 where last_month_sales is not null ;

-- Q.10 Market Potential Analysis
-- Identify top 3 city based on highest sales, return city name, total sale, total rent, total customers, estimated coffee consumer
 
with avg_sales  as
(select sum(s.total) as total_sales ,
		ct.city_name, 
        count(distinct c.customer_id) as total_customers,
		round(sum(s.total)/count(distinct c.customer_id),2) as avg_customer_sales
from sales as s
join customers as c
on s.customer_id=c.customer_id
join city as ct
on c.city_id=ct.city_id
group by ct.city_name ),
rent_table as
(select city_name , estimated_rent from city),
estimate_coffee_con as 
(select city_name, 
round((population*0.25)/1000000,2) as population_consume_coffee_in_million,
city_rank 
from city
order by 2 desc
)

select rt.city_name,avs.total_sales ,  rt.estimated_rent, avs.total_customers, avs.avg_customer_sales ,  
		round(rt.estimated_rent / avs.total_customers , 2) as avg_rent ,
        population_consume_coffee_in_million
from rent_table as rt 
join avg_sales as avs
on rt.city_name=avs.city_name
join estimate_coffee_con as est
on rt.city_name=est.city_name
order by 2 desc ;

/* 
My recommendation 
city1 (Pune) :- 1. Highest sales: ₹12.58 lakh - strongest proven demand.
				2. 52 customers with ₹24.2K sales/customer - highest customer monetization. 
				3. ₹15,300 rent - sales-to-rent = 82x , making it highly cost-efficient. 
city2 (Jaipur) :- 1.69 customers - highest customer base among the cities.
  				  2.₹10,800 rent - lowest rent, reducing expansion cost. 
                  3.₹8.03 lakh sales  sales/rent = 74x, showing strong cost efficiency.
city3 (Delhi) :- 1.7.75M coffee consumers - by far the largest potential customer pool.
				 2.68 customers - second-highest customer base, showing existing demand.
                 3.₹7.50 lakh sales despite the huge market - indicates significant room for growth by increasing market penetration.
*/








