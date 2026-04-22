-- Verifying Bronze_crm_users for Silver Layer --
-- ------------------------------------------- --


select * from bronze_crm_users;

-- Checking for user_id lenght, blank spaces and repeated values

select 
char_length(user_id) as user_id_length,
count(*)
from bronze_crm_users
group by user_id_length;

select
user_id
from bronze_crm_users
where user_id != trim(user_id);

select 
user_id,
count(*)
from bronze_crm_users
group by user_id
having count(*) != 1;



-- Checkin for duplicated names and char_length in name

select 
char_length(complete_name) as name_length,
count(*)
from bronze_crm_users
group by name_length;

select 
complete_name,
count(*)
from bronze_crm_users
group by complete_name
having count(*) != 1;

-- NOTE: 531 names are repeated, but the data doesn't provide more information to verify. If the names are duplicates
--       the only comparison I could make was with the email and all the values are different, so they will be leaved 
-- 		 as they are in the dataset.


-- Checking for standarized gender

select
gender,
count(*)
from bronze_crm_users
group by gender;

-- Checking for char_lenght in email, repeated values and valid formats

select 
char_length(email) as email_length,
count(*)
from bronze_crm_users
group by email_length;

select 
email from bronze_crm_users
where email like '%@%';

select 
email,
count(*)
from bronze_crm_users
group by email
having count(*) > 1;


-- Checking for city, blank spaces and count of dif cities 

select 
count(distinct city) as different_cities 
from bronze_crm_users;

select
city
from bronze_crm_users
where city != trim(city);


-- Checking Signup_Date Format and ranges

select
min(signup_date) as min_date,
max(signup_date) as max_date
from bronze_crm_users;

select 
date(signup_date) as date_
from bronze_crm_users
order by date_;



-- Final query 

insert into silver_crm_users (
user_id,
complete_name,
email,
gender,
city,
signup_date)

select 
user_id,
complete_name,
gender,
email, 
city,
signup_date
from bronze_crm_users;