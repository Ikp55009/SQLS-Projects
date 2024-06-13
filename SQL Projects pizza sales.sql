create database Pizza_sales;

use pizza_sales;

select * from [pizza_sales-_6_];

--total revenue---

SELECT SUM(total_price) AS Total_Revenue FROM [pizza_sales-_6_];

---average order value ---

select (SUM(total_price) / COUNT(distinct order_id)) as avg_order_value from [pizza_sales-_6_]

---total pizza sold---

select COUNT(quantity) as total_pizza_sold from [pizza_sales-_6_]

---total order---

select COUNT(order_id) as total_sales from [pizza_sales-_6_]

--- Average Pizzas Per Order---
select CAST(CAST(sum(quantity) as decimal(10,2)) /
CAST(count(distinct order_id) as decimal (10,2)) as decimal(10,2))
as avg_pizza_per_order from [pizza_sales-_6_]

---daily trend for total order---

select datename(dw,order_date) as order_day,COUNT(distinct order_id) as total_orders
from [pizza_sales-_6_]
group by datename(DW,order_date)

---MONTHLY TREND FOR TOTAL ORDER---

SELECT DATENAME(MONTH,ORDER_DATE) AS MONTH_NAME,COUNT(DISTINCT ORDER_ID) AS TOTAL_ORDERS
FROM [pizza_sales-_6_]
GROUP BY DATENAME(MONTH,order_date)

---PER OF SALES BY PIZZA CATEGORY--

select pizza_category, cast(sum(total_price) as decimal(10,2)) as total_revenue,
CAST(sum(total_price)*100 / (select sum(total_price) from [pizza_sales-_6_]) as decimal(10,2)) as pct 
from [pizza_sales-_6_]
group by pizza_category

--- % of Sales by Pizza Size---(E)---

select pizza_size, CAST(sum(total_price) as dec(10,2)) as total_revenue,
CAST(sum(total_price) * 100 / ( select sum(total_price) from [pizza_sales-_6_] as decimal(10,2)) as PCT
from [pizza_sales-_6_]
group by pizza_size
order by pizza_size


---total pizza sold by pizza catogery---

select pizza_category, sum(quantity) as total_quantity_sold
from [pizza_sales-_6_]
where Month(order_date) = 2
group by pizza_category
order by total_quantity_sold desc

---G. Top 5 Pizzas by Revenue---

select top 5 pizza_name, sum(total_price) as total_revenue
from [pizza_sales-_6_]
group by pizza_name
order by total_revenue desc

--H. Bottom 5 Pizzas by Revenue--

select top 5 pizza_name, SUM(total_price) as total_revenue
from [pizza_sales-_6_]
group by pizza_name
order by total_revenue asc

---I. Top 5 Pizzas by Quantity--

select top 5 pizza_name, sum(quantity) as total_pizza_sold
from [pizza_sales-_6_]
group by pizza_name
order by total_pizza_sold desc

--- J. Bottom 5 Pizzas by Quantity---

select top 5 pizza_name, sum(quantity) as total_pizza_sold
from [pizza_sales-_6_]
group by pizza_name
order By total_pizza_sold asc

--K. Top 5 Pizzas by Total Orders---

select top 5 pizza_name, count(order_id) as total_orders
from [pizza_sales-_6_]
group by pizza_name
order by total_orders desc

---L. Borrom 5 Pizzas by Total Orders---

select top 5 pizza_name, COUNT(distinct order_id) as total_order
from [pizza_sales-_6_]
group by pizza_name
order by total_order asc

---pizza_category or pizza_size filters---

select top 5 pizza_name,COUNT(distinct order_id) as total_orders
from [pizza_sales-_6_]
where pizza_category = 'Classic'
group by pizza_name
order by total_orders asc