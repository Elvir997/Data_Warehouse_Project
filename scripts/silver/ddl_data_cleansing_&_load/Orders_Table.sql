-- Verifying Bronze_crm_orders for Silver Layer  --
-- --------------------------------------------- --


select * from bronze_crm_orders;


-- verifying ranges in order_date_time

select 
order_date_time,
date(order_date_time) as order_date
from bronze_crm_orders
where order_date_time > now();

select 
min(order_date_time) as min_date,
max(order_date_time) as max_date
from bronze_crm_orders;


-- verifiyng dupplicates or unwanted spaces in ORDER_ID

select 
order_id,
count(*) as count_
from bronze_crm_orders
group by order_id
having count(*) != 1;

select
order_id
from bronze_crm_orders
where order_id != trim(order_id);


-- verifiyng unwanted spaces in USER_ID

select
user_id
from bronze_crm_orders
where user_id != trim(user_id);


-- verifying ranges in order_date_time

select 
order_date_time,
date(order_date_time) as order_date
from bronze_crm_orders
where order_date_time > now();

select 
min(order_date_time) as min_date,
max(order_date_time) as max_date
from bronze_crm_orders;


-- Verifying Duplicates or Wrong order_status

select 
order_status, 
count(*)
from bronze_crm_orders
group by order_status;

-- verifyng Negative or 0's numbers in total_amount

select 
total_amount
from bronze_crm_orders
where total_amount <= 0;


-- Capitalizing order_status labels 

select 
order_id,
user_id,
order_date_time,
case 
when order_status = 'processing' then 'Processing'
when order_status = 'completed' then 'Completed'
when order_status = 'cancelled' then 'Cancelled'
when order_status = 'returned' then 'Returned'
else 'Shipped'
end as order_status, 
total_amount 
from bronze_crm_orders;

select 
order_id,
user_id,
order_date_time,
concat(
upper(left(order_status, 1)),
lower(substring(order_status, 2))
) as order_status, 
total_amount 
from bronze_crm_orders;


-- Final Query 


insert into silver_crm_orders (
order_id,
user_id,
order_date,
order_status,
total_amount)

select 
order_id,
user_id,
order_date,
case 
when order_status = 'processing' then 'Processing'
when order_status = 'completed' then 'Completed'
when order_status = 'cancelled' then 'Cancelled'
when order_status = 'returned' then 'Returned'
else 'Shipped'
end as order_status, 
total_amount 
from bronze_crm_orders; 

