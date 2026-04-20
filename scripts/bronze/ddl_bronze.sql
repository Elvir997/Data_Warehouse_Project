

-- DDL Scripts: Create bronze tables

-- Purpose: These script creates tables in bronze layer, defining the structure of each table. 


create database e_commerce;

use e_commerce;

drop table if exists bronze_erp_events;
create table bronze_erp_events (
event_id varchar(50),
user_id varchar(50), 
product_id varchar(50),
event_type varchar(50),
event_date_time DATETIME);

drop table if exists bronze_crm_sales;
create table bronze_crm_sales (
order_item varchar(50),
order_id varchar(50),
product_id varchar(50), 
user_id varchar(50),
quantity int,
item_price int,
item_total int
);

drop table if exists bronze_crm_orders;
create table bronze_crm_orders (
order_id varchar(50),
user_id varchar(50),
order_date DATETIME, 
order_status varchar(50),
total_amount int
);

drop table if exists bronze_erp_products;
create table bronze_erp_products (
product_id varchar(50),
product_name varchar(50),
category varchar(50), 
brand varchar(50),
price int,
rating int
);

drop table if exists bronze_crm_reviews;
create table bronze_crm_reviews (
review_id varchar(50),
order_id varchar(50),
product_id varchar(50), 
user_id varchar(50),
rating int,
review_text varchar(100),
review_date DATETIME
);


drop table if exists bronze_crm_users;
create table bronze_crm_users (
user_id varchar(50),
complete_name varchar(50),
gender varchar(50),
email varchar(50), 
city varchar(50),
signup_date DATE
);
