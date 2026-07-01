/*
PROJECT QUESTION 1: Category Financial Performance Matrix

BUSINESS SCENARIO: 
The marketing team needs to know which product categories drive the most net 
revenue to optimize advertising spend allocations.
*/


select 
    category,
    SUM(order_items.quantity)AS total_item_sold
from
    products
    inner join order_items on products.product_id = order_items.product_id
    inner join orders on order_items.order_id = orders.order_id
where
    order_status NOT IN ('Cancelled', 'Returned')
group by
    category
order by
    total_item_sold desc