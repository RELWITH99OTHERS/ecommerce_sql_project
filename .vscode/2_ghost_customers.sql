/*
PROJECT QUESTION 2: CRM Audit — Finding "Ghost" Accounts

BUSINESS SCENARIO: 
The marketing team is paying a subscription fee for our CRM platform based on 
total user count. They need to identify completely inactive accounts to purge 
them or target them with a specialized re-engagement campaign.
*/

select
    customers.customer_id,
    customers.first_name,
    customers.last_name,
    orders.order_date
from customers
    left join orders on customers.customer_id = orders.customer_id
where
    order_id is null
