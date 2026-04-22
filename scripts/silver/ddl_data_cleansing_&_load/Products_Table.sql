-- Verifying Bronze_erp_products for Silver Layer --
-- ---------------------------------------------- --

select * from bronze_erp_products;


-- Checking duplicates and formats in product_id 

select
count(product_id)
from bronze_erp_products
group by product_id
having count(*) > 1;

select 
product_id
from bronze_erp_products
where product_id != trim(product_id);

select 
product_id
from bronze_erp_products
where product_id like 'P%';


-- Checking duplicates and format in product_name

select 
product_name
from bronze_erp_products
where product_name != trim(product_name);

select 
count(distinct product_name) as total_products
from bronze_erp_products;
-- OBSERVATION: In table are 2,000 products ID, but we only have 1848 different names. 


select 
product_name,
category,
count(*)
from bronze_erp_products
group by product_name, category
having count(*) > 1;
-- OBSERVATION: Only 17 products have the same name and category.

select 
product_name, brand,
count(*)
from bronze_erp_products
group by product_name, brand
having count(*) > 1;
-- OBSERVATION: Only 139 products have the same name and brand.


select 
product_name, 
category, 
brand, 
price,
count(*)
from bronze_erp_products
group by product_name, category, brand, price
having count(*) > 1;
-- OBSERVATION: None product name matches with the same name, category, brand and price.
--              So the products will be left as they are. 


SELECT 
    product_name,
    COUNT(*) as count_products,
    MIN(price) as min_price,
    MAX(price) as max_price,
    avg(price) as avg_price
FROM bronze_erp_products
GROUP BY product_name
HAVING COUNT(*) > 1;



-- checking format in category

select distinct
category
from bronze_erp_products
order by category;

-- chekcing for brand

select distinct
brand
from bronze_erp_products
order by brand;

select
brand
from bronze_erp_products
where brand is null or brand = ' '
;

-- Checking for price

select 
price 
from bronze_erp_products
where price <= 0;

-- checking for rating 

select 
rating
from bronze_erp_products
where rating not between 0 and 5;

-- Optional query for product_name without brand

select 
product_id,
product_name,
trim(replace(product_name, brand, '')) as new_name,
brand,
price,
rating
from bronze_erp_products
;

SELECT *
FROM bronze_erp_products
WHERE TRIM(LOWER(product_name)) = TRIM(LOWER(brand));

SELECT *
FROM bronze_erp_products
WHERE LOWER(product_name) LIKE CONCAT('%', LOWER(brand), '%');


-- final query 

insert into silver_erp_products (
product_id,
product_name,
category,
brand,
price,
rating)

select 
product_id,
product_name,
category,
brand,
price,
rating
from bronze_erp_products;