-- ------------- Creating Gold DIMENSION Views ------------ --
-- -------------------------------------------------------- --

use e_commerce;



-- Gold Dim view for Products 

create view gold_dim_products as

(select
ROW_NUMBER() OVER (ORDER BY product_id) AS product_key,
product_id,
product_name,
category,
brand,
price,
rating 
from silver_erp_products);

select * from gold_dim_products;


-- Gold Dim view for Users

create view gold_dim_users as 

(select
row_number() over(order by user_id) as user_key,
user_id,
complete_name,
email,
gender,
city,
signup_date
from silver_crm_users);

select * from gold_dim_users;

