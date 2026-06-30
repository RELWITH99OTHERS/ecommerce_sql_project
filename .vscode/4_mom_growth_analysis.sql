/*
PROJECT QUESTION 4: Month-over-Month (MoM) Growth Analysis

BUSINESS SCENARIO: 
Executive leadership needs a high-level financial momentum matrix for our monthly 
investor reporting dashboard to see if corporate growth is accelerating or lagging.
*/

with monthly_revenue as (select
    DATE_TRUNC ('MONTH', order_date) :: DATE as month,
    ROUND( SUM( order_items.quantity * order_items.unit_price * (1 - discount_pct / 100)), 2) AS revenue
from
    orders
    inner join order_items on orders.order_id = order_items.order_id
where
    orders.order_status NOT IN ('Cancelled', 'Returned')
group by
     DATE_TRUNC ('MONTH', order_date) :: DATE
)

select
    month,
    revenue,
    lag(revenue, 1) over(order by month) as previous_month
from
    monthly_revenue

