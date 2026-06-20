select * from pizza_sales

--Tota Revenue
select sum(total_price) AS Tota_Revenue
from pizza_sales 

--Average Order Value
select sum(total_price) / count(DISTINCT order_id)  as Average_Orde_Value
from pizza_sales

--Total Pizzas Sold
select sum(quantity) as Total_Pizzas_Sold
from pizza_sales

--Total Orders
select count(DISTINCT order_id) as Total_Orders
from pizza_sales

--Average Pizzas per order
select cast(cast(sum(quantity) as decimal(10,2)) / 
cast(count(DISTINCT order_id) as decimal(10,2)) as decimal(10,2))
from pizza_sales


--Daily trends for order
-- DW used to rturn day of week like monday sunday .....date name 
select DATENAME(DW, order_date) as order_day, count (DISTINCT order_id) as Total_order
from pizza_sales
group by  DATENAME(DW, order_date)


--Monthly trend for total order
select DATENAME(MONTH, order_date) as Month_Name , count(DISTINCT order_id) as Total_order
from pizza_sales
group by DATENAME(MONTH, order_date)
order by Total_order DESC

--Percentage of slaes by pizza category

SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_category


SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
where MONTH(order_date) = 1 -- short by janury
GROUP BY pizza_category

--% of Sales by Pizza Size
SELECT pizza_size, cast(SUM(total_price) as decimal(10,2))  as total_Sales, cast(sum(total_price) * 100 /
(select SUM(total_price) from pizza_sales) as decimal(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
order by pizza_size

-- Total Pizzas Sold by Pizza Category
SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC

--Top 5 Pizzas by Revenue
select top 5 pizza_name, cast(sum(total_price) as decimal(10,2)) as total_revenue from pizza_sales
group by pizza_name
order by total_revenue DESC

--Bottom 5 Pizzas by Revenue
select top 5 pizza_name, cast(sum(total_price) as decimal(10,2)) as total_revenue 
from pizza_sales
group by pizza_name
order by total_revenue ASC

--Top 5 Pizzas by Quantity
select top 5 pizza_name, sum(quantity) as Total_Pizza_Sold 
from pizza_sales
group by pizza_name
order by Total_Pizza_Sold DESC

--Bottom 5 Pizzas by Quantity

select top 5 pizza_name, sum(quantity) as Total_Pizza_Sold 
from pizza_sales
group by pizza_name
order by Total_Pizza_Sold ASC

--Top 5 Pizzas by Total Orders
select top 5 pizza_name, count(distinct order_id) as Total_Pizza_order
from pizza_sales
group by pizza_name
order by Total_Pizza_order DESC



--Bottom 5 Pizzas by Total Orders
select top 5 pizza_name, count(distinct order_id) as Total_Pizza_order
from pizza_sales
group by pizza_name
order by Total_Pizza_order ASC