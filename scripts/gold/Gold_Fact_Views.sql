-- ------------- Creating Gold FACT Views ------------ --
-- --------------------------------------------------- --

use e_commerce;



-- Fact table from Sales

create view gold_fact_sales as

(select 
s.order_item as order_item_id,
s.order_id,
u.user_key,
p.product_key,
s.quantity,
s.item_price,
s.item_total,
o.total_amount as total_per_order,
date(o.order_date) as order_date,
time(o.order_date) as order_hour,
o.order_status
from silver_crm_sales s
left join silver_crm_orders o
on s.order_id = o.order_id
left join gold_dim_products p
on s.product_id = p.product_id
left join gold_dim_users u
on s.user_id = u.user_id
)
;

select * from gold_fact_sales;



-- Fact table from events 

select * from silver_erp_events;

create view gold_fact_events as

(select 
e.event_id,
u.user_key,
p.product_key,
e.event_type,
date(e.event_date_time) as event_date,
time(e.event_date_time) as event_time
from silver_erp_events e
left join gold_dim_products p
on e.product_id = p.product_id
left join gold_dim_users u
on e.user_id = u.user_id)
;

select * from gold_fact_events;



-- fact Table from reviews.

create view gold_fact_reviews as 

(select 
r.review_id, 
s.order_item,
r.order_id,
p.product_key,
u.user_key,
r.rating,
r.review_text,
date(r.review_date_time) as review_date,
time(r.review_date_time) review_time
from bronze_crm_reviews r
left join silver_crm_sales s 
on r.order_id = s.order_id
left join gold_dim_products p
on r.product_id = p.product_id
left join gold_dim_users u
on r.user_id = u.user_id)
; 

select * from gold_fact_reviews