/*
PROJECT QUESTION 6: Customer Retention & Time-to-Return

BUSINESS SCENARIO: 
The customer retention team wants to analyze our user behavioral loop. Specifically, 
we need to track individual timelines to find how many days pass between a 
customer's current order and their previous order. y

*/
SELECT 
    customer_id,
    order_id,
    order_date,
    LAG(order_date, 1) OVER(
        PARTITION BY customer_id 
        ORDER BY order_date ASC) AS previous_order_date,
    order_date - LAG(order_date, 1) OVER(
        PARTITION BY customer_id 
        ORDER BY order_date ASC) AS days_since_last_purchase
FROM 
    orders
WHERE 
    order_status NOT IN ('Cancelled', 'Returned')
ORDER BY 
    customer_id, order_date;
