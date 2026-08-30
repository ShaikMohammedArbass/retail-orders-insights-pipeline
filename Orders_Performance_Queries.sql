# Find top 10 highest revenue generating products
select product_id,sum(sale_price) as sales 
from df_orders
group by product_id
order by sales desc
limit 10;


# Find top 5 highest selling products in each region
with cte as(
select region,product_id,sum(sale_price) as sales 
from df_orders
group by region,product_id)
select * from(
select *,
row_number() over(partition by region order by sales desc ) as rnk
from cte) a
where rnk<= 5;


#Find month over month growth comparison for 2022 and 2023 sales eg : jan 2022 vs jan 2023
with cte as(
select year(order_date) as order_year,month(order_date) as order_month,sum(sale_price) as sales 
from df_orders
group by order_year,order_month)
select order_month,
sum(case when order_year = 2022 then sales else 0 end) as sales_2022
,sum(case when order_year = 2023 then sales else 0 end) as sales_2023
from cte
group by order_month
order by order_month;


#for each category which month had highest sales
with cte as(
select category,date_format(order_date,'%Y%m') as order_year_month,sum(sale_price) as sales
from df_orders
group by category,date_format(order_date,'%Y%m'))
select * from(
select *,
row_number() over(partition by category order by sales desc) as rnk
from cte) a
where rnk =1;


# which sub category had highest growth by profit in 2023 compare to 2022
with cte as (
    select 
        sub_category,
        year(order_date) as order_year,
        sum(profit) as total_profit
    from df_orders
    group by sub_category, year(order_date)
),
cte2 as (
    select 
        sub_category,
        sum(case when order_year = 2022 then total_profit else 0 end) as profit_2022,
        sum(case when order_year = 2023 then total_profit else 0 end) as profit_2023
    from cte
    group by sub_category
)
select *,
    (profit_2023 - profit_2022) as profit_growth
from cte2
order by profit_growth desc
limit 1;





