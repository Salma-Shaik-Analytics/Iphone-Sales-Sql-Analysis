Create database Iphone_2025;
use Iphone_2025;
show tables;
select * from iphone_sales;

-- Total Sales amount
select sum(quantity * price) As Total_sales
from iphone_sales;

-- Total number of orders
select count(Order_ID) AS Total_Orders
from iphone_sales;

-- Average sales per order
select avg(quantity * price) As Av_sales
from iphone_sales;

-- Total quantity of iphones Sold
select sum(quantity) As Tot_quan_sold
from iphone_sales;


select * from iphone_sales;

-- Distinct iphone models available in the dataset
select distinct(iphone_model)
from iphone_sales;

-- Total sales from each model
select iphone_model , sum(quantity * price) AS Tot_sal_each_model
from iphone_sales
group by iphone_model
order by Tot_sal_each_model desc;

-- Find the total sales by country
select country, sum(quantity * price) As Tot_sal_country
from iphone_sales
group by country
order by Tot_sal_country desc;

select * from iphone_sales;

-- Total quantity sold for each storage type
select storage , sum(quantity) As quan_sold_each_storage
from iphone_sales
group by storage
order by quan_sold_each_storage desc;

-- Total Number of orders for each payment method
select payment_method, count(order_id) As Num_of_orders
from iphone_sales
group by payment_method
order by Num_of_orders desc;

-- Display the top 5 countries by total sales
select country, sum(quantity * price) As Tot_sal
from iphone_sales
group by country
order by Tot_sal desc
limit 5;

select * from iphone_sales;

-- Top-Selling iphone model (by quantity)
select iphone_model, sum(quantity) As Tot_quan
from iphone_sales
group by iphone_model
order by Tot_quan desc
limit 1;

-- least-selling iphone model (by quantity)
select iphone_model, sum(quantity) As Total_quantity
from iphone_sales
group by iphone_model
order by Total_quantity Asc
limit 1;

select * from iphone_sales;

-- Highest single order value
select max(quantity * price) As High_ord_value
from iphone_sales;

-- Country with maximum no.of orders
select Country, count(order_ID) As Tot_ord
from iphone_sales
group by country
order by Tot_ord desc
limit 1;

-- Total sales for each month
select monthname(sale_date) As Month_Name , month(Sale_date) As Month_Num,
sum(quantity * price) As Tot_sales
from iphone_sales
group by monthname(sale_date), month(Sale_date)
order by Tot_sales desc;

select * from iphone_sales;

-- Monthly sales growth Percentage
with MonthlySales As
(
select monthname(Sale_date) As Mon_name,
month(Sale_date) As Mon_Num,
sum(quantity * price) As Total_Sal
from iphone_sales
group by monthname(Sale_date), month(Sale_date)
)
select Mon_name,
Total_sal,
round(
(
(Total_sal- LAG(Total_sal)over(order by Mon_num))
/
LAG(Total_sal)over(order by Mon_num)
) * 100
) As Growth_Percentage
from MonthlySales
order by Mon_num;

select * from iphone_sales;

-- Top 3 iphone models on each country
with ModelSales As
(
select Country, 
iphone_model,
sum(quantity) As Tot_qty,
row_number() over 
(
partition by country 
order by sum(quantity) desc
) As RN
from iphone_sales
group by country, iphone_model
)
select * from ModelSales
where rn<= 3;

select * from iphone_sales;

-- Customers/Orders above Average Sales Amount
select order_id, customer_name, 
quantity * price As Aveg_Sal_amount
from iphone_sales
where (quantity * price)>
(select avg(quantity * price) 
from iphone_sales
);

select * from iphone_sales;

-- Rank iphone models based on total sales using window functions
select iphone_model,
sum(quantity * price) As Tot_sal,
rank() over 
(
order by sum(quantity * price) desc
) As Sales_Rank
from iphone_sales
group by iphone_model;

select * from iphone_sales;

-- Second highest value
select max(quantity * price) As Second_highest_value
from iphone_sales
where (quantity * price)<
(select max(quantity * price) 
from iphone_sales
);




