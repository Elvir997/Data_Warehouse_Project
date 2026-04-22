




CALL Silver_Layer_tables()

DELIMITER $$
create procedure Silver_Layer_tables()

BEGIN


drop table if exists silver_erp_events;
create table silver_erp_events (
event_id varchar(50),
user_id varchar(50), 
product_id varchar(50),
event_type varchar(50),
event_date_time DATETIME,
dwh_create_date DATETIME DEFAULT now()
);

drop table if exists silver_crm_sales;
create table silver_crm_sales (
order_item varchar(50),
order_id varchar(50),
product_id varchar(50), 
user_id varchar(50),
quantity int,
item_price decimal(10, 2),
item_total decimal(10, 2),
dwh_create_date DATETIME DEFAULT now()
);

drop table if exists silver_crm_orders;
create table silver_crm_orders (
order_id varchar(50),
user_id varchar(50),
order_date DATETIME, 
order_status varchar(50),
total_amount decimal(10, 2),
dwh_create_date DATETIME DEFAULT now()
);

drop table if exists silver_erp_products;
create table silver_erp_products (
product_id varchar(50),
product_name varchar(50),
category varchar(50), 
brand varchar(50),
price decimal(10, 2),
rating decimal(10, 2),
dwh_create_date DATETIME DEFAULT now()
);

drop table if exists silver_crm_reviews;
create table silver_crm_reviews (
review_id varchar(50),
order_id varchar(50),
product_id varchar(50), 
user_id varchar(50),
rating int,
review_text varchar(100),
review_date DATETIME,
dwh_create_date DATETIME DEFAULT now()
);


drop table if exists silver_crm_users;
create table silver_crm_users (
user_id varchar(50),
complete_name varchar(50),
gender varchar(50),
email varchar(50), 
city varchar(50),
signup_date DATE,
dwh_create_date DATETIME DEFAULT now()
);

END $$

DELIMITER ;
