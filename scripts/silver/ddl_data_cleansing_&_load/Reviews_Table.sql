-- Verifying Bronze_crm_reviews for Silver Layer --
-- --------------------------------------------- --


select * from bronze_crm_reviews;


-- Checking for duplicates in review_id

select
review_id,
count(*) as total 
from bronze_crm_reviews
group by review_id
having count(*) > 1;

-- Checking for CHAR_Lenght 

select 
char_length(review_id) as id
from bronze_crm_reviews
order by id;

select 
char_length(order_id) as or_id
from bronze_crm_reviews
order by or_id;

select 
char_length(product_id) as prd_id
from bronze_crm_reviews
order by prd_id;

select 
char_length(user_id) as us_id
from bronze_crm_reviews
order by us_id;


-- Checking for valid ratings

select 
rating,
count(*) as total_per_rating
from bronze_crm_reviews
group by rating
order by rating;

select 
rating
from bronze_crm_reviews
where rating <= 0;

-- Checking for char lenght in review_text and unwanted spaces

select
char_length(review_text) as char_lenght
from bronze_crm_reviews
order by char_lenght desc;

select
min(char_length(review_text)) as min_char,
max(char_length(review_text)) as max_char
from bronze_crm_reviews;

select
review_text
from bronze_crm_reviews
where review_text != trim(review_text);

-- Checking for review_date_time

select 
min(review_date_time) as min_date,
max(review_date_time) as max_date
from bronze_crm_reviews;



select
review_id, 
order_id,
product_id,
user_id, 
rating,
review_text,
review_date_time
from bronze_crm_reviews;


-- Final query 

insert into silver_crm_reviews (
review_id,
order_id,
product_id,
user_id,
rating,
review_text,
review_date)

select
review_id, 
order_id,
product_id,
user_id, 
rating,
review_text,
review_date_time
from bronze_crm_reviews;
