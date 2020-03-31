#From the order_items table, find the price of the highest priced order and lowest price order.
select max(price), min(price)
from olist.order_items
;

#From the order_items table, what is range of the shipping_limit_date of the orders?
select  min(shipping_limit_date), max(shipping_limit_date)
from olist.order_items
;

#From the customers table, find the states with the greatest number of customers.
select customer_state, count(distinct customer_unique_id) as number_of_customers
from customers
group by customer_state
order by number_of_customers desc
limit 3
;

 #From the customers table, within the state with the greatest number of customers, 
 #find the cities with the greatest number of customers.
select customer_state, customer_city, count(customer_city) as nb_customer_city
from customers
where customer_state='SP'
group by customer_city
order by nb_customer_city desc
limit 3
;

#From the closed_deals table, how many distinct business segments are there (not including null)?
select count(distinct business_segment)
from closed_deals;

#From the closed_deals table, sum the declared_monthly_revenue for duplicate row values 
#in business_segment and find the 3 business segments 
#with the highest declared monthly revenue (of those that declared revenue).

select business_segment, sum(declared_monthly_revenue) as total_revenue
from closed_deals
group by business_segment
order by total_revenue desc
limit 3;

# From the order_reviews table, find the total number of distinct review score values
select count(distinct review_score)
from order_reviews;

#In the order_reviews table, create a new column with a description that corresponds 
#to each number category for each review score from 1 - 5, 
#then find the review score and category occurring most frequently in the table.

select review_score, product_category_name, count(review_score), count(product_category_name)
from order_reviews
inner join order_items
on order_reviews.order_id = order_items.order_id
inner join products
on order_items.product_id=products.product_id
group by review_score, product_category_name
order by count(review_score) desc, count(product_category_name) desc;

# From the order_reviews table, find the review value occurring most frequently 
# and how many times it occurs.
select review_score, count(review_score)
from order_reviews
group by review_score
order by count(review_score) desc
limit 1