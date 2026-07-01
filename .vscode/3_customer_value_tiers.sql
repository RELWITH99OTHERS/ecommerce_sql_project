/*
PROJECT QUESTION 3: Customer Value Tiers (Dynamic Segmentation)

BUSINESS SCENARIO: 
The product team is launching a new loyalty rewards program. We need to 
dynamically segment our paying customer base into 3 equal tiers based entirely 
on their historical successful lifetime spend.
*/
with vip_revenue as (select
    customers.customer_id,
    first_name,
    last_name,
    ROUND( SUM( order_items.quantity * order_items.unit_price * (1 - discount_pct / 100)), 2) AS revenue
from
    customers
    inner join orders on customers.customer_id = orders.customer_id
    inner join order_items on orders.order_id = order_items.order_id
where
    orders.order_status NOT IN ('Cancelled', 'Returned')
group by
    first_name,
    last_name,
    customers.customer_id
)

select
    customer_id,
    first_name,
    last_name,
    revenue,
    ntile(3) over( order by revenue desc) as vip_tier
from
    vip_revenue