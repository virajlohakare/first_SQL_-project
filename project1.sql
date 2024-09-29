create database project;
use project;
      
create table  retail_sales(
transactions_id	int primary key,
sale_date date,
sale_time time,
customer_id	int,
gender	varchar(5),
age	int,
category varchar(15),	
quantiy	int,
price_per_unit float,
cogs float,	
total_sale float
);


select * from retail_sales ;

select count(*) from retail_sales;
                            -- data cleaning process--


-- knowing the null value data form datasate and removing data _--


select * from retail_sales  
where 
transactions_id is null
or
 sale_date is null
or
 sale_time is null
or
 customer_id is null
or
 gender is null
or
 age is null
or
 category is null
or
 quantiy is null
or
 price_per_unit is null
or
 cogs is null
or
total_sale is null;


-- for deleting null form datasate--


delete from retail_sales
where 
transactions_id is null
or
 sale_date is null
or
 sale_time is null
or
 customer_id is null
or
 gender is null
or
 age is null
or
 category is null
or
 quantiy is null
or
 price_per_unit is null
or
 cogs is null
or
total_sale is null;

-- data exploration --
-- how many sales we have now --?

select count(*) as total_sales from retail_sales;

-- how many unique  customer we have --

select count(distinct customer_id) as total_sales from retail_sales;

-- how many unique category we have --
select count(distinct category) as category from retail_sales;

select distinct category from retail_sales;

-- data analysis and bussiness problems--

-- 1 write 	a sql quary  to retrive  all cloumn for sales made on '2022-11-05'

select * from retail_sales where sale_date ='2022-11-05';


-- 2 write a sql quary to retrive all the transaction  where the category is clothing and the quantity  sold i more than  10  in the month of nov-2022

select *from retail_sales  
where category ="clothing " 
and date_format( sale_date,'yyyy') ='2022'
and quantiy =4;


-- 3 write a sql quary to calculated the total sales for each catagery--

 SELECT category, 
       SUM(total_sale) AS net_sale, 
       COUNT(*) AS total_order 
FROM retail_sales 
GROUP BY category;


-- 4 write a sql quary  to find the average age  of customer who purchsee items  from  a beauty category ---


select round(avg(age),2)  from retail_sales where category ='beauty';

-- 5 write a sql quay  to find all transaction  where total sales is greater than thousand 1000---


select transactions_id,total_sale from retail_sales  where total_sale >1000;

-- 6 find the total number of transation  ( transaction_id) made by each gender by each category--


select count(gender) from retail_sales where gender ='male';


select 
     category, gender ,count(*)  as total_ternf
     from retail_sales 
     group by 
     category,gender
     order by 1;
     
-- 7 calculated the average sales  for each month. find out the best selling montth in year---





-- 8 write a quary to find out  top5  customer  based  on the highest  total sales----



SELECT  
      customer_id,
      SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC ;


-- 9 find unique costomer who purchare items  from each catagory---


select 
      count(distinct customer_id ) as uniquecustomer,
       category
from retail_sales
group by category;


-- 10 create each shift   and number of order ( ex moring <=12, afternoon between 12 & 17, evening >17)---

with hourly_sale
as
(
SELECT *,
    CASE 
        WHEN HOUR(sale_time) < 12 THEN 'morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'afternoon'
        ELSE 'evening'
    END AS shift
FROM retail_sales
)
select
     shift,
     count(*) as total_orders
from hourly_sale
group by shift;     

















