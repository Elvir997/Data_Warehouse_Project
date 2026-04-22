-- Verifying Bronze_crm_sales for Silver Layer --
-- ------------------------------------------- --


select * from bronze_crm_sales;

-- Checking for duplicates in order_item o blank spaces

select 
order_item,
count(*) 
from bronze_crm_sales
group by order_item
having count(*) > 1;

select 
order_item
from bronze_crm_sales
where order_item != trim(order_item);


-- Checking for blank spaces in order_id, product_id, user_id

select
user_id
from bronze_crm_sales
where user_id != trim(user_id);

select
product_id
from bronze_crm_sales
where product_id != trim(product_id);

select
order_id
from bronze_crm_sales
where order_id != trim(order_id);

-- checking for 0's or Negative values 

select 
quantity
from bronze_crm_sales
where quantity <= 0;

select 
item_price
from bronze_crm_sales
where item_price <= 0;

select 
item_total
from bronze_crm_sales
where item_total <= 0;

-- Verfying that item_totals are correct 

select 
item_total
from bronze_crm_sales
where item_total != (item_price * quantity);


select 
item_total, 
item_total_2, 
item_total - item_total_2 as difference
from (
select 
item_total,
quantity * item_price as item_total_2
from bronze_crm_sales) t
where item_total != item_total_2
order by difference;

-- Final Query 

insert into silver_crm_sales (
order_item,
order_id,
product_id,
user_id,
quantity,
item_price,
item_total)

select
order_item, 
order_id,
product_id, 
user_id,
quantity,
item_price,
item_total
from bronze_crm_sales