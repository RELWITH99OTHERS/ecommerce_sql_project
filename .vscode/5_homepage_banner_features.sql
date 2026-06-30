/*
PROJECT QUESTION 5: High-Value Homepage Banner Features

BUSINESS SCENARIO: 
The merchandising team wants to dynamically feature the top 2 premium 
(most expensive) products within each individual product category on the 
website's main slider banner. Price ties must be included gracefully.

*/
with produc_rank as (select
    product_name,
    category,
    dense_rank() over(partition by category order by unit_price) as ranks
from
    products
)

select
    category,
    product_name,
    ranks
from
    produc_rank
where ranks <= 2